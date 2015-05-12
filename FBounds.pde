/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class FBounds {
  
  float xMin= MAX_FLOAT;
  float yMin = MAX_FLOAT;
  float xMax = MIN_FLOAT;
  float yMax = MIN_FLOAT;
  
  FBounds() {};
  
  FBounds(float _xMin,float _yMin,float _xMax,float _yMax) {
    xMin = _xMin; yMin = _yMin; xMax = _xMax; yMax = _yMax;
  }
  
  float width() { return xMax-xMin;}
  float height() { return yMax-yMin;}
  
  void translate(float x, float y) {
    float w = width();
    float h = height();
    xMin=x;
    yMin=y;
    xMax=x+w;
    yMax=y+h;
  }
  
 void size(float w, float h) {
    xMax = xMin+w;
    yMax = yMin+h;
  }
  
  boolean contains(FPoint pnt) {
    return (pnt.x >= xMin && pnt.x <= xMax && 
            pnt.y >= yMin && pnt.y <= yMax);
  }
 
  boolean overlap(FBounds bnds) {
    return (xMin <= bnds.xMax && bnds.xMin <= xMax &&
            yMin <= bnds.yMax && bnds.yMin <= yMax);
  }
  
  boolean overlap(float _xMin,float _xMax,float _yMin,float _yMax) {
    return (xMin <= _xMax && _xMin <= xMax &&
            yMin <= _yMax && _yMin <= yMax);
  }
}
