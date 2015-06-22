public class CandelabrumFrontView 
{
  private int diametro=10;
  private int distance=diametro;
  private int cantNodesPerLevel=0;
  private int posNode=0;
  private int radio=60;
  private int higherLevel=0;
  private Node rootNode;
  private Boolean rootDrawed=false;
  private int symbolCode;
  private GraphicSet set;
  
  public CandelabrumFrontView (GraphicSet _set,int _symbolCode)
  {
    set=_set;
    symbolCode=_symbolCode;
  }
  
  public Node getRootNode()
  {
    return rootNode;
  }
  
  public void setRootNode(Node _rootNode)
  {
    rootNode=_rootNode;
    set.newShape(GraphicSet.PATH);
    set.vertex(rootNode.getCoordenates()[0],rootNode.getCoordenates()[1]);
    set.vertex(rootNode.getCoordenates()[0],rootNode.getCoordenates()[1]);
  }
  
  public int getHigherLevel()
  {
    return higherLevel;
  }
  
  public void setHigherLevel(int _higherLevel)
  {
    higherLevel=_higherLevel;
  }
  
  void goOverTree(Node node)
  {
    for(int indexLevel=0;indexLevel<=higherLevel;indexLevel++)
    {
      cantNodesPerLevel=0;
      int cantNodes=getCantNodeInLevel(indexLevel,node);
      cantNodesPerLevel=0;
      Node[] nodesPerLevel=new Node[cantNodes];
      createListPerLevel(nodesPerLevel,node,indexLevel);
      drawNodes(nodesPerLevel,cantNodesPerLevel);
      diametro-=1;
      distance=diametro+1;
    }
  }
  
  void createListPerLevel(Node[] nodes,Node node,int level)
  {
    for(int i=0;i<node.getCantChildren();i++)
    {
      Node childNode = node.getChildrenList()[i];
      if(childNode.getLevel()==level)
      {
        nodes[cantNodesPerLevel]=childNode;
        cantNodesPerLevel++;
      }
      createListPerLevel(nodes,childNode,level);
    }
  }
  
  int getCantNodeInLevel(int level,Node node)
  {
    for(int i=0;i<node.getCantChildren();i++)
    {
      Node childNode = node.getChildrenList()[i];
      if(childNode.getLevel()==level)
      {
        cantNodesPerLevel+=1;
      }
      getCantNodeInLevel(level,childNode);
    }
    return cantNodesPerLevel;
  }
  
  
  void seeTree(Node node)
  {
    for(int i=0;i<node.getCantChildren();i++)
    {
      Node childNode = node.getChildrenList()[i];
      seeTree(childNode);
    }
  }


  void drawNodes(Node[] nodes,int numberOfNodes)
  {
    float tmpY=rootNode.getCoordenates()[1];
    float angleSteps = HALF_PI / numberOfNodes;
    Node node;
    if(rootDrawed==false)
    {
      noFill();
      rootDrawed=true;
    }
    for(int i=0;i<numberOfNodes;i++)
    { 
      node=nodes[i];
      if(node.getParent().equals(rootNode))
      {
        float angle = angleSteps * i+QUARTER_PI;
        float xRoot=rootNode.getCoordenates()[0];
        int cantChildrenRoot=rootNode.getCantChildren();
        float x = rootNode.getCoordenates()[0] + cos (angle)*radio; // cordenate x concidering the angle
        float y = rootNode.getCoordenates()[1] + sin (angle)*radio;     
        node.setCoordenates(x,y);
        
        int drawedNode = set.newShape(GraphicSet.MARK);
        set.setFillCode(drawedNode,node.getColor());
        set.setSymbolCode(drawedNode,symbolCode);
        set.setMarkAttr(drawedNode, diametro, diametro, TOP, GraphicSet.STATIC);
        set.vertex(node.getCoordenates()[0],node.getCoordenates()[1]);
        set.setLabel(drawedNode, node.getName());
        set.update();
      }
      else
      {
        drawChildren(node,node.getParent().getCoordenates()[0],node.getParent().getCoordenates()[1]-distance);
      }
    }
  }
  
  void drawChildren(Node node,float posX,float posY)
  {
    node.setCoordenates(posX,posY);
    int drawedNode = set.newShape(GraphicSet.MARK);
    set.setFillCode(drawedNode,node.getColor());
    set.setSymbolCode(drawedNode,symbolCode);
    set.setMarkAttr(drawedNode, diametro, diametro, TOP, GraphicSet.STATIC);
    set.vertex(node.getCoordenates()[0],node.getCoordenates()[1]);
    set.setLabel(drawedNode, node.getName());
    set.update();
    
    println(node.getCantChildren());
    if(node.getCantChildren()>0)
    {
      Node[] children=node.getChildrenList();
      for(int index=0;index>node.getCantChildren();index++)
      {
        drawChildren(children[index],posX,posY-distance);
      }
    }
  }
 
}
