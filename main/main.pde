#include "global.h"

void setup()
{
  //pin setup
  pinMode(sensorFrontLeft,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);  //int sensorSideRight
  
  pinMode(ledOne,OUTPUT);  //int led
  pinMode(ledTwo,OUTPUT);  //int led
  pinMode(ledThree,OUTPUT);  //int led
  
  pinMode(PWMLeft, PWM);
  pinMode(motorLeft1, OUTPUT);
  pinMode(motorLeft2, OUTPUT);
  pinMode(PWMRight, PWM);
  pinMode(motorRight1, OUTPUT);
  pinMode(motorRight2, OUTPUT);  
  pinMode(STBY, OUTPUT);
  digitalWrite(STBY, HIGH);
  
  pinMode(encoderLeftCLK, INPUT);
  pinMode(encoderLeftDirc, INPUT);
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDirc, INPUT);

  //global interrupts for sensor
  Timer4.pause();
  Timer4.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72000 = 1kHz
  Timer4.setPeriod(sensorRate);                        // Set up period, 1period = 1 ms
  Timer4.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer4 is pin D16
  Timer4.setCompare(TIMER_CH1, 1);                     // Interrupt for every 1 update
  Timer4.attachCompare1Interrupt(sensorInterrupt);     // the function that will be called
  Timer4.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer4.resume();                                     // Start the timer counting
  
  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);

}

/*===================  Interrput functions  =======================*/
void sensorInterrupt(void)
{
  //push back current status to old status array
  for (int i=9; i>0; i--)
    oldStatus[i] = oldStatus[i-1];
  oldStatus[0] = status;
  //update current status
  sensor.runAllSensor();
}

void decoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.leftWheelCount++;
  else
    status.leftWheelCount--;
}

void decoderRightInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.rightWheelCount++;
  else
    status.leftWheelCount--;
}
/*===================  End Interrput functions  =======================*/

void loop()
{
  //initialize for the beginning
  if(initialize == false)
  {
    maze.initialize();
    status.initialize();
    initialize = true;
  }
  
  //if dist count % 14 == 0, cell++  (14 counts gives 18cm if 1 rotate = 150 counts)
  
  
  //if side sensor has jump, cell++
  
  
  
  
  
  //go staright if no wall,
  
  
  //if other path, turn right first
  
  
  //if wall stop
  
  
  //
  
  

}
  




