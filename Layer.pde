/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class Layer extends Component {

  protected DataTable table;
  protected VisualSet graphics;

  Layer(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  void setVisualSet(VisualSet _graphics) {
    graphics = _graphics;
    _graphics.layer = this;
  }

  void setDataTable(DataTable _table) {
    table = _table;
    _table.layer = this;
  }

  VisualSet getVisualSet() {
    return graphics;
  }

  DataTable getDataTable() {
    return table;
  }

  void setSymbolTable(SymbolTable _symbolTable) {
    graphics.setSymbolTable(_symbolTable);
  }

  void setColorMap(ColorMap _colorMap) {
    graphics.setColorMap(_colorMap);
  }

  void selectedShape(int shapeId) {
  }
  
  void selectedRow(int rowId) {
  }
  
  void update() {
    graphics.update();
  }

  FBounds getExtent() { 
    return graphics.getExtent();
  }

  void draw(PGraphics pg) {
    graphics.draw(pg, (View)parent);
  }
  
  void mousePressed(FPoint p) {
    graphics.mousePressed(p);
  }
}

