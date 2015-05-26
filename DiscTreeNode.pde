//------------------------------------------------------------------------------
// Representa un nodo dentro del arbol de disco
// Creada por: Fabian Zamora Ramirez
//------------------------------------------------------------------------------
  
public class DiscTreeNode
{
  //Attributes
  private String mName;
  private float mValue;
  private float mOrbitRadius;
  private float[] mChildrenAngles;
  
  //Children elements
  private ArrayList<DiscTreeNode> mChildren;
  
  //Constructor
  public DiscTreeNode(String pName, float pValue)
  {
    mName = pName;
    mValue = pValue;
    mChildren = new ArrayList<DiscTreeNode>();
  }
  
  //------------------------------------------------------------------------------
  // Manejo de nodos
  //------------------------------------------------------------------------------
  
  //Insert a children to the tree.
  //IMPORTANT: parent must be created first -> Must be first in the file
  //Otherwise it is not inserted
  public boolean insert(String pParentName, String pChildName, float pChildValue)
  {
    //Success
    boolean inserted = false;
    
    //We are at the parent
    if(pParentName.equals(mName))
    {
      mChildren.add(new DiscTreeNode(pChildName, pChildValue));
      println("Inserted:"+pChildName + " into:" + pParentName);
      inserted = true;
    }else
    {
      for(DiscTreeNode child : mChildren)
      {
        inserted = child.insert(pParentName, pChildName, pChildValue);        
        if(inserted) {          
          break;
        }
      }
    }
    return inserted;
  }
  
  // Add a child to this node
  public void addChild(DiscTreeNode pChild)
  {
    mChildren.add(pChild);
  }
  
  //------------------------------------------------------------------------------
  // Draw methods
  //------------------------------------------------------------------------------
  
  private void drawCircle(GraphicSet set, float pCenterX, float pCenterY, float pRadius, String pLabel)
  {
    int id = set.newShape();
    set.setAlpha(id, 1);
    float[] coords = set.arc(pCenterX, pCenterY, pRadius, 0, 6.28, OPEN);      
    for (int j=0; j<coords.length/2; j++) {
      set.vertex(coords[j*2],coords[j*2+1]);
    }            
    
    //Add label
    if(pLabel != null) {
      set.setLabel(id, pLabel);
    }

// Native processing    
//    fill (#ffedbc);
//    stroke (#A75265);
//    ellipse (pCenterX, pCenterY, SINGLE_NODE_DIAMETER, SINGLE_NODE_DIAMETER);
  }
  
  private void drawLine(GraphicSet set, float pStartX, float pStartY, float pFinishX, float pFinishY)
  {
    //Path1
    int id = set.newShape(GraphicSet.PATH);    
    set.vertex(pStartX, pStartY);
    set.vertex(pFinishX, pFinishY);
    
// Native processing
//  stroke (#0000FF);
//  line(pCenterX, pCenterY, childX, childY);
  }
  
  /**
   * Draws this node according to its children.
   * returns @{true} if success or @{false} is there was an error
  **/ 
  public void draw(GraphicSet pSet, float pCenterX, float pCenterY)
  {
        
    //Dibuja la orbita si tiene hijos
    if(mChildren.size() != 0) {
        drawCircle(pSet, pCenterX, pCenterY, 2*mOrbitRadius, null);
    }
    
    //Dibuja a los hijos
    float currentAngle = 0;
    for(int i=0; i < mChildren.size(); i++)
    {
      //Se debe aumentar la mitad del que se va a dibujar, 
      //porque el circulo empieza a dibujarse en la mitad.
      if(currentAngle != 0.0) {
        currentAngle += mChildrenAngles[i]/2;
      }
      
      //Posiciones del hijo       
      float childX = pCenterX + cos (currentAngle)*mOrbitRadius;
      float childY = pCenterY + sin (currentAngle)*mOrbitRadius;
      
      //Dibuja una linea entre si mismo y el hijo
      drawLine(pSet, pCenterX, pCenterY, childX, childY);
      
      //Manda a dibujar al hijo
      mChildren.get(i).draw(pSet, childX, childY);
      
      //Para dibujar el siguiente, se debe aumentar la mitad del angulo que acabamos de dibujar
      currentAngle += mChildrenAngles[i]/2;
    }
    
    //Se dibuja a si mismo
    drawCircle(pSet, pCenterX, pCenterY, SINGLE_NODE_DIAMETER, mName);
  }
  
  //------------------------------------------------------------------------------
  // Manejo de Radios
  //------------------------------------------------------------------------------
  
  /**
  * Establece el valor default la orbita.
  * Para cada nivel la orbita se hace mas pequena.
  * La orbita se puede hacer mas grande si los hijos no caben
  */
  public void setOrbitRadius(float pOrbitRadius)
  {
    //Establece su orbita
    mOrbitRadius = pOrbitRadius;
    
    //Establece la orbita a los hijos, en caso de que tengan hijos
    for(DiscTreeNode child : mChildren) {
       child.setOrbitRadius(pOrbitRadius/2);
    }
    
    //Ajusta su orbita, por si la de los hijos cambio
    //Ademas guarda los angulos de los hijos
    adjustOrbitRadius();
  }
  
