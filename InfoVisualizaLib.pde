/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */


int SCREEN_WIDTH = 640;
int SCREEN_HEIGHT = 480;
int SCREEN_MARGIN = 10;
GraphicApp app;

void setup() {

//    EjemploDendrogram("Species4.csv",50,Dendrogram.POLAR,"colormap4.txt",6);
//    EjemploDendrogram("Species2.csv",4.5,Dendrogram.POLAR,"colormap2.txt",5);
//    EjemploDendrogram("Species1.csv",25,Dendrogram.POLAR,"colormap.txt",4);
//    EjemploDendrogram("Species3.csv",40,Dendrogram.POLAR,"colormap3.txt",4);
//    EjemploCandelabro("json01.json",6);
//    EjemploCandelabro("json02.json",5);
//    EjemploCandelabro("json03.json",4);
//    EjemploCandelabro("json04.json",3);
}

void EjemploCandelabro(String pFilename, int pSymbolCode)
{
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
  Candelabrum tree = new Candelabrum(0,0,view_W,view_H);  
  tree.setVisualSet(set);
  
  //Intenta cargar el archivo
  if(tree.loadJSON(pFilename)) {
    
    //Si hubo exito, se manda a dibujar el arbol
    tree.setSymbolCode(pSymbolCode);    
    tree.draw(set);
  }  
  
  //Actualiza la pantalla
  set.update();  
  view.add(tree);  
  view.zoomToExtent(tree.getExtent());
  app.add(view); 
}

void EjemploDendrogram(String filename, float scale,int type, String colormap, int symbolCode){
size(SCREEN_WIDTH, SCREEN_HEIGHT);
  app = new GraphicApp(SCREEN_WIDTH,SCREEN_HEIGHT);  
  int view_W = SCREEN_WIDTH - SCREEN_MARGIN*2;
  int view_H = SCREEN_HEIGHT - SCREEN_MARGIN*2;
  View view = new View(SCREEN_MARGIN,SCREEN_MARGIN,view_W,view_H);
  view.fill = 255;
  Layer layer = new Layer(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
  GraphicSet set = new GraphicSet();
  ColorMap map = new ColorMap();
  map.load(colormap);
  set.setColorMap(map);
  Dendrogram dendro = new Dendrogram();
  dendro.symbolCode = symbolCode;
  dendro.setGraphics(set);
  dendro.paintDendrogram(filename,scale, type);
  dendro.getGraphics().update();
  layer.setVisualSet(dendro.getGraphics());
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

