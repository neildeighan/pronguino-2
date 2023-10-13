/**
  pronguino.ino - Main file for controllers

  https://neildeighan.com/pronguino-2/

  Parts required:
  - 2 x 10 kilohm potentiometers

  @author  Neil Deighan

*/

// Include the Controller library
#include "Controller.h"

// Define constants
const int CONTROLLER_COUNT = 2;
const int CONTROLLER_ONE = 0;
const int CONTROLLER_TWO = 1;
const int CONTROLLER_ONE_ANALOG_PIN = A1;
const int CONTROLLER_TWO_ANALOG_PIN = A2;

// Special constant to turn on / off testing mode
const bool TESTING = false;

// Declare controllers
Controller controllers[CONTROLLER_COUNT];

/**
  Setup the serial communications and controllers
*/
void setup() {

  // Initialize serial communication
  Serial.begin(9600);

  // Create Controllers
  controllers[CONTROLLER_ONE] = Controller(CONTROLLER_ONE_ANALOG_PIN);
  controllers[CONTROLLER_TWO] = Controller(CONTROLLER_TWO_ANALOG_PIN);

  // Print debug headers
  if (TESTING) {
    resultsHeader();
  }

}

/**
  Continuously read/write controller values
*/
void loop() {

  // Read the values from each controller
  int controllerValue1 = controllers[CONTROLLER_ONE].read();
  int controllerValue2 = controllers[CONTROLLER_TWO].read();

  // Convert to nibbles
  byte highNibble = (byte) controllerValue1 << 4;
  byte lowNibble  = (byte) controllerValue2;
  
  // Combine the two nibbles to make a byte
  byte data = highNibble | lowNibble;

  if (TESTING) {
    // Print results detail
    resultsDetail(controllerValue1, controllerValue2, highNibble, lowNibble, data);
  } else {
    // Write the data to serial port
    Serial.write(data);
  }

  // Delay 150 milliseconds
  delay(150);
}

/**
   Print Results Header to Serial Monitor
*/
void resultsHeader() {
  Serial.print("controllerValue1\t");
  Serial.print("controllerValue2\t");
  Serial.print("highNibble\t");
  Serial.print("lowNibble\t");
  Serial.print("data\t");
  Serial.println();
}

/**
   Print Results Detail to Serial Monitor
*/
void resultsDetail(int controllerValue1, int controllerValue2, byte highNibble, byte lowNibble, byte data) {
  Serial.print(controllerValue1); Serial.print("\t\t\t");
  Serial.print(controllerValue2); Serial.print("\t\t\t");
  Serial.print(highNibble); Serial.print("\t\t");
  Serial.print(lowNibble); Serial.print("\t\t");
  Serial.println(data);
  
  // Slow it down a bit, so can be read, waits one second
  delay(1000);
}
