/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;

void setup() {
  Ejemplo2_0();
}

void Ejemplo2_0() {
  size(640,480);
  app = new GraphicApp(640,480);
  View view = new View(10,10,620,460);
  Layer layer = new Layer(0,0,600,450);
  GraphicSet set = new GraphicSet();
  
  int i = set.beginShape(GraphicSet.AREA);
  set.vertex(123.0,134.0);
  set.vertex(245.0,276.0);
  set.vertex(131.0,223.0);
  set.endShape();
  set.setLabel(i,"HOLA");
  i = set.beginShape(GraphicSet.MARK);
  set.vertex(110,220);
  set.setMarkAttr(i,200,20,LEFT,GraphicSet.STATIC);
  set.beginShape(GraphicSet.MARK);
  set.vertex(115,300);
  set.beginShape(GraphicSet.PATH);
  set.vertex(150,200);
  set.vertex(200,115);
  set.endShape();
  set.update();
  
  layer.setVisualSet(set);
  view.add(layer);
  print(layer.getExtent().xMax);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo4_1() {
  DataTable table = new DataTable();
  int nomCol = table.addColumn("Nombre","STRING");
  int poblCol = table.addColumn("Poblacion","FLOAT");
  int row = table.addRow();
  table.setString(row,nomCol,"Guanacaste");
  table.setFloat(row,poblCol,280488.0);
  row = table.addRow();
  table.setString(row,nomCol,"Alajuela");
  table.setFloat(row,poblCol,876073.0);
}

void draw() {
  app.draw();
}

void mousePressed() {
  app.mousePressed();
}

void keyPressed() {
  app.keyPressed();
}

