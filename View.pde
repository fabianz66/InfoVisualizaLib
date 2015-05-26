/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class View extends Container {
  PGraphics pg;
  FBounds extent;
  float scale;
  float xCenter, yCenter;
  PFont helvetica;

  View(int x, int y, int w, int h) {
    super(x, y, w, h);
    pg = createGraphics(w, h);
    helvetica = createFont("Helvetica-Bold", 13);
    pg.textFont(helvetica);
  }

  void setAttr(color _stroke, color _fill, int _weight) {
    stroke = _stroke;
    fill = _fill;
    weight = _weight;
  }

  void draw(PGraphics _pg) {
    pg.beginDraw();
    super.setupStyle(pg);
    pg.rect(0, 0, bounds.width()-1, bounds.height()-1);
    super.draw(pg);
    pg.endDraw();
    image(pg, bounds.xMin, bounds.yMin, bounds.width(), bounds.height());
  }

  void pan(int direction, int offset) { 
    if (direction==DOWN) {
      extent.yMin -= offset/scale;
      extent.yMax -= offset/scale;
    } else if (direction==UP) {
      extent.yMin += offset/scale;
      extent.yMax += offset/scale;
    } else if (direction==RIGHT) {
      extent.xMin -= offset/scale;
      extent.xMax -= offset/scale;
    } else if (direction==LEFT) {
      extent.xMin += offset/scale; 
      extent.xMax += offset/scale;
    }
  }

  void zoomToExtent(FBounds extnt) {
    extent = extnt;
    _zoomToExtent();
  }

  void _zoomToExtent() {
    float lWidth = extent.xMax-extent.xMin;
    float lHeight = extent.yMax-extent.yMin;
    scale = max(bounds.width()/lWidth, bounds.height()/lHeight);
    xCenter=bounds.width()/2; 
    yCenter=bounds.height()/2;
  }

  void zoomToScale(float scl) { 
    scale = scl;
  }

  void zoomOut(int offset) {
    extent.xMin -= offset/scale;
    extent.xMax += offset/scale;
    extent.yMin -= offset/scale;
    extent.yMax += offset/scale;
    zoomToExtent(extent);
  }

  void zoomIn(int offset) { 
    extent.xMin += offset/scale;
    extent.xMax -= offset/scale;
    extent.yMin += offset/scale;
    extent.yMax -= offset/scale;
    zoomToExtent(extent);
  }

  void translateCenter(float x, float y) {
    extent.xMin += x/scale; 
    extent.xMax += x/scale;
    extent.yMin -= y/scale; 
    extent.yMax -= y/scale;
  }

  void mousePressed(FPoint p) {
    float xMid = (extent.xMax+extent.xMin)/2;
    float yMid = (extent.yMax+extent.yMin)/2;
    float xCoord = (p.x-xCenter-bounds.xMin)/scale+xMid;
    float yCoord = (yCenter-p.y+bounds.yMin)/scale+yMid;
    super.mousePressed(new FPoint(xCoord, yCoord));
  }

  void mouseMoved(FPoint p) {
    if (bounds.contains(p))
      super.mouseMoved(new FPoint(p.x-bounds.xMin, p.y-bounds.yMin));
  }

  void mouseDragged(FPoint p) {
    if (bounds.contains(p))
      super.mouseDragged(new FPoint(p.x-bounds.xMin, p.y-bounds.yMin));
  }

  void mouseReleased() {
    super.mouseReleased();
  }

  void keyPressed() {
    if (keyCode == TAB)
      zoomIn(10);
    if (keyCode == BACKSPACE)
      zoomOut(10);
    if (keyCode == UP)
      pan(UP, 10);
    else if (keyCode == DOWN)
      pan(DOWN, 10);
    else if (keyCode == RIGHT)
      pan(RIGHT, 10);
    else if (keyCode == LEFT)
      pan(LEFT, 10);
  }
}

