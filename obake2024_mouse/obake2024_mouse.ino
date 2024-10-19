/***************************************************
  名前: 稲友祭2024「IT×お化け屋敷」自走マウス
****************************************************/

#include <ArduinoJson.h>

#include <HTTPClient.h>

#define MOTOR_A_PIN 25
#define MOTOR_B_PIN 26

String ssid = "hopter_wifi";
String pwd = "hopter_1450";

const IPAddress ip(192, 168, 0, 203);
const IPAddress gateway(192, 168, 0, 1);
const IPAddress subnet(255, 255, 255, 0);

String url = "http://192.168.0.115:8888/WORKS/NBU/toyusai2024_dev/server/flag";

enum MOTOR_ACTION {
  MOTOR_ACTION_FORWARD,
  MOTOR_ACTION_BACK,
  MOTOR_ACTION_BRAKE
};

MOTOR_ACTION motor = MOTOR_ACTION_FORWARD;

void setup()
{
  Serial.begin(9600);

  pinMode(MOTOR_A_PIN, OUTPUT);
  pinMode(MOTOR_B_PIN, OUTPUT);

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

      bool value = doc[0];
      Serial.println(value ? "true" : "false");

      if (value)
      {
        driveMotor();
        delay(5000);
        motor = MOTOR_ACTION_BRAKE;
        driveMotor();
      }
    }
  }
  http.end();

  delay(5000);

}

void driveMotor()
{
  if (motor == MOTOR_ACTION_FORWARD)
  {
    digitalWrite(MOTOR_A_PIN, HIGH);
    digitalWrite(MOTOR_B_PIN, LOW);
  }
  else if (motor == MOTOR_ACTION_BACK)
  {
    digitalWrite(MOTOR_A_PIN, LOW);
    digitalWrite(MOTOR_B_PIN, HIGH);
  }
  else if (motor == MOTOR_ACTION_BRAKE)
  {
    digitalWrite(MOTOR_A_PIN, LOW);
    digitalWrite(MOTOR_B_PIN, LOW);
  }
}
