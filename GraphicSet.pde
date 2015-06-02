/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class GraphicSet extends VisualSet {

  public static final int MARK=1;
  public static final int PATH=2;
  public static final int AREA=3;

  public static final int STATIC=0;
  public static final int DYNAMIC=1;

  public static final int NONE=0;
  public static final int SIMPLE=1;
  public static final int MULTIPLE=2;

  int MAX_SHAPES = 10000;

  float[] coords;
  float[] bbox;
  float[] sizes;

  int[] shapes;
  int[] types;
  int[] fills;
  int[] strokes;
  int[] weights;
  int[] symbols;
  int[] locations;
  int[] modes;
  int[] alphas;

  int selectedShape;
  boolean selected[];
  boolean visibles[];
  String[] labels;
  color selStroke = color(244, 0, 0);
  color selFill = color(244, 0, 0, 128);
  int numSymbol=0;

  float wSize=5;
  float hSize=5;
  int type=0;
  int mode=1;
  int location=CENTER;
  int fillCode=1;
  int strokeCode=0;
  int weight=1;
  int symbolCode=0;
  int labelWidth=40;
  int labelHeight=40;
  int selectionMode=1;
  int alpha=255;

  FBounds extent = new FBounds();
  boolean modified = true;
  private int coordCount=0;
  private int shapeCount=0;

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

  void setVertex(int shapeId, int index, float x, float y) {
    coords[shapes[shapeId]+index*2] = x;
    coords[shapes[shapeId]+index*2+1] = y;
    modified=true;
  }

  int getVertexCount(int shapeId) {
    return (shapes[shapeId+1]-shapes[shapeId]);
  }

  float[] getVertex(int shapeId, int index) {
    float[] point = new float[2];
    point[0] = coords[shapes[shapeId]+index*2];
    point[1] = coords[shapes[shapeId]+index*2+1];
    return point;
  }

  float[] getCoords(int shapeId) {
    int n = getVertexCount(shapeId);
    float[] aux = new float[n*2];
    for (int i=0; i<n; i++) {
      aux[i*2] = coords[(shapes[shapeId]+i)*2];
      aux[i*2+1] = coords[(shapes[shapeId]+i)*2+1];
    }
    return aux;
  }

  int newShape(int type) {
    int index = shapeCount;
    shapeCount++;
    if (types==null)
      types = new int[MAX_SHAPES];
    if (shapes==null)
      shapes = new int[MAX_SHAPES];
    if (selected==null)
      selected = new boolean[MAX_SHAPES];
    types[index] = type;
    shapes[index] = coordCount;
    return index;
  }

  int newShape() {
    return newShape(AREA);
  }

  void setSelectionMode(int mode) {
    selectionMode = mode;
  }
  
  void setVisible(int shapeId, boolean flag) {
    if (visibles==null) {
      visibles = new boolean[MAX_SHAPES];
      for (int i=0; i< MAX_SHAPES; i++)
        visibles[i] = true;
    }
    visibles[shapeId] = flag;
  }
  
  void setWeight(int shapeId, int _weight) {
    if (weights==null)
      weights = new int[MAX_SHAPES];
    weights[shapeId] = _weight;
  }

  int getWeight(int shapeId) {
    return weights[shapeId];
  }
  
  void setAlpha(int shapeId, int _alpha) {
    if (alphas==null)
      alphas = new int[MAX_SHAPES];
    for (int i=0; i<MAX_SHAPES;i++)
      alphas[i]= 255;
    alphas[shapeId] = _alpha;
  }

  int getAlpha(int shapeId) {
    return alphas[shapeId];
  }

  void setLabelSize(int w, int h) {
    labelWidth = w; 
    labelHeight = h;
  }

  void setMarkAttr(float w, float h, int _location, int _mode) {
    wSize = w; 
    hSize = h; 
    location = _location; 
    mode = _mode;
  }

  void setMarkAttr(int shapeId, float w, float h, int location, int mode) {
    if (sizes==null) {
      sizes = new float[MAX_SHAPES*2];
      locations = new int[MAX_SHAPES];
      modes = new int[MAX_SHAPES];
      for (int i=0; i<MAX_SHAPES; i++) {
        sizes[i*2]=wSize; 
        sizes[i*2+1]=hSize;
        locations[i]=location;
        modes[i]=mode;
      }
    }
    sizes[shapeId*2]=w; 
    sizes[shapeId*2+1]=h;
    locations[shapeId]=location; 
    modes[shapeId]=mode;
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

  void setSelectionColor(color _stroke, color _fill) {
    selStroke=_stroke;
    selFill=_fill;
  }

  void setSelected(int index, boolean flag) {
    selected[index]=flag;
  }

  boolean isSelected(int index) {
    return selected[index];
  }

  int getSelectedId() { 
    return selectedShape;
  }

  void update() {
    shapes[shapeCount]=coordCount;
    for (int i=0; i<=shapeCount; i++) {
      bbox[i*4] = bbox[i*4+2] = MAX_FLOAT;
      bbox[i*4+1] = bbox[i*4+3] = MIN_FLOAT;
      for (int n=shapes[i]; n<shapes[i+1]; n++) {
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
      if (visibles!=null && !visibles[i]) continue;
      if (!vExtent.overlap(bbox[i*4], bbox[i*4+1],bbox[i*4+2], bbox[i*4+3])) continue;
      if (alphas!=null)
        alpha = alphas[i];
      if (strokes==null)
        pg.stroke(colorMap.getColor(strokeCode));
      if (fills==null)
        pg.fill(colorMap.getColor(fillCode),alpha);
      if (weights==null)  
        pg.strokeWeight(weight);
      if (fills!=null)
        pg.fill(colorMap.getColor(fills[i]),alpha);
      if (strokes!=null)
        pg.stroke(colorMap.getColor(strokes[i]));
      if (weights!=null)
        pg.strokeWeight(weights[i]);
      if (symbols!=null) symbolCode = symbols[i];
      if (sizes!=null) { 
        wSize = sizes[i*2]; 
        hSize = sizes[i*2+1];
        location = locations[i]; 
        mode = modes[i];
      }
      if (selected[i]) {
        pg.stroke(selStroke);
        pg.fill(selFill);
      }
      pg.beginShape();
      for (int j=shapes[i]; j<shapes[i+1]; j++) {
        if (types[i]==PATH) pg.noFill();
        if (types[i]==MARK) {
          if (mode==STATIC) {
            symbol.setup(coords[j*2], coords[j*2+1], wSize, hSize, location, symbolTable.coords[symbolCode]);
          } else {
            symbol.setup(coords[j*2], coords[j*2+1], wSize/scl, hSize/scl, location, symbolTable.coords[symbolCode]);
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
        } else {
          pg.vertex((coords[j*2]-xMid)*scl+cx, cy-(coords[j*2+1]-yMid)*scl);
        }
      }
      if (types[i]==AREA)
        pg.endShape(CLOSE);
      else
        pg.endShape();
      if (selected[i]&&labels!=null&&labels[i]!=null) {
        pg.fill(0);
        float xCoord = (bbox[i*4]+bbox[i*4+1])/2;
        float yCoord = (bbox[i*4+2]+bbox[i*4+3])/2;
        float[] coords = getCoords(i);
        float[] position = centroid(coords);
        float labelW = textWidth(labels[i]);
        pg.fill(0);
        pg.stroke(0);
        pg.rect((position[0]-xMid)*scl+cx+5, cy-(position[1]-yMid)*scl-25, labelW+10, 22); 
        pg.fill(255);
        pg.text(labels[i], (position[0]-xMid)*scl+cx+10, cy-(position[1]-yMid)*scl-10);
      }
    }
  }

  void mousePressed(FPoint p) {
    if (selectionMode==NONE) return;
    selectedShape=-1;
    for (int i=shapeCount-1; i>=0; i--) {
      if (p.contains(bbox[i*4], bbox[i*4+1], bbox[i*4+2], bbox[i*4+3])) {
        float[] points = getCoords(i);
        if (((types[i]==AREA)&&PointInPolygon(p, points))||
          ((types[i]==PATH)&&(DistancePointPath(p, points)<2))||
          ((types[i]==MARK))) {
          selected[i] = !selected[i];
          if (selected[i]) {
            selectedShape=i;
            layer.selectedShape(i);
          }
        } else
          if (selectionMode==SIMPLE)
            selected[i] = false;
      } else
        if (selectionMode==SIMPLE)
          selected[i] = false;
    }
  }

  boolean PointInPolygon(FPoint point, float[] points) {
    int i, j, n = points.length/2;
    boolean c = false;

    for (i = 0, j = n - 1; i < n; j = i++) {
      if ( ( (points[i*2+1] > point.y ) != (points[j*2+1] > point.y) ) &&
        (point.x < (points[j*2] - points[i*2]) * (point.y - points[i*2+1]) / (points[j*2+1] - points[i*2+1]) + points[i*2])
        )
        c = !c;
    }
    return c;
  }


  float[] centroid(float[] coords) {
    int vertexCount = coords.length/2;

    if (vertexCount==1)
    return new float[] {
      coords[0], coords[1]
    };

    float[] centroid = new float[] {
      0, 0
    };

    double signedArea = 0.0;
    double x0 = 0.0; // Current vertex X
    double y0 = 0.0; // Current vertex Y
    double x1 = 0.0; // Next vertex X
    double y1 = 0.0; // Next vertex Y
    double a = 0.0;  // Partial signed area

    int i=0;
    for (i=0; i<vertexCount-1; ++i) {
      x0 = coords[i*2];
      y0 = coords[i*2+1];
      x1 = coords[2*(i+1)];
      y1 = coords[2*(i+1)+1];
      a = x0*y1 - x1*y0;
      signedArea += a;
      centroid[0] += (x0 + x1)*a;
      centroid[1] += (y0 + y1)*a;
    }

    x0 = coords[i*2];
    y0 = coords[i*2+1];
    x1 = coords[0];
    y1 = coords[1];
    a = x0*y1 - x1*y0;
    signedArea += a;
    centroid[0] += (x0 + x1)*a;
    centroid[1] += (y0 + y1)*a;

    signedArea *= 0.5;
    centroid[0] /= (6.0*signedArea);
    centroid[1] /= (6.0*signedArea);

    return centroid;
  }

  float[] arc(float cx, float cy, float r, float start, float end, int mode) {
    int extra=3;
    if ((mode==CHORD)||(mode==PIE)) extra=5;    
    float[] coords = new float[ceil((end-start)*28.65)+extra];
    float a;
    int i=0;
    for (i=0, a=start; a<end; a+=0.0697778, i++) {
      coords[i*2]=  cos(a)*r + cx;
      coords[i*2+1] = sin(a)*r + cy;
    }
    coords[i*2]=  cos(end)*r + cx;
    coords[i*2+1] = sin(end)*r + cy;
    i++;
    if (mode==CHORD) {
      coords[i*2]=coords[0];
      coords[i*2+1]=coords[1];
    } else if (mode==PIE) {
      coords[i*2]=cx;
      coords[i*2+1]=cy;
    }
    return coords;
  }

  float[] sector(float cx, float cy, float r1, float r2, float start, float end) {
    float[] temp1 = arc(cx, cy, r2, start, end, OPEN);
    float[] temp2 = arc(cx, cy, r1, start, end, OPEN);
    int n = temp1.length;
    float[] coords = new float[n*2];
    for (int i=0; i<n; i++)
      coords[i] = temp1[i];
    
    for (int i=0; i<n/2; i++) {
      coords[i*2+n] = temp2[n-i*2-2];
      coords[i*2+n+1] = temp2[n-i*2-1];
    }
    return coords;
  }

  double lineMagnitude(double x1, double y1, double x2, double y2) {
    double lineMagnitude = Math.sqrt(Math.pow((x2 - x1), 2)+ Math.pow((y2 - y1), 2));
    return lineMagnitude;
  }

  double DistancePointLine(float px, float py, float x1, float y1, float x2, float y2) {

    double DistancePointLine;
    double LineMag = lineMagnitude(x1, y1, x2, y2);

    if (LineMag < 0.00000001) {
      DistancePointLine = 9999;
      return DistancePointLine;
    }

    float u1 = (((px - x1) * (x2 - x1)) + ((py - y1) * (y2 - y1)));
    double u = u1 / (LineMag * LineMag);

    if ((u < 0.00001) || (u > 1)) {

      double ix = lineMagnitude(px, py, x1, y1);
      double iy = lineMagnitude(px, py, x2, y2);
      if (ix > iy)
        DistancePointLine = iy;
      else
        DistancePointLine = ix;
    } else {
      double ix = x1 + u * (x2 - x1);
      double iy = y1 + u * (y2 - y1);
      DistancePointLine = lineMagnitude(px, py, ix, iy);
    }
    return DistancePointLine;
  }

  double DistancePointPath(FPoint point, float[] points) {
    int n = points.length/2;

    float distance=MAX_FLOAT;
    float temp;

    for (int i=0; i<n-1; i++) {
      temp = (float)DistancePointLine(point.x, point.y, 
      points[i*2], points[i*2+1], points[i*2+2], points[i*2+3]);
      if (distance > temp)
        distance = temp;
    }
    return distance;
  }
}

