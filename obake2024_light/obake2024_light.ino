/***************************************************
  名前: 稲友祭2024「IT×お化け屋敷」照明
****************************************************/
#include <ArduinoJson.h>

#include <HTTPClient.h>

#define DEVICE_NO 1
#define LIGHT_PIN 26

String ssid = "4DP";
String pwd = "4dp_1450";

const IPAddress ip(10, 23, 16, 52);
const IPAddress gateway(10, 23, 16, 1);
const IPAddress subnet(255, 255, 255, 0);

String url = "http://10.23.16.63:8888/WORKS/NBU/toyusai2024_dev/server/flag";

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

      bool value = doc[DEVICE_NO-1];
      Serial.println(value ? "true" : "false");

      digitalWrite(LIGHT_PIN, value ? HIGH : LOW);
    }
  }
  http.end();

  delay(5000);

}
