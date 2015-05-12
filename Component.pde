/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class Component {
  Container parent;
  color fill=255;
  color stroke=0;
  int weight=1;
  FBounds bounds;
  boolean visible=true;
  boolean selected=false;
  
  Component(int x,int y,int w,int h) {
    bounds = new FBounds(x,y,x+w,y+h);
  }
  
  void setupStyle(PGraphics pg) {
    pg.fill(fill);
    pg.stroke(stroke);
    pg.strokeWeight(weight);
  }
  
  void draw(PGraphics pg) {}
  
  void mousePressed(FPoint p) {}
  
  void mouseMoved(FPoint p) {}
   
  void mouseDragged(FPoint p) {}
  
  void mouseReleased() {}
  
  void keyPressed() {}
  
  void translate(float x, float y) {
    bounds.translate(x,y);
  }
  
  void size(float w, float h) {
    bounds.size(w,h);
  }
}
