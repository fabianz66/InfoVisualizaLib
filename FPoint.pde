/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class FPoint {
  float x,y;
  
  FPoint(float _x, float _y) {
    x = _x; y = _y;
  }
  
  boolean contains(float xMin,float xMax,float yMin,float yMax) {
    return (x >= xMin && x <= xMax && y >= yMin && y <= yMax);
  }
}
