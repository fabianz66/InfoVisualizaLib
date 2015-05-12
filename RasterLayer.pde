/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class RasterLayer extends Layer {
  
  RasterLayer(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  void loadASCII(String filename) {
    GridSet grid = new GridSet();
    String[] tokens;
    String lines[] = loadStrings(filename);
    grid.ncols = parseInt(splitTokens(lines[0], " ")[1]);
    grid.nrows = parseInt(splitTokens(lines[1], " ")[1]);
    grid.xcorner = parseFloat(splitTokens(lines[2], " ")[1]);
    grid.ycorner = parseFloat(splitTokens(lines[3], " ")[1]);
    grid.cellsize = parseFloat(splitTokens(lines[4], " ")[1]);
    grid.nodata = parseInt(splitTokens(lines[5], " ")[1]);
    grid.setup();
    for (int i=0; i<grid.nrows; i++) {
      tokens = splitTokens(lines[i+6], " ");
      for (int j=0; j<grid.ncols; j++) {
        grid.cell(i,j,parseInt(tokens[j]));
      }
    }
    setVisualSet(grid);
  }
}

