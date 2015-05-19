/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;
int[] data = { 
  30, 10, 45, 35, 60, 38, 75, 67
};

float[] coords;

void setup() {
  Ejemplo2_X();
}


void Ejemplo2_1() {
  size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  GraphicSet set = new GraphicSet();

  int i = set.newShape(GraphicSet.AREA);
  set.vertex(123.0, 134.0);
  set.vertex(245.0, 276.0);
  set.vertex(131.0, 223.0);
  set.setLabel(i, "HOLA");
  i = set.newShape(GraphicSet.MARK);
  set.vertex(110, 220);
  set.setMarkAttr(i, 200, 20, LEFT, GraphicSet.STATIC);
  set.newShape(GraphicSet.MARK);
  set.vertex(115, 300);
  set.newShape(GraphicSet.PATH);
  set.vertex(150, 200);
  set.vertex(200, 115);
  set.update();

  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo2_X() {
  size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  ColorMap map = new ColorMap();
  map.load("colormap.txt");
  GraphicSet set = new GraphicSet();
  float lastAngle = 0;
  int id;
  for (int i = 0; i < data.length; i++) {
    id = set.newShape();
    set.setFillCode(id, i%7);
    float[] coords = set.arc(0, 0, 20, lastAngle, lastAngle+radians(data[i]),PIE);
    println(coords.length);
    for (int j=0; j<coords.length/2; j++)
      set.vertex(coords[j*2],coords[j*2+1]);
    lastAngle += radians(data[i]);
  }
  set.setColorMap(map);
  set.update();
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo4_1() {
  DataTable table = new DataTable();
  int nomCol = table.addColumn("Nombre", "STRING");
  int poblCol = table.addColumn("Poblacion", "FLOAT");
  int row = table.addRow();
  table.setString(row, nomCol, "Guanacaste");
  table.setFloat(row, poblCol, 280488.0);
  row = table.addRow();
  table.setString(row, nomCol, "Alajuela");
  table.setFloat(row, poblCol, 876073.0);
}

void draw() {
  app.draw();
}

void mousePressed() {
  Point p = new Point(mouseX, mouseY);
  app.mousePressed(p);
}

void keyPressed() {
  app.keyPressed();
}

