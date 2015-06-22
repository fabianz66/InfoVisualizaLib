public class Node 
{
  private String name;
  private Node parent;
  private Node[] children;
  private int cantChildren=0;
  private float angle=0;
  private float posX=0;
  private float posY=0;
  private int level=0;
  private int col;
  public Node(String _name)
  {
    name=_name;
  }
  
  public void setColor(int _col)
  {
    col=_col;
  }
  
  public int getColor()
  {
    return col;
  }
  
  public void createChildrenList(int _cantChildren)
  {
    children = new Node[_cantChildren];
    cantChildren=_cantChildren;
  }
  
  public void setEmptyChildren()
  {
    children = new Node[0];
  }
  
  
  public Node[] getChildrenList()
  {
    return children;
  }
  
  public int getCantChildren()
  {
    return cantChildren;
  }
  
  public String getName()
  {
    return name;
  }
  
  public Node getParent()
  {
    return parent;
  }
  
  public void setParent(Node _parent)
  {
    parent=_parent;
  }
  
  public void setChild(Node _child, int index)
  {
    children[index]=_child;
  }
  public float[] getCoordenates()
  {
    float[] coordenates = { posX,posY };
    return coordenates;
  }
  
  public void setCoordenates(float _posX,float _posY)
  {
    posX=_posX;
    posY=_posY;
  }
  
  public void setAngle(float _angle)
  {
    angle=_angle;
  }
  
  public float getAngle()
  {
    return angle;
  }
  
  public int getLevel()
  {
    return level;
  }
  
  public void setLevel(int _level)
  {
    level=_level;
  }
}