  /**
  * Ajusta el tamano de la orbita segun la cantidad de hijos que tenga.  
  */
  public void adjustOrbitRadius()
  {
    
    //Si es hoja no hay que ajustar
    if(mChildren.size() == 0) {
      return;
    }
    
    //Intenta con el tamano original que tiene
    float[] childrenDiameters = new float[mChildren.size()];
    float[] childrenAngles = new float[mChildren.size()];
    
    //Obtiene los diametros de los hijos
    for(int i=0; i < mChildren.size(); i++) {
      childrenDiameters[i] = mChildren.get(i).getDiameter();
    }
        
    //Itera hasta encontrar el tamano de orbita que pueda meter a todos los hijos
    while(!getAnglesForChildren(childrenDiameters, mOrbitRadius, childrenAngles)) 
    {
      mOrbitRadius += mOrbitRadius/4; //Aumenta el tamano en un 25 porciento
    }
    
    //Guardas los angulos para cada hijo
    mChildrenAngles = childrenAngles;
  }
  
  /**
  * Obtiene el diametro de este nodo.
  * Si es hoja, es el default. Si no, depende de la orbita.
  */
  public float getDiameter()
  {
    //Si es hoja no hay que ajustar
    if(mChildren.size() == 0) {
      return SINGLE_NODE_DIAMETER;
    }else
    {
      //La orbita ya esta ajustada
      return 2*mOrbitRadius;
    }
  }
  
  //------------------------------------------------------------------------------
  // Manejo de angulos
  //------------------------------------------------------------------------------
  
  /**
  * Utiliza el teorema del coseno para calcular el angulo que va a necesita un circulo
  * segun su diametro dentro de la orbita a la cual pertenece
  * @return El angulo en radianes que va a necesitar.
  */
  private float getAngleForDiameter(float diameter, float orbitRadius)
  {
    //Suponemos que el pedazo de la circunferencia que necesita de la Orbita es igual a 1.5 veces el diametro.
    float scaledDiameter = 1.5*diameter;
    float temp = (2*orbitRadius*orbitRadius - scaledDiameter*scaledDiameter) / (2*orbitRadius*orbitRadius);
    return acos( temp );
  }
  
  /**
  * Obtiene los angulos que van a ocupar los hijos segun sus diametros dentro de la orbita.
  * @return {true} en caso de que los nodos se acomoden al tamano de la orbita o 
  * {false} en caso de que la orbita necesite hacerse mas grande para poder caber todos.
  */
  private boolean getAnglesForChildren(float[] diameters, float orbitRadius, float[] resultAngles)
  {  
    //Los nodos que tienen hijos se ponen primero. Las hojas se acomodan en el espacio que sobra.
    float nonLeavesTotalAngleInRadians = 0;
    
    //Se necesita la cantidad de hojas.
    int leavesCount = 0;  
    for(int i=0; i<diameters.length; i++)
    {  
      float diameter = diameters[i];
      if(diameter != SINGLE_NODE_DIAMETER)
      {
        //Aqui no es una hoja
        //Calcula el angulo que va a necesitar este circulo, segun el radio de la Orbita.
        
        float neededAngle = getAngleForDiameter(diameter, orbitRadius);
        nonLeavesTotalAngleInRadians += neededAngle;
        resultAngles[i] = neededAngle;
      }else
      {
        //Aqui es una hoja
        leavesCount += 1;      
      }
    }
    
    //Ahora hay que revisar cuanto espacio queda para las hojas
    float leavesAvailableAngleInRadians = TWO_PI - nonLeavesTotalAngleInRadians;
    
    //Ahora se revisa que ese espacio sea suficiente
    float singleLeafNeededAngleInRadians = getAngleForDiameter(1.5*SINGLE_NODE_DIAMETER, orbitRadius);
    float totalLeavesNeededAngleInRadians = leavesCount*singleLeafNeededAngleInRadians;
    if(leavesAvailableAngleInRadians > totalLeavesNeededAngleInRadians)
    {
      //Hay suficiente espacio. Se le debe asignar el angulo a las hojas.
      float leafAngle = leavesAvailableAngleInRadians/leavesCount;    
      for(int i=0; i<diameters.length; i++)
      {  
        float diameter = diameters[i];
        if(diameter == SINGLE_NODE_DIAMETER)
        {
          resultAngles[i] = leafAngle;
        }
      }
      return true;
  
    }else
    {
      //No hay suficiente espacio. Hay que hacer la Orbita mas grande.
      println("Error. Hacer orbita mas grande");
      return false;
    }
  }
  
  //------------------------------------------------------------------------------
  // Debug
  //------------------------------------------------------------------------------
  
  /**
  * Prints the name of the node and its children
  **/
  public void debug(String pInitialSpace)
  {
    println(pInitialSpace + mName);
    for(DiscTreeNode child : mChildren)
    {
      child.debug(pInitialSpace + "-");
    }
  }
  
}
