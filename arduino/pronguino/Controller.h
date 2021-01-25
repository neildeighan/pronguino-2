/*
   Controller.h - Library Header file for Controller.

   @author Neil Deighan
*/

// Safe guards against including more than once
#ifndef CONTROLLER_H
#define CONTROLLER_H

// Include the Arduino library
#include <Arduino.h>

// Declaration of Controller class
class Controller
{
  public:
    Controller();
    Controller(int pin);
    int read();
  private:
    int _pin;
};

#endif
