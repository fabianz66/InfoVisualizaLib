/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class Bounds {
  
  int xMin = MAX_INT;
  int yMin = MAX_INT;
  int xMax = MIN_INT;
  int yMax = MIN_INT;
  
  int width() { return xMax-xMin;}
  int height() { return yMax-yMin;}
  
  void translate(int x,int y) {
    int w = width();
    int h = height();
    xMin=x;
    yMin=y;
    xMax=x+w;
    yMax=y+h;
  }
  
 void size(int w,int h) {
    xMax = xMin+w;
    yMax = yMin+h;
  }
  
  boolean contains(Point pnt) {
    return (pnt.x >= xMin && pnt.x <= xMax && 
            pnt.y >= yMin && pnt.y <= yMax);
  }
 
  boolean overlap(Bounds bnds) {
    return (xMin <= bnds.xMax && bnds.xMin <= xMax &&
            yMin <= bnds.yMax && bnds.yMin <= yMax);
  }
}
