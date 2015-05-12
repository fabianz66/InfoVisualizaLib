/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class Container extends Component {
  Component currentFocus;
  Component[] children;
  int childrenCount=0;
  int maxSize=100;
  
  Container(int x,int y,int w,int h) {
    super(x,y,w,h);
    children = new Component[maxSize];
  }
  
  void add(Component child) {
    children[childrenCount++] = child;
    child.parent = this;
  }
  
  void draw(PGraphics p) {
    for (int i=0; i<childrenCount; i++)
      if (children[i].visible)
        children[i].draw(p);
  }
  
  void mousePressed(FPoint p) {
    for (int i=0; i<childrenCount; i++)
        children[i].mousePressed(p);
  }
  
  void mouseMoved(FPoint p) {
    for (int i=0; i<childrenCount; i++)
      if (children[i].bounds.contains(p)) {
        children[i].mouseMoved(p);
        currentFocus = children[i];
        break;
      }
  }
  
  void mouseDragged(FPoint p) {
    for (int i=0; i<childrenCount; i++)
      if (children[i].bounds.contains(p))
        children[i].mouseDragged(p);
  }
  
  void mouseReleased() {
    for (int i=0; i<childrenCount; i++)
        children[i].mouseReleased();
  }
  
  void keyPressed() {
    for (int i=0; i<childrenCount; i++)
        children[i].keyPressed();
  }
}
