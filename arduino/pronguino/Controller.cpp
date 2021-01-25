/*
  Controller.cpp - Implementation of Controller.

  @author Neil Deighan
*/

#include "Controller.h"

/**
   Default Class Constructor
*/
Controller::Controller() {}

/**
  Class Constructor

  @param  pin analog pin number connected to potentiometer
*/
Controller::Controller(int pin)
{
  _pin = pin;
}

/**
   Reads value from analog pin connected to potentiometer

   @return  value
*/
int Controller::read()
{
  // Reads value from pin, which would be a value mapped from 0 to 5V (0 to 1023)
  int pinValue = analogRead(_pin);

  // Small delay to allow the Analog-to-Digital Converter (ADC) to process
  delay(1);

  // Map the pin value to number between 0 and 15
  int value = map(pinValue, 0, 1023, 0, 15);

  return value;
}
