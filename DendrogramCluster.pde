static class DendrogramCluster{
  static float MAX_VAL= 0;
  static float VAL_SCALE =2;
  int cid;
  DendrogramCluster child_node_1;
  DendrogramCluster child_node_2;
  boolean isLeaf;
  String leafName;
  float Value;
  float Similarity;
  int children_count;
  
  DendrogramCluster(DendrogramCluster node_1,DendrogramCluster node_2){
    this.child_node_1 = node_2;
    this.child_node_2 = node_1;
    this.isLeaf=false;
    this.Value = abs((node_1.Value+node_2.Value)/2);
    
    this.Similarity = abs(node_1.Value-node_2.Value)+VAL_SCALE;
    MAX_VAL = (this.Similarity <= MAX_VAL)? MAX_VAL : this.Similarity;
    this.leafName = "("+child_node_1.leafName + "," + child_node_2.leafName+",["+this.Similarity+"])";
    this.children_count+=node_1.children_count+node_2.children_count;
    this.cid=-1;
  }
  DendrogramCluster(String name,float value)
  {
    this.cid=-1;
    this.leafName=name;
    this.Value = value*VAL_SCALE;
    this.isLeaf=true;
    this.child_node_1 = null;
    this.child_node_2 = null;
    this.Similarity = 0;
    this.children_count = 1;
  }
  
  
}
