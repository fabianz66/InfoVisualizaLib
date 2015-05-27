/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */


int SCREEN_WIDTH = 640;
int SCREEN_HEIGHT = 480;
int SCREEN_MARGIN = 10;
GraphicApp app;

void setup() {
//  EjemploCSV01();
//  EjemploCSV02();
//  EjemploCSV03();
//  EjemploJSON01();
//  EjemploJSON02();
//  EjemploJSON03();
  EjemploJSON04();
}

//------------------------------------------------------------------------------
// Ejemplo CSV 01
//------------------------------------------------------------------------------
  
void EjemploCSV01(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette1.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.load("commas1.csv", ",")) {
   
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }

  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo CSV 02
//------------------------------------------------------------------------------

void EjemploCSV02(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette2.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.load("commas2.csv", ",")) {
   
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }

  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo CSV 03
//------------------------------------------------------------------------------

void EjemploCSV03(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette3.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.load("commas3.csv", ",")) {
   
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }

  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo JSON 01
//------------------------------------------------------------------------------
void EjemploJSON01(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette5.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.loadJSON("json01.json")) {
    
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }  
  
  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo JSON 02
//------------------------------------------------------------------------------
void EjemploJSON02(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette4.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.loadJSON("json02.json")) {
    
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }  
  
  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo JSON 03
//------------------------------------------------------------------------------
void EjemploJSON03(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette2.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.loadJSON("json03.json")) {
    
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }  
  
  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

//------------------------------------------------------------------------------
// Ejemplo JSON 04
//------------------------------------------------------------------------------
void EjemploJSON04(){
  
  //Tamano de pantalla y view
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  
  //Crea el graphic set y DEBE establecer un mapa de colores.
  //De lo contrario se ve todo negro.
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load("palette1.txt");
  set.setColorMap(map);
  
  //Crea el arbol. Este hereda de Layer.
  //El arbol siempre se comienza a dibujar en el centro del layer
  //Se le asigna el set al layer
  DiscTree tree = new DiscTree(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.loadJSON("json04.json")) {
    
    //Si hubo exito, se manda a dibujar el arbol
    tree.draw(set);
  }  
  
  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
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

