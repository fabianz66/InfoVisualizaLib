/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class ColorMap {

  int[] data = {0,0,0,255,255,255};
  int colorCount=2;
  
  void load(String filename) {
    String lines[] = loadStrings(filename);
    data = new int[lines.length*3];
    for (int i=0; i<lines.length-4; i++) {
      String[] list=splitTokens(lines[i+4], " ");
      data[3*i] = parseInt(list[0]);
      data[3*i+1] = parseInt(list[1]);
      data[3*i+2] = parseInt(list[2]);
    }
    colorCount = lines.length-4;
  }
  
  color getColor(int value) {
    int index = value % colorCount;
    return color(data[index*3],data[index*3+1],data[index*3+2]);
  }
  
  color getColor(int value,int min,int max) {
    int index = round(map(value,min,max,0,colorCount));
    return color(data[index*3],data[index*3+1],data[index*3+2]);
  }
}
