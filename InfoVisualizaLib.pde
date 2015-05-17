/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;

void setup() {

  size(640,480);
  app = new GraphicApp(640,480);
  View view = new View(10,10,620,460);
  Layer layer = new Layer(0,0,600,450);
  GraphicSet set = new GraphicSet();
  
  //Draws tree
  DiscTree tree = new DiscTree();
  if(tree.load("CostaRica.txt", ",")) {
    tree.debug();
    tree.draw(set, 100, 100);
  }
  
  //Up[dates screen  
  set.update();  
  layer.setVisualSet(set);
  view.add(layer);  
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

