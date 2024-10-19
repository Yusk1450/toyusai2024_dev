/***************************************************
  名前: 稲友祭2024「IT×お化け屋敷」照明
****************************************************/
#include <ArduinoJson.h>

#include <HTTPClient.h>

#define DEVICE_NO 3
#define LIGHT_PIN 26

String ssid = "hopter_wifi";
String pwd = "hopter_1450";

const IPAddress ip(192, 168, 0, 202);
const IPAddress gateway(192, 168, 0, 1);
const IPAddress subnet(255, 255, 255, 0);

String url = "http://192.168.0.115:8888/WORKS/NBU/toyusai2024_dev/server/flag";

void setup()
{
  Serial.begin(9600);

  pinMode(LIGHT_PIN, OUTPUT);

  #ifdef ESP_PLATFORM
    WiFi.disconnect(true, true);  // disable wifi, erase ap info
    delay(1000);
    WiFi.mode(WIFI_STA);
  #endif
    WiFi.begin(ssid.c_str(), pwd.c_str());
    WiFi.config(ip, gateway, subnet);

    Serial.println("Wifi Connecting");
    while (WiFi.status() != WL_CONNECTED) {
      delay(150);
      Serial.println(".");
    }

    Serial.println("Initializing complete");
}

void loop()
{
  HTTPClient http;

  http.begin(url);
  int httpCode = http.GET();

  if(httpCode > 0)
  {
    if(httpCode == HTTP_CODE_OK)
    {
      String payload = http.getString();
      Serial.println(payload);

      DynamicJsonDocument doc(1024);
      DeserializationError error = deserializeJson(doc, payload);

      if (error)
      {
        Serial.println("JSON Parse error");
        return;
      }
      if (DEVICE_NO == 1)
      {
        bool value = doc[0];
        digitalWrite(LIGHT_PIN, value ? LOW : HIGH);
      }
      else if (DEVICE_NO == 2)
      {
        bool value0 = doc[0];
        bool value1 = doc[1];

        if (value0 && !value1)
        {
          digitalWrite(LIGHT_PIN, HIGH);
          Serial.println("HIGH");
        }
        else
        {
          digitalWrite(LIGHT_PIN, LOW);
          Serial.println("LOW");
        }
      }
      else if (DEVICE_NO == 3)
      {
        bool value0 = doc[2];
        bool value1 = doc[3];

        if (value0 && !value1)
        {
          digitalWrite(LIGHT_PIN, HIGH);
          Serial.println("HIGH");
        }
        else
        {
          digitalWrite(LIGHT_PIN, LOW);
          Serial.println("LOW");
        }
      }
      
    }
  }
  http.end();

  delay(1000);
}
