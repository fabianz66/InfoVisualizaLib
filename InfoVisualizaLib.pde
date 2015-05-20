/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;

void setup() {

  size(640,480);
//  app = new GraphicApp(640,480);
//  View view = new View(10,10,620,460);
//  Layer layer = new Layer(0,0,600,450);
//  GraphicSet set = new GraphicSet();
  
  //Draws tree
  DiscTree tree = new DiscTree();
  if(tree.load("CostaRica.txt", ",")) {
    tree.debug();
    tree.draw(null, 320, 240);
  }
  
  //Up[dates screen  
//  set.update();  
//  layer.setVisualSet(set);
//  view.add(layer);  
//  view.zoomToExtent(layer.getExtent());
//  app.add(view); 
}

void draw() {
//  app.draw();
}

