/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
GraphicApp app;

void setup() {
  Ejemplo2_2();
}

void Ejemplo2_2(){
  
  size(640, 480);
  app = new GraphicApp(640,480);
  View view = new View(10,10,620,460);
  GraphicSet set = new GraphicSet();
  
  //Draws tree
  DiscTree tree = new DiscTree(0,0,600,450);  
  
  //LOADS FROM CSV
  if(tree.load("CostaRica.txt", ",")) {
    tree.debug();
    tree.draw(set);
  }

  // LOADS FROM JSON
//  if(tree.loadJSON("costarica.json")) {
//    tree.debug();
//    tree.draw(set);
//  }
  
  //Up[dates screen  
  set.update();  
  tree.setVisualSet(set);
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

