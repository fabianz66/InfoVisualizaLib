/* Copyright (c) 2015 Armando Arce, MIT; see COPYRIGHT */
public class TableHelper {

  DataTable loadCSV(String filename,String delim) {
    String[] lines = loadStrings(filename);
    String[] pieces = split(lines[0], delim);
    int maxRows = lines.length;
    int maxCols = pieces.length;
    DataTable table = new DataTable(maxRows,maxCols);
    for (int j=0; j<pieces.length; j++) {
      String parts[] = split(pieces[j], ":");
      String type = "STRING";
      if (parts.length>1)
        type = parts[1];
      table.addColumn(parts[0], type);
    }
    for (int i=1; i<lines.length; i++) {
      table.addRow();
      pieces = split(lines[i], delim);
      for (int j=0; j<table.getColCount (); j++)
        if (table.getColType(j).equals("INT"))
          table.setInt(i-1,j,parseInt(pieces[j]));
        else if (table.getColType(j).equals("FLOAT"))
          table.setFloat(i-1,j,parseFloat(pieces[j]));
        else
          table.setString(i-1,j,pieces[j]);
    }
    return table;
  }

  void printTable(DataTable table) {
    for (int j=0; j<table.getColCount (); j++)
      print(table.getColName(j)+":"+
            table.getColType(j).substring(0,1)+"\t");
    print("\n");
    for (int i=0; i<table.getRowCount (); i++) {
      for (int j=0; j<table.getColCount (); j++)
        print(table.getString(i, j)+"\t");
      print("\n");
    }
  }
}

