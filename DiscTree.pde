
public class DiscTree 
{
  //Attributes. Global node. There can only be one.
  private Node mRootNode; 
  
  /**
  * Loads the hierarchy from a file.
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
          if(!mRootNode.insert(parentName, childName)) {
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
        mRootNode = new Node(columns[0]);        
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

public class Node
{
  
  //Attributes
  private String mName;
  
  //Children elements
  private ArrayList<Node> mChildren;
  
  //Constructor
  public Node(String pName)
  {
    mName = pName;
    mChildren = new ArrayList<Node>();
  }
  
  //Insert a children to the tree.
  //IMPORTANT: parent must be created first -> Must be first in the file
  //Otherwise it is not inserted
  public boolean insert(String pParentName, String pChildName)
  {
    //Success
    boolean inserted = false;
    
    //We are at the parent
    if(pParentName.equals(mName))
    {
      mChildren.add(new Node(pChildName));
      println("Inserted:"+pChildName + " into:" + pParentName);
      inserted = true;
    }else
    {
      for(Node child : mChildren)
      {
        inserted = child.insert(pParentName, pChildName);        
        if(inserted)
        {          
          break;
        }
      }
    }
    return inserted;
  }
  
  /**
  * Prints the name of the node and its children
  **/
  public void debug(String pInitialSpace)
  {
    println(pInitialSpace + mName);
    for(Node child : mChildren)
    {
      child.debug(pInitialSpace + "-");
    }
  }
  
}
