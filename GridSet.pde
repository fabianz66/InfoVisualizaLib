/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class GridSet extends VisualSet {
  PImage img;
  int ncols,nrows;
  float xcorner, ycorner;
  float cellsize;
  int nodata;
  int[] values;
  
  GridSet() {}
  
  GridSet(int _ncols, int _nrows, float _xcorner, float _ycorner, float _cellsize, int _nodata) {
    ncols = _ncols; nrows= _nrows;
    xcorner = _xcorner; ycorner = _ycorner;
    cellsize = _cellsize; nodata = _nodata;
  }
  
  FBounds getExtent() {
    return new FBounds(xcorner,ycorner,xcorner+ncols*cellsize,ycorner+nrows*cellsize);
  }
  
  void setup() {
    img = createImage(ncols,nrows,RGB);
    img.loadPixels();
  }
  
  void cell(int row,int col,int value) {
    if (values==null)
      values = new int[ncols*nrows];
    values[row*ncols+col]  = value;
  }
  
  void update() {
    int min=MAX_INT,max=MIN_INT;
    for (int i=0;i<ncols*nrows;i++) {
      if (values[i]==nodata) continue;
      if (values[i]<min) min=values[i];
      if (values[i]>max) max=values[i];
    }
    for (int i=0;i<ncols*nrows;i++) {
      if (values[i]==nodata||values[i]<0) continue;
      img.pixels[i] = colorMap.getColor(values[i],min,max);
      //img.pixels[i] = colorMap.getColor(values[i]);
    }
    img.updatePixels();
  }
  
  void draw(PGraphics pg, View view) {
    FBounds vExtent = view.extent;
    float scl = view.scale;
    float cx = view.xCenter;
    float cy = view.yCenter;
    float xMid = (vExtent.xMax+vExtent.xMin)/2;
    float yMid = (vExtent.yMax+vExtent.yMin)/2;
    pg.image(img,(xcorner-xMid)*scl+cx,(yMid-ycorner-(nrows*cellsize))*scl+cy,
                 (ncols*cellsize)*scl,(nrows*cellsize)*scl);
  }
}

