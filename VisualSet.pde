/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class VisualSet {
  
  public ColorMap colorMap = new ColorMap();
  public SymbolTable symbolTable = new SymbolTable();
  boolean selectable=true;

  FBounds extent;
  boolean modified = true;
  Layer layer;
  
  FBounds getExtent() {
    return new FBounds();
  }
  
  void setColorMap(ColorMap _colorMap) {
    colorMap = _colorMap;
  }
  
  void setSymbolTable(SymbolTable _symbolTable) {
    symbolTable = _symbolTable;
  }
  
  void setSelectionMode(boolean mode) {
    selectable = mode;
  }
  
  void selectedShape(int shapeId) {
  }
  
void update() {}
  
  void draw(PGraphics pg, View view) {}
  
  void mousePressed(FPoint p) {}

  void mouseMoved(FPoint p) {}

  void mouseDragged(FPoint p) {}

  void mouseReleased() { }

  void keyPressed() {}

}

