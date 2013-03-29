
#include "sensor.h"

/*===================  public function  =======================*/
void Sensor::runAllSensor()
{ 
  //run both front sensor to get better reading
  int frontReading[3];
  frontReading[1] = runSensor(sensorFrontLeft);
  frontReading[2] = runSensor(sensorFrontRight);
  frontReading[0] = frontReading[1]<frontReading[2] ? frontReading[1] : frontReading[2];
  
  //update raw value to status
  status.frontVolt = frontReading[0];
  status.sideLeftVolt = (runSensor(sensorSideLeft));
  status.sideRightVolt = (runSensor(sensorSideRight));
  status.diagonalLeftVolt = (runSensor(sensorDiagonalLeft));
  status.diagonalRightVolt = (runSensor(sensorDiagonalRight));
 
  //update sensor value to status
  status.frontDist = convertDistance(status.frontVolt);
  status.sideLeftDist = convertDistance(status.sideLeftVolt);
  status.sideRightDist = convertDistance(status.sideRightVolt);
  status.diagonalLeftDist = convertDistance(status.diagonalLeftVolt);
  status.diagonalRightDist = convertDistance(status.diagonalRightVolt);
  
  //update position value to status
  setOrientation();
  setDeviation();
}



/*===================  private functions  =======================*/

//controll individual sensor
int Sensor::runSensor(int sensorRef)
{
  //obtain dark voltage with IR turned off
  digitalWrite(ledOne, LOW);
  digitalWrite(ledTwo, LOW);
  digitalWrite(ledThree, LOW);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);   //read voltage
    idleVoltage += voltageTemp;            //sum all the voltage reading
    delay(sampleRate);
  }
  idleVoltage /= sampleNum;                //get average reading
  
  //obtain active voltage with IR turned on
  togglePin(ledOne);
  togglePin(ledTwo);
  togglePin(ledThree);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);    //read voltage
    activeVoltage += voltageTemp;           //sum all the voltage reading
    delay(sampleRate);
  }
  activeVoltage /= sampleNum;                     //get average reading
  resultVoltage = activeVoltage - idleVoltage;    //get result of difference between dark and active voltage
  return convertDistance(activeVoltage);
}


/*===================  conversion functions  =======================*/
int Sensor::convertDistance(int voltage)
{ return (1 / pow(voltage, 2) * 66.4 - 4.28); }  // X = 1/V^2 ; Dist = 66.4X - 4.28

void Sensor::setOrientation()
{ status.orientation = status.diagonalLeftDist - status.diagonalRightDist; }

void Sensor::setDeviation()
{ status.deviation = status.sideLeftDist - status.sideRightDist; }


