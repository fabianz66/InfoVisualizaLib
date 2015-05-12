/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class Symbol {
  float[] coords;
  FBounds bounds;

  void setup(float x, float y, float w, float h, int location, float[] xycoords) {
    float xoffset=0, yoffset=0;
    bounds = new FBounds();
    for (int i=0; i<xycoords.length; i+=2) {
      if (xycoords[i]<bounds.xMin) bounds.xMin = xycoords[i];
      if (xycoords[i]>bounds.xMax) bounds.xMax = xycoords[i];
      if (xycoords[i+1]<bounds.yMin) bounds.yMin = xycoords[i+1];
      if (xycoords[i+1]>bounds.yMax) bounds.yMax = xycoords[i+1];
    }
    if (location==CENTER) {
      xoffset=0; 
      yoffset=0;
    } else if (location==LEFT) {
      xoffset=-bounds.xMax; 
      yoffset=0;
    } else if (location==RIGHT) {
      xoffset=+bounds.xMin; 
      yoffset=0;
    } else if (location==TOP) {
      xoffset=0; 
      yoffset=+bounds.yMin;
    } else if (location==BOTTOM) {
      xoffset=0; 
      yoffset=-bounds.yMax;
    }
    bounds = new FBounds();
    coords = new float[xycoords.length];
    for (int i=0; i<xycoords.length; i+=2) {
      coords[i] = (xoffset+xycoords[i])*w+x;
      coords[i+1] = (yoffset+xycoords[i+1])*h+y;
      if (coords[i]<bounds.xMin) bounds.xMin = coords[i];
      if (coords[i]>bounds.xMax) bounds.xMax = coords[i];
      if (coords[i+1]<bounds.yMin) bounds.yMin = coords[i+1];
      if (coords[i+1]>bounds.yMax) bounds.yMax = coords[i+1];
    }
  }

  boolean overlap(FBounds extent) {
    return extent.overlap(bounds);
  }
}

