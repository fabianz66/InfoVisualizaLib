/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;

void setup() {
  Ejemplo2_2();
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

void Ejemplo2_2() {
  size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  GraphicSet set = new GraphicSet();

  int i = set.newShape(GraphicSet.AREA);
  set.vertex(123.0, 134.0);
  set.vertex(245.0, 276.0);
  set.vertex(131.0, 223.0);
  set.update();

  float[] coords = set.getCoords(i);
  for (int n=0; n<coords.length/2; n++)
    println("X: "+coords[n*2]+", Y: "+coords[n*2+1]);
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo2_3() {
  int[] data = { 
    30, 10, 45, 35, 60, 38, 75, 67
  };
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
    float[] coords = set.arc(0, 0, 20, lastAngle, 
    lastAngle+radians(data[i]), PIE);
    for (int j=0; j<coords.length/2; j++)
      set.vertex(coords[j*2], coords[j*2+1]);
    lastAngle += radians(data[i]);
  }
  set.setColorMap(map);
  set.update();
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo2_4() {
size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  ColorMap map = new ColorMap();
  map.load("colormap.txt");
  GraphicSet set = new GraphicSet();
  set.setColorMap(map);
  
  int i = set.newShape(GraphicSet.AREA);
  set.vertex(123.0, 134.0);
  set.vertex(131.0, 223.0);
  set.vertex(245.0, 276.0);
  set.vertex(255.0, 233.0);
  set.setStrokeCode(i,1);
  set.setFillCode(i,5);

  int j = set.newShape(GraphicSet.PATH);
  set.vertex(150, 200);
  set.vertex(200, 115);
  set.vertex(255, 250);
  set.setStrokeCode(j,6);
  
  set.update();
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo2_5() {
  size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  GraphicSet set = new GraphicSet();

  SymbolTable symbols = new SymbolTable();
  symbols.load("symboltable.txt");
  set.setSymbolTable(symbols);
  
  int i = set.newShape(GraphicSet.MARK);
  set.vertex(123.0, 134.0);
  set.setMarkAttr(i,40,20,CENTER,GraphicSet.STATIC);
  set.setSymbolCode(i,0);
  
  i = set.newShape(GraphicSet.MARK);
  set.vertex(190.0, 153.0);
  set.setMarkAttr(i,20,40,LEFT,GraphicSet.STATIC);
  set.setSymbolCode(i,1);
  
  i = set.newShape(GraphicSet.MARK);
  set.vertex(145.0, 176.0);
  set.setMarkAttr(i,50,30,TOP,GraphicSet.DYNAMIC);
  set.setSymbolCode(i,2);
  
  i = set.newShape(GraphicSet.MARK);
  set.vertex(155.0, 133.0);
  set.setMarkAttr(i,30,50,BOTTOM,GraphicSet.DYNAMIC);
  set.setSymbolCode(i,3);
  
  set.update();
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
}

void Ejemplo2_6() {
  size(640, 480);
  app = new GraphicApp(640, 480);
  View view = new View(10, 10, 620, 460);
  Layer layer = new Layer(0, 0, 600, 450);
  GraphicSet set = new GraphicSet();
  set.setSelectionMode(GraphicSet.MULTIPLE);

  SymbolTable symbols = new SymbolTable();
  symbols.load("symboltable.txt");
  set.setSymbolTable(symbols);
  
  int i = set.newShape(GraphicSet.MARK);
  set.vertex(123.0, 134.0);
  set.setMarkAttr(i,40,20,CENTER,GraphicSet.STATIC);
  set.setSymbolCode(i,0);
  set.setLabel(i,"Marca 1");
  
  i = set.newShape(GraphicSet.PATH);
  set.vertex(150, 200);
  set.vertex(200, 115);
  set.vertex(255, 250);
  set.setLabel(i,"Linea 1");
  
  i = set.newShape(GraphicSet.AREA);
  set.vertex(50.0, 80.0);
  set.vertex(90.0, 53.0);
  set.vertex(19.0, 15.0);
  set.setSymbolCode(i,1);
  set.setLabel(i,"Area 1");
  
  i = set.newShape(GraphicSet.AREA);
  set.vertex(123.0, 134.0);
  set.vertex(245.0, 276.0);
  set.vertex(131.0, 223.0);
  set.setLabel(i,"Area 2");
  
  set.update();
  layer.setVisualSet(set);
  view.add(layer);
  view.zoomToExtent(layer.getExtent());
  app.add(view);
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

