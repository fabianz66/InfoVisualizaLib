/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class GraphicApp {
  Container views;
  View focusView;
  
  GraphicApp(int _w,int _h) {
    views = new Container(0,0,_w,_h);
  }
  
  void add(View view) {
    views.add(view);
    focusView = view;
  }
  
  void draw() {
    views.draw(null);
  }
  
  void mousePressed() {
    FPoint p = new FPoint(mouseX, mouseY);
    views.mousePressed(p);
  }
  
  void mouseMoved() {
    FPoint p = new FPoint(mouseX, mouseY);
    views.mouseMoved(p);
  }
  
  void mouseDragged() {
    FPoint p = new FPoint(mouseX, mouseY);
    views.mouseDragged(p);
  }
  
  void mouseReleased() {
    views.mouseReleased();
  }
  
  void keyPressed() {
    views.keyPressed();
  }
}
