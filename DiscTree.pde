 
//Constantes
public static final float ROOT_NODE_ORBIT_RADIUS = 100;
public static final float SINGLE_NODE_DIAMETER = 10;
  
//------------------------------------------------------------------------------
// Representa un arbol en disco
// Creada por: Fabian Zamora Ramirez
//------------------------------------------------------------------------------
public class DiscTree extends Layer
{
  //Attributes. Global node. There can only be one.
  private DiscTreeNode mRootNode; 
  private float mCenterX;
  private float mCenterY;
  
  /**
  * Constructor
  */
  DiscTree(int x, int y, int w, int h) {
    super(x, y, w, h);    
    mCenterX = x + w/2;
    mCenterY = y + y/2;
  }
  
  /**
  * Loads the hierarchy from a column separated file.
  * Files must have only one global line at the beginning. (1 without a parent)
  * All the other lines must have a previously created parent. If a parent is not found, that line is ommitted.
  * returns @{true} if success or @{false} is there was an error loading the file
  */
  public boolean load(String pFilename, String pDelimeter)
  {        
    //Iterate over the lines to generate the tree with nodes.
    String[] lines = loadStrings(pFilename);
    int linesCount = lines.length;
    println("linesCount:", linesCount);
    for(int lpos=0; lpos < linesCount; lpos++)
    {
      //Get the number of columns for each line
      println("line:", lines[lpos]);
      String[] columns = split(lines[lpos], pDelimeter);
      int columnsCount = columns.length;
      
      //According to the number of columns, it creates a child or the root node.
      //Files must be in the hierarchy order. Global, Global-Children, Global-Children-Children and so on.
      if(columnsCount == 2)
      {        
        if(mRootNode != null)
        {
          //We are about to add a children
          String childName = columns[0].trim();
          String parentName = columns[1].trim();
          float childValue = 0.0;
          if(!mRootNode.insert(parentName, childName, childValue)) {
            println("Error." + parentName + " not found. " + childName + " was ommitted.");
          }
        }else
        {
          println("Error. Root row (1 column) must be the first one.");
          return false;
        }
        
      }else if(columnsCount == 1 && mRootNode == null) 
      {       
        //Create root node
        mRootNode = new DiscTreeNode(columns[0], 0.0);        
      }else if(columnsCount == 1 && mRootNode != null) 
      {       
        //Error. There can only be one Global node.
        println("Error. Only one row can be global (1 column)");
        return false;       
      }
    }
    
    //Check if root node was successfully created
    if(mRootNode != null) {
      return true;
    }else {    
      println("RootNode not created");
      return false;
    }
  }  
  
  /**
  * Loads the hierarchy from a JSON file.
  * Files must have only one global parent.
  * @returns @{true} if success or @{false} is there was an error loading the file
  */
  public boolean loadJSON(String pFilename)
  {            
    //Load json and parse it
    
    try{
      
      //Tries to load json
      JSONObject json = loadJSONObject(pFilename);    
      mRootNode = nodeFromJSONObject(json);
      
    }catch(Exception e)
    {
      println("Could not find "+pFilename);
    }
      
    //Check if root node was successfully created
    if(mRootNode != null) {
      return true;
    }else {    
      println("RootNode not created");
      return false;
    }
  }
  
  /**
  * Creates a node with all its children from a JSONObject
  * @returns the created node with all its children  
  */
  private DiscTreeNode nodeFromJSONObject(JSONObject pObject)
  {
    //Get values
    String nodeLabel = pObject.getString("name", "");
    float nodeValue = pObject.getFloat("size", 0.0);
    
    //Create node
    DiscTreeNode node = new DiscTreeNode(nodeLabel, nodeValue);
    
    //Add children if any
    try{      
      JSONArray children = pObject.getJSONArray("children");
      for(int i=0; i < children.size(); i++)
      {
        DiscTreeNode child = nodeFromJSONObject(children.getJSONObject(i));
        node.addChild(child);
      }
    }catch(Exception e)
    {
      println("Children not found");
    }
    return node;
  }  
  
  /**
   * Draws the tree.
   * returns @{true} if success or @{false} is there was an error
  **/ 
  public boolean draw(GraphicSet pSet)
  {
    if(mRootNode == null)
    {
      println("Data not loaded");
      return false;
    }
    
    if(pSet == null)
    {
      println("Set can not be null");
      return false;
    }
    
    //Ajusta las orbitas y angulos de todos los nodos
    mRootNode.setOrbitRadius(ROOT_NODE_ORBIT_RADIUS);
    
    //Comienza a dibujarse
    mRootNode.draw(pSet, mCenterX, mCenterY);    
    return true;
  }
  
  /**
  * Prints the tree in console
  **/
  public void debug()
  {
    if(mRootNode != null)
    {
      println("\n Disc Tree data START \n");
      mRootNode.debug("");
      println("\n Disc Tree data END \n");
    }
  }
}
