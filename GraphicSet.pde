/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class GraphicSet extends VisualSet {

  public static final int MARK=1;
  public static final int PATH=2;
  public static final int AREA=3;
  public static final int OVAL=4;
  public static final int SLIDE=5;
  
  public static final int STATIC=0;
  public static final int DYNAMIC=1;

  int MAX_SHAPES = 10000;
  float[] coords;
  float[] bbox;
  float[] sizes;

  int[] shapes;
  int[] parts;
  int[] types;
  int[] fills;
  int[] strokes;
  int[] weights;
  int[] symbols;
  int[] locations;
  int[] modes;
  int selectedShape;
  boolean selected[];
  String[] labels;
  color selStroke = color(244, 0, 0);
  color selFill = color(244, 0, 0);

  int numSymbol=0;

  float wSize=5;
  float hSize=5;
  int type=0;
  int mode=0;
  int location=CENTER;
  int fillCode=1;
  int strokeCode=0;
  int weight=1;
  int symbolCode=0;
  int labelWidth=40;
  int labelHeight=40;

  FBounds extent = new FBounds();
  boolean modified = true;
  private int coordCount=0;
  private int shapeCount=0;
  private int partCount=0;

  int dimension(float w, float h) {
    return vertex(w, h);
  }

  int limits(float start, float end) {
    return vertex(start, end);
  }

  int vertex(float x, float y) {
    int index = coordCount;
    coordCount++;
    if (coords==null) {
      coords = new float[MAX_SHAPES*8];
      bbox = new float[MAX_SHAPES*4];
    }
    coords[index*2] = x;
    coords[index*2+1] = y;
    return index;
  }

  int beginShape(int type) {
    int index = shapeCount;
    shapeCount++;
    if (types==null)
      types = new int[MAX_SHAPES];
    if (shapes==null)
      shapes = new int[MAX_SHAPES];
    if (selected==null)
      selected = new boolean[MAX_SHAPES];
    types[index] = type;
    shapes[index] = partCount;
    newPart();
    return index;
  }

  int beginShape() {
    return beginShape(AREA);
  }

  void endShape() {
    parts[partCount]=coordCount;
    shapes[shapeCount]=partCount;
  }

  int newPart() {
    int index = partCount;
    partCount++;
    if (parts==null)
      parts = new int[MAX_SHAPES];
    parts[index]=coordCount;
    return index;
  }
  
  void setMarkAttr(float w,float h,int _location,int _mode) {
    wSize = w; hSize = h; location = _location; mode = _mode;
  }

  void setMarkAttr(int shapeId,float w,float h,int location,int mode) {
    if (sizes==null) {
      sizes = new float[MAX_SHAPES*2];
      locations = new int[MAX_SHAPES];
      modes = new int[MAX_SHAPES];
      for (int i=0; i<MAX_SHAPES; i++) {
        sizes[i*2]=wSize; sizes[i*2+1]=hSize;
        locations[i]=location;
        modes[i]=mode;
      }
    }
    sizes[shapeId*2]=w; sizes[shapeId*2+1]=h;
    locations[shapeId]=location; modes[shapeId]=mode;
  }

  void setFillCode(int colorCode) { 
    fillCode = colorCode;
  }

  void setFillCode(int shapeId, int colorCode) {
    if (fills==null) {
      fills = new int[MAX_SHAPES];
      for (int i=0; i<MAX_SHAPES; i++)
        fills[i] = fillCode;
    }
    fills[shapeId] = colorCode;
  }

  int getFillCode () { 
    return fillCode;
  }

  int getFillCode(int shapeId) {
    if (fills==null) return -1;
    return fills[shapeId];
  } 

  void setStrokeCode(int colorCode) { 
    strokeCode = colorCode;
  }

  void setStrokeCode(int shapeId, int colorCode) {
    if (strokes==null) {
      strokes = new int[MAX_SHAPES];
      for (int i=0; i<MAX_SHAPES; i++)
        strokes[i] = strokeCode;
    }
    strokes[shapeId] = colorCode;
  }

  int getStrokeCode () { 
    return strokeCode;
  }

  int getStrokeCode(int shapeId) {
    if (strokes==null) return -1;
    return strokes[shapeId];
  }

  void setSymbolCode(int index, int id) {
    if (symbols==null) {
      symbols = new int[MAX_SHAPES];
      for (int i=0; i<MAX_SHAPES; i++)
        symbols[i] = symbolCode;
    }
    symbols[index] = id;
  }

  void setLabel(int index, String label) {
    if (labels==null)
      labels = new String[MAX_SHAPES];
    labels[index] = label;
  }

  void setSelected(int index, boolean flag) {
    selected[index]=flag;
  }

  boolean isSelected(int index) {
    return selected[index];
  }

  void update() {
    for (int i=0; i<=shapeCount; i++) {
      bbox[i*4] = bbox[i*4+2] = MAX_FLOAT;
      bbox[i*4+1] = bbox[i*4+3] = MIN_FLOAT;
      for (int j=shapes[i]; j<shapes[i+1]; j++)
        for (int n=parts[j]; n<parts[j+1]; n++) {
          if (bbox[i*4] > coords[n*2])
            bbox[i*4] = coords[n*2];
          if (bbox[i*4+1] < coords[n*2])
            bbox[i*4+1] = coords[n*2];
          if (bbox[i*4+2] > coords[n*2+1])
            bbox[i*4+2] = coords[n*2+1];
          if (bbox[i*4+3] < coords[n*2+1])
            bbox[i*4+3] = coords[n*2+1];
        }
    }
  }

  FBounds getExtent() {
    if (modified)
      for (int i=0; i<coordCount; i++) {
        if (extent.xMin > coords[i*2])
          extent.xMin = coords[i*2];
        if (extent.yMin > coords[i*2+1])
          extent.yMin = coords[i*2+1];
        if (extent.xMax < coords[i*2])
          extent.xMax = coords[i*2];
        if (extent.yMax < coords[i*2+1])
          extent.yMax = coords[i*2+1];
      }
    modified = false;
    return extent;
  }

  void draw(PGraphics pg, View view) {
    FBounds vExtent = view.extent;
    float scl = view.scale;
    float cx = view.xCenter;
    float cy = view.yCenter;
    float xMid = (vExtent.xMax+vExtent.xMin)/2;
    float yMid = (vExtent.yMax+vExtent.yMin)/2;
    Symbol symbol = new Symbol();
    for (int i=0; i<=shapeCount; i++) {
      if (!vExtent.overlap(bbox[i*4], bbox[i*4+1], 
      bbox[i*4+2], bbox[i*4+3])) continue;
      if (strokes==null)
        pg.stroke(colorMap.getColor(strokeCode));
      if (fills==null)
        pg.fill(colorMap.getColor(fillCode));
      if (weights==null)  
        pg.strokeWeight(weight);
      if (fills!=null)
        pg.fill(colorMap.getColor(fills[i]));
      if (strokes!=null)
        pg.stroke(colorMap.getColor(strokes[i]));
      if (weights!=null)
        pg.strokeWeight(weights[i]);
      if (symbols!=null) symbolCode = symbols[i];
      if (sizes!=null) { 
        wSize = sizes[i*2]; hSize = sizes[i*2+1];
        location = locations[i]; mode = modes[i];
      }
      if (selected[i]) {
        pg.stroke(selStroke);
        pg.fill(selFill);
      }
      for (int j=shapes[i]; j<shapes[i+1]; j++) {
        if (types[i]==PATH) pg.noFill();
        pg.beginShape();
        for (int n=parts[j]; n<parts[j+1]; n++) {
          if (types[i]==SLIDE) { 
            pg.arc(coords[n*2], coords[n*2+1], coords[n*2+2], coords[n*2+3], coords[n*2+4], coords[n*2+5]);
            n+=2;
          } else if (types[i]==OVAL) { 
            pg.ellipse(coords[n*2], coords[n*2+1], coords[n*2+2], coords[n*2+3]);
            n++;
          } else if (types[i]==MARK) {
            if (mode==STATIC) {
              symbol.setup(coords[n*2], coords[n*2+1], wSize, hSize, location, symbolTable.coords[symbolCode]);
            } else {
              symbol.setup(coords[n*2], coords[n*2+1], wSize/scl, hSize/scl, location, symbolTable.coords[symbolCode]);
            }
            bbox[i*4]=symbol.bounds.xMin;
            bbox[i*4+1]=symbol.bounds.xMax;
            bbox[i*4+2]=symbol.bounds.yMin;
            bbox[i*4+3]=symbol.bounds.yMax;
            if (!symbol.overlap(vExtent)) continue;
            pg.beginShape();
            for (int p=0; p<symbol.coords.length/2; p++)
              pg.vertex((symbol.coords[p*2]-xMid)*scl+cx, cy-(symbol.coords[p*2+1]-yMid)*scl);
            pg.endShape(CLOSE);
          } else
            pg.vertex((coords[n*2]-xMid)*scl+cx, cy-(coords[n*2+1]-yMid)*scl);
        }
        if (types[i]==AREA)
          pg.endShape(CLOSE);
        else
          pg.endShape();
      }
      if (selected[i]&&labels!=null&&labels[i]!=null) {
        pg.fill(0);
        float xCoord = (bbox[i*4]+bbox[i*4+1])/2;
        float yCoord = (bbox[i*4+2]+bbox[i*4+3])/2;
        pg.text(labels[i], (xCoord-xMid)*scl+cx, cy-(yCoord-yMid)*scl, labelWidth, labelHeight);
      }
    }
  }

  void mousePressed(FPoint p) {
    selectedShape=-1;
    for (int i=0; i<shapeCount; i++) {
      if (p.contains(bbox[i*4], bbox[i*4+1], bbox[i*4+2], bbox[i*4+3])) {
        selected[i] = true;
        selectedShape=i;
        layer.selectedShape(i);
      } else
        selected[i] = false;
    }
  }
}

