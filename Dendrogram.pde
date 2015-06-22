public class Dendrogram 
{
  public static final int PLAIN = 0;
  public static final int POLAR = 1;
  float leaf_length = 60;
  int X_RANGE = 1000;
  int Y_RANGE = 1500;
  GraphicSet Graphic_Set;
  SymbolTable symbols;
  ColorMap map;
  
  
  GraphicSet getGraphics()
  {
    return Graphic_Set;
  }
  void setGraphics(GraphicSet gset)
  {
    Graphic_Set = gset;
  }
  void paintDendrogram(String filename,float SCALE,int TYPE){
    TableHelper helper = new TableHelper();
    DataTable data = helper.loadCSV(filename,",");
    DendrogramCluster.VAL_SCALE = SCALE;
    
    int mi = millis();
    ArrayList<DendrogramCluster> clust_list = new ArrayList<DendrogramCluster>();
    for(int i=0; i<data.getRowCount();i++){
      DendrogramCluster c = new DendrogramCluster(data.getString(i,0),data.getFloat(i,1));
      clust_list.add(c);
    }
    ArrayList<DendrogramCluster> clust_list_dendro = findAllValues(clust_list);
    DendrogramCluster clustered_list = dendroAlgorithm(clust_list);
    int mf = millis();
    int total = mf-mi;
    println("HAC Time: "+ total); 
    symbols = new SymbolTable();
    symbols.load("symboltable.txt");
    Graphic_Set.setSymbolTable(symbols);
    map = new ColorMap();
    map.load("colormap3.txt");
    Graphic_Set.setColorMap(map);
    Graphic_Set.strokeCode = 255;
    mi = millis();
    if (TYPE == POLAR)
    {
      paintPolarDendrogram(clustered_list,0,X_RANGE,clustered_list.Similarity);
    } else 
    {
      paintDendrogram(clustered_list,0,X_RANGE,clustered_list.Similarity);
    }
    mf = millis();
    total = mf-mi;
    println("VIS Time: "+total);
    
  }
  
  void paintDendrogram(DendrogramCluster clustered_tree,float x_1, float x_2, float y_height)
  {
    if (clustered_tree.isLeaf)
    {
      float total_range = x_2 -x_1;
      float x =x_1+total_range/2;
      float y = y_height-20;
      int i = Graphic_Set.newShape(GraphicSet.MARK);
      Graphic_Set.vertex(x, y);
      Graphic_Set.setSymbolCode(i,2);
      Graphic_Set.setLabel(i, clustered_tree.leafName);
      Graphic_Set.setMarkAttr(i, 5, 5, TOP, GraphicSet.STATIC);
      int j = Graphic_Set.newShape(GraphicSet.PATH);
      Graphic_Set.vertex(x_1+total_range/2,y_height);
      Graphic_Set.vertex(x_1+total_range/2,y_height-20);
    }
    else{
      float total_range = x_2 -x_1;
      int total_children = clustered_tree.children_count;
      int left_children = clustered_tree.child_node_1.children_count;
      int right_children = clustered_tree.child_node_2.children_count;
      float left_child_center  = x_1+((total_range/total_children)*left_children)/2;
      float right_child_center = x_2-((total_range/total_children)*right_children)/2;
      float left_child_height  = clustered_tree.child_node_1.Similarity;
      float right_child_height = clustered_tree.child_node_2.Similarity;
      
      float center_left = calculateCenter(clustered_tree.child_node_1,x_1,right_child_center-((total_range/total_children)*right_children)/2);
      float center_right = calculateCenter(clustered_tree.child_node_2,right_child_center-((total_range/total_children)*right_children)/2,x_2);
      
      int i = Graphic_Set.newShape(GraphicSet.PATH);
      
      Graphic_Set.vertex(center_left,left_child_height);
      Graphic_Set.vertex(center_left,y_height);
      Graphic_Set.vertex(center_right,y_height);
      Graphic_Set.vertex(center_right,right_child_height);
      
      paintDendrogram(clustered_tree.child_node_1,x_1,right_child_center-((total_range/total_children)*right_children)/2,left_child_height); //se invierten las similitudes
      paintDendrogram(clustered_tree.child_node_2,right_child_center-((total_range/total_children)*right_children)/2,x_2,right_child_height);
    }
  }
  
  void paintPolarDendrogram(DendrogramCluster clustered_tree,float x_1, float x_2, float y_height)
  {
    if (clustered_tree.isLeaf)
    {
      float total_range = x_2 -x_1;
      float x =x_1+total_range/2;
      float y = y_height-leaf_length;
      int i = Graphic_Set.newShape(GraphicSet.MARK);
      
      x= map(x,0,X_RANGE,0,TWO_PI);
      float xr = (Y_RANGE-y)*cos(x);
      float yr = (Y_RANGE-y)*sin(x);
      
      Graphic_Set.vertex(xr, yr);
      Graphic_Set.setSymbolCode(i,7);
      Graphic_Set.setLabel(i, clustered_tree.leafName);
      Graphic_Set.setMarkAttr(i, 80, 80, x,  CENTER, GraphicSet.STATIC);
      Graphic_Set.setFillCode(i,getColor(clustered_tree.Value));
      i = Graphic_Set.newShape(GraphicSet.PATH);
      Graphic_Set.vertex(xr,yr);
      xr = (Y_RANGE-y-leaf_length)*cos(x);
      yr = (Y_RANGE-y-leaf_length)*sin(x);
      Graphic_Set.vertex(xr,yr);
    }
    else{
      float total_range = x_2 -x_1;
      int total_children = clustered_tree.children_count;
      int left_children = clustered_tree.child_node_1.children_count;
      int right_children = clustered_tree.child_node_2.children_count;
      float left_child_center  = x_1+((total_range/total_children)*left_children)/2;
      float right_child_center = x_2-((total_range/total_children)*right_children)/2;
      float left_child_height  = clustered_tree.child_node_1.Similarity;
      float right_child_height = clustered_tree.child_node_2.Similarity;
      
      float center_left = calculateCenter(clustered_tree.child_node_1,x_1,right_child_center-((total_range/total_children)*right_children)/2);
      float center_right = calculateCenter(clustered_tree.child_node_2,right_child_center-((total_range/total_children)*right_children)/2,x_2);
      center_left = map(center_left,0,X_RANGE,0,TWO_PI);
      center_right = map(center_right,0,X_RANGE,0,TWO_PI);
      float[] coords = Graphic_Set.arc(0, 0, Y_RANGE - y_height, center_left, center_right,CHORD);
      
      int i = Graphic_Set.newShape(GraphicSet.PATH);
      float draw_next_left_x = (Y_RANGE-left_child_height) * cos(center_left);
      float draw_next_left_y = (Y_RANGE-left_child_height) * sin(center_left);
      float draw_next_right_x = (Y_RANGE-right_child_height) * cos(center_right);
      float draw_next_right_y = (Y_RANGE-right_child_height) * sin(center_right);
      Graphic_Set.vertex(draw_next_left_x,draw_next_left_y);

      int j;
      for (j=0; j<(coords.length/2)-1; j++)
      {
        Graphic_Set.vertex(coords[j*2],coords[j*2+1]);
      }
      Graphic_Set.vertex(draw_next_right_x,draw_next_right_y);
      
      i = Graphic_Set.newShape(GraphicSet.MARK);
      Graphic_Set.vertex(draw_next_left_x,draw_next_left_y);
      Graphic_Set.setMarkAttr(i, left_child_height+40,left_child_height+40, center_left,  CENTER, GraphicSet.STATIC);
      Graphic_Set.setLabel(i,str(clustered_tree.child_node_1.Value));
      Graphic_Set.setSymbolCode(i,5);
      Graphic_Set.setFillCode(i,getColor(clustered_tree.child_node_1.Value));
      
      i = Graphic_Set.newShape(GraphicSet.MARK);
      Graphic_Set.vertex(draw_next_right_x,draw_next_right_y);
      Graphic_Set.setSymbolCode(i,5);
      Graphic_Set.setFillCode(i,getColor(clustered_tree.child_node_2.Value));
      Graphic_Set.setMarkAttr(i, right_child_height+40,right_child_height+40, center_right,  CENTER, GraphicSet.STATIC);
      Graphic_Set.setLabel(i,str(clustered_tree.child_node_2.Value));
      paintPolarDendrogram(clustered_tree.child_node_1,x_1,right_child_center-((total_range/total_children)*right_children)/2,left_child_height); //se invierten las similitudes
      paintPolarDendrogram(clustered_tree.child_node_2,right_child_center-((total_range/total_children)*right_children)/2,x_2,right_child_height);
    }
  }
  
  int getColor(float value)
  {
    return round(map(value,0,DendrogramCluster.MAX_VAL,0,map.colorCount-1));
  }
  
  float calculateCenter(DendrogramCluster clustered_tree,float x_1, float x_2)
  {
    if(clustered_tree.isLeaf)
    {
      float total_range = x_2 -x_1;
      return x_1+total_range/2;
    } else{
      float total_range = x_2 -x_1;
      int total_children = clustered_tree.children_count;
      int left_children = clustered_tree.child_node_1.children_count;
      int right_children = clustered_tree.child_node_2.children_count;
      float left_child_center  = x_1+((total_range/total_children)*left_children)/2;
      float right_child_center = x_2-((total_range/total_children)*right_children)/2;
      return left_child_center/2 + right_child_center/2;
    }
    
  }
  
  ArrayList<DendrogramCluster> findAllValues(ArrayList<DendrogramCluster> clustered_list){
    ArrayList<DendrogramCluster> clust_list_dendro = new ArrayList<DendrogramCluster>();
    for(int i=0; i<clustered_list.size();i++){
      for(int j=0;j<clustered_list.size();j++){
        if(j<i){
          DendrogramCluster newclust = new DendrogramCluster(clustered_list.get(i),clustered_list.get(j));  
          clust_list_dendro.add(newclust);
        } else {
          break;
        }
      }
    }
    return clust_list_dendro;
  }
  
  DendrogramCluster dendroAlgorithm(ArrayList<DendrogramCluster> clustered_list){
    if (clustered_list.size()==1){
      return clustered_list.get(0);
    }
    ArrayList<DendrogramCluster> foundValues = findAllValues(clustered_list);
    DendrogramCluster best_fit = getMinCluster(foundValues);
    clustered_list.remove(best_fit.child_node_1);
    clustered_list.remove(best_fit.child_node_2);
    clustered_list.add(0,best_fit);
    return dendroAlgorithm(clustered_list);
  }
  
  
  
  
  DendrogramCluster getMinCluster(ArrayList<DendrogramCluster> clustered_list){
    DendrogramCluster best_fit = clustered_list.get(0);
    for(int i=1;i<clustered_list.size();i++){
      DendrogramCluster try_for_min = clustered_list.get(i); 
      if(try_for_min.Similarity < best_fit.Similarity){
        best_fit = try_for_min;
      }
    }
    return best_fit;
  }

}
