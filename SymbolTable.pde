/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
class SymbolTable {

  static final int MAX_SYMBOL = 10;
  float [][] coords = {{-0.5,0.5,0.5,0.5,0.5,-0.5,-0.5,-0.5}};
  int symbolCount=1;

  void addSymbol(float[] symbol) {
    if (coords==null) 
      coords = new float[MAX_SYMBOL][];
    coords[symbolCount++] = symbol;
  }

  void load(String filename) {
    float[] symbol;
    String[] list;
    String[] xycoord;
    String lines[] = loadStrings(filename);
    coords = new float[lines.length][];
    for (int i=0; i<lines.length; i++) {
      list=splitTokens(lines[i], " ");
      symbol = new float[list.length*2];
      for (int j=0; j<list.length; j++) {
        xycoord = splitTokens(list[j], ",");
        symbol[2*j] = parseFloat(xycoord[0]);
        symbol[2*j+1] = parseFloat(xycoord[1]);
      }
      coords[i] = symbol;
    }
    symbolCount = lines.length;
  }
}

