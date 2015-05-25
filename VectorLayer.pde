/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class VectorLayer extends Layer {

  VectorLayer(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  void loadBNA(String filename) {
    GraphicSet shapes = new GraphicSet();
    String lines[] = loadStrings(filename);
    float xIni=0, yIni=0;
    float x, y;
    int n=0;
    boolean newFeature=false, first=true;
    for (int i=0; i<lines.length; i++) {
      String[] list=splitTokens(lines[i], ",");
      if (n > 0) {
        x=float(list[0]);
        y=float(list[1]);
        n--;
        if (newFeature) {
          xIni=x; yIni=y;
          newFeature=false;
        }
        if (x==xIni&&y==yIni) {
          if (first) first = false;
          else continue;
        }
        shapes.vertex(x, y);
      } else if (list[0].charAt(0)=='"') {
        int c = parseInt(list[list.length-1]);
        n = abs(c);
        if (c==1) shapes.newShape(GraphicSet.MARK);
        else if (c<0) shapes.newShape(GraphicSet.PATH);
        else if (c>2) shapes.newShape(GraphicSet.AREA);
        else print(c);
        newFeature=true;
        first=true;
      }
    }
    shapes.update();
    setVisualSet(shapes);
  }
}

