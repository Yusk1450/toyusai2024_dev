/***************************************************
  名前: 稲友祭2024「IT×お化け屋敷」照明
****************************************************/

#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

#include "Keyboard.h"

Adafruit_MPU6050 mpu;

void setup()
{
  Serial.begin(9600);
  while (!Serial);
  delay(10);

  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    return;
  }

  mpu.setHighPassFilter(MPU6050_HIGHPASS_0_63_HZ);
  mpu.setMotionDetectionThreshold(1);
  mpu.setMotionDetectionDuration(20);
  mpu.setInterruptPinLatch(true);	// Keep it latched.  Will turn off when reinitialized.
  mpu.setInterruptPinPolarity(true);
  mpu.setMotionInterrupt(true);

  Keyboard.begin();

  Serial.println("Initializing complete");
  delay(100);
}

void loop()
{
  if(mpu.getMotionInterruptStatus()) {
    sensors_event_t a, g, temp;
    mpu.getEvent(&a, &g, &temp);

    double x = a.acceleration.x;
    double y = a.acceleration.y;
    double z = a.acceleration.z;
    
    double accel = sqrt(x * x + y * y + z * z);
    Serial.println(accel);

    // if (accel > )
    // {
    //   Keyboard.press(KEY_SPACE);
    //   delay(300);
    //   Keyboard.release(KEY_SPACE);

    //   // 連続で振れないようにする
    //   delay(2000);
    // }
  }

  delay(10);
}
