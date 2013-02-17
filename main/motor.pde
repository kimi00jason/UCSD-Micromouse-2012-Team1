
#include "motor.h"

void Motor::fixOrientation()
{
  int correction = orientationConstant * status.orientation;
  motorRight(speedRight + correction);
  motorLeft(speedLeft - correction);
}

void Motor::stop()
{
  motorLeft(0);
  motorRight(0);
}

//for passing the first mouse test assignment
void Motor::driveStraight(int speed)
{
  motorRight(speed);
  motorLeft(speed);
}

void Motor::turnLeft(int speed)
{
  motorLeft(speed);
  motorRight(speed*(5/16));
}

void Motor::turnRight(int speed)
{
  motorLeft(speed*(5/16));
  motorRight(speed);
}

//if deadend then go turn back
void Motor::turnBack()
{
  int currentLeftCount = status.leftWheelCount;
  int currentRightCount = status.rightWheelCount;
  
  motorLeft(-fullSpeed/1000);
  motorRight(fullSpeed/1000);
}

void Motor::driveLeft(int speed)
{
  motorLeft(speed);
  motorRight(speed/turnRatio);
}

void Motor::driveRight(int speed)
{
  motorLeft(speed/turnRatio);
  motorRight(speed);
}



/*===================  private functions  =======================*/

void Motor::motorLeft(int speed)
{
  speedLeft = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
  }
  else
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, speed);
  } 
}

void Motor::motorRight(int speed)
{
  speedRight = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
  }
  else
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, speed); 
  }
}

