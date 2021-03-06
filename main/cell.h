#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
public:
  bool visit;
  bool wall[4];
  bool dead;
  int floodValue;
  int compassHome;
  int branch;
  
  int x;
  int y;
  bool goal;
  bool existance;

  volatile Cell *cellNorth;
  volatile Cell *cellSouth;
  volatile Cell *cellEast;
  volatile Cell *cellWest;
};

#endif
