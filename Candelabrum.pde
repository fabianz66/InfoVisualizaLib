
//Constantes
public static final float CAND_ROOT_NODE_RADIUS = 50;
public static final float CAND_ROOT_NODE_ORBIT_RADIUS = 5;

  
//------------------------------------------------------------------------------
// Representa un arbol en disco
// Creada por: Fabian Zamora Ramirez
//------------------------------------------------------------------------------
public class Candelabrum extends Layer
{
  //Attributes. Global node. There can only be one.
  private CandelabrumNode mRootNode; 
  private float mCenterX;
  private float mCenterY;
  private float mMaxValue = -1;
  private float mMinValue = -1;
  
  /**
  * Constructor
  */
  Candelabrum(int x, int y, int w, int h) {
    super(x, y, w, h);    
    mCenterX = x + w/2;
    mCenterY = y + h/2;
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
  private CandelabrumNode nodeFromJSONObject(JSONObject pObject)
  {
    //Get values
    String nodeLabel = pObject.getString("name", "");
    float nodeValue = pObject.getFloat("size", -1);
    
    //Set new Max and Min Values
    if(nodeValue > mMaxValue || mMaxValue == -1) {
      mMaxValue = nodeValue;
    }else if(nodeValue < mMinValue || mMinValue == -1) {
      mMinValue = nodeValue;
    }
        
    //Create node
    CandelabrumNode node = new CandelabrumNode(nodeLabel, nodeValue);
    
    //Add children if any
    try{      
      JSONArray children = pObject.getJSONArray("children");
      for(int i=0; i < children.size(); i++)
      {
        CandelabrumNode child = nodeFromJSONObject(children.getJSONObject(i));
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
    mRootNode.setRadius(CAND_ROOT_NODE_RADIUS);
    mRootNode.adjustOrbitRadius();
    
    //Comienza a dibujarse
    mRootNode.draw(pSet, mCenterX, mCenterY, mMaxValue, mMinValue);
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
