/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
class DataTable {

  private int MAX_ROWS = 400;
  private int MAX_COLS = 10;
  private String[][] columns;
  private String[] names;
  private String[] types;
  private boolean[] selected;
  private int[] sort;

  private int colCount=0;
  private int rowCount=0;
  Layer layer;

  DataTable() {
    columns = new String[MAX_ROWS][];
    names = new String[MAX_COLS];
    types = new String[MAX_COLS];
    selected = new boolean[MAX_ROWS];
    sort = new int[MAX_ROWS];
  }

  DataTable(int maxRows, int maxCols) {
    MAX_ROWS = maxRows; 
    MAX_COLS = maxCols;
    columns = new String[MAX_COLS][];
    names = new String[MAX_COLS];
    types = new String[MAX_COLS];
    selected = new boolean[MAX_ROWS];
    sort = new int[MAX_ROWS];
  }

  String getString(int rowIndex, int colIndex) {
    return columns[colIndex][sort[rowIndex]];
  }

  int getInt(int rowIndex, int colIndex) {
    return parseInt(columns[colIndex][sort[rowIndex]]);
  }

  float getFloat(int rowIndex, int colIndex) {
    return parseFloat(columns[colIndex][sort[rowIndex]]);
  }

  void setString(int rowIndex, int colIndex, String value) {
    columns[colIndex][sort[rowIndex]] = value;
  }

  void setInt(int rowIndex, int colIndex, int value) {
    columns[colIndex][sort[rowIndex]] = value+"";
  }

  void setFloat(int rowIndex, int colIndex, float value) {
    columns[colIndex][sort[rowIndex]] = value+"";
  }

  int getColIndex(String colName) {
    for (int i=0; i<colCount; i++)
      if (names[i].equals(colName)) return i;
    return -1;
  }

  String getColName(int colIndex) {
    return names[colIndex];
  }

  String getColType(int colIndex) {
    return types[colIndex];
  }

  int addRow() {
    int index;
    if (rowCount==MAX_ROWS)
      expandRows();
    index = rowCount;
    rowCount++;
    selected[index]=false;
    sort[index]=index;
    return index;
  }

  int addColumn(String colName, String type) {
    int index;
    if (colCount==MAX_COLS)
      expandCols();
    index = colCount;
    colCount++;
    names[index]=colName;
    types[index]=type;
    columns[index] = new String[MAX_ROWS];
    return index;
  }

  int getRowCount() { 
    return rowCount;
  }

  int getColCount() { 
    return colCount;
  }

  void sort(int colIndex) {
    int i, j, aux;
    String dataString="";
    float dataNumber=0;
    boolean test;
    resetSort();
    for (i=1; i<rowCount; i++) {
      j=i;
      aux = sort[i]; 
      if (types[colIndex].equals("STRING")) {
        dataString = columns[colIndex][sort[i]];
        test = (dataString.compareTo (columns[colIndex][sort[j-1]])<0);
      } else {
        dataNumber = parseFloat(columns[colIndex][sort[i]]);
        test = dataNumber < parseFloat(columns[colIndex][sort[j-1]]);
      }
      while (j>0&&test) {
        sort[j]=sort[j-1]; 
        j--;
        if (j>0&&types[colIndex].equals("STRING"))
          test = (dataString.compareTo (columns[colIndex][sort[j-1]])<0);
        else if (j>0)
          test = dataNumber < parseFloat(columns[colIndex][sort[j-1]]);
      }
      sort[j]=aux;
    }
  }

  private void resetSort() {
    for (int i=0; i<rowCount; i++) sort[i]=i;
  }

  private void resetSelected() {
    for (int i=0; i<rowCount; i++) selected[i]=false;
  }

  void categorize(int colIndex) {
    String[] category;
    int j, catCount=0;
    category = new String[rowCount];
    String colName = getColName(colIndex);
    int newCol = addColumn(colName+"_cat", "NUMBER");
    for (int i=0; i<rowCount; i++) {
      for (j=0; j<catCount; j++) {
        if (category[j].equals(columns[colIndex][i])) {
          columns[newCol][i]=j+""; break;
        }
      }
      if (j==catCount) {
        category[catCount]=columns[colIndex][i];
        columns[newCol][i]=catCount+"";
        catCount++;
      }
    }
  }

  void setSelected(int rowIndex, boolean flag) {
    selected[sort[rowIndex]]=flag;
    if (flag) layer.selectedRow(rowIndex);
  }

  boolean isSelected(int rowIndex) {
    return selected[sort[rowIndex]];
  }

  private void expandRows() {
    MAX_ROWS = round(MAX_ROWS*1.5);
    String[] newColumn = new String[MAX_ROWS];
    boolean[] newSelected = new boolean[MAX_ROWS];
    int[] newSort = new int[MAX_ROWS];
    for (int i=0; i<colCount; i++ ) {      
      for (int j=0; j<rowCount; j++) 
        newColumn[j]=columns[i][j];
      columns[i]=newColumn;
    }
    for (int i=0; i<MAX_ROWS; i++) {
      if (i<rowCount) {
        newSort[i] = sort[i];
        newSelected[i] = selected[i];
      } else {
        newSort[i] = i;
        newSelected[i] = false;
      }
    }
    sort = newSort;
    selected = newSelected;
  }

  private void expandCols() {
    MAX_COLS = round(MAX_COLS*1.5);
    String[][] newColumns = new String[MAX_COLS][];
    String[] newNames = new String[MAX_COLS];
    String[] newTypes = new String[MAX_COLS];
    for (int i=0; i<colCount; i++ ) {
      newColumns[i] = columns[i];
      newNames[i] = names[i];
      newTypes[i] = types[i];
    }
    columns = newColumns;
    names = newNames;
    types = newTypes;
  }
}

