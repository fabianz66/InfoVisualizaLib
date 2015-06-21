//------------------------------------------------------------------------------
// Representa un nodo dentro del arbol de disco
// Creada por: Fabian Zamora Ramirez
//------------------------------------------------------------------------------
  
public class CandelabrumNode
{
  //Attributes
  
  private float mOrbitRadius;
  private String mName;
  private float mValue;
  private float mRadius;
  private float[] mChildrenAngles;
  
  //Children elements
  private ArrayList<CandelabrumNode> mChildren;
  
  //Constructor
  public CandelabrumNode(String pName, float pValue)
  {
    mOrbitRadius = CAND_ROOT_NODE_ORBIT_RADIUS;
    mName = pName;
    mValue = pValue;
    mChildren = new ArrayList<CandelabrumNode>();
  }
  
  //------------------------------------------------------------------------------
  // Manejo de nodos
  //------------------------------------------------------------------------------
  
  // Add a child to this node
  public void addChild(CandelabrumNode pChild)
  {
    mChildren.add(pChild);
  }
  
  //------------------------------------------------------------------------------
  // Draw methods
  //------------------------------------------------------------------------------
  
  // @param pColor : the color for the current map. Number between 1 and 8.
  // @param pColorAlpha: 0 for transparent - 255 for complete opaque
  private void drawCircle(GraphicSet set, float pCenterX, float pCenterY, float pRadius, String pLabel, int pColor, int pColorAlpha)
  {
    int id = set.newShape();
    set.setFillCode(id, pColor);
    set.setStrokeCode(MAX_COLOR_VALUE);
    set.setAlpha(id, pColorAlpha);
    float[] coords = set.arc(pCenterX, pCenterY, pRadius, 0, 6.28, CHORD);      
    for (int j=0; j<coords.length/2; j++) {
      set.vertex(coords[j*2],coords[j*2+1]);
    }            
    
    //Add label
    if(pLabel != null) {
      set.setLabel(id, pLabel);
    }
  }
  
  private void drawLine(GraphicSet set, float pStartX, float pStartY, float pFinishX, float pFinishY)
  {
    int id = set.newShape(GraphicSet.PATH);    
    set.setStrokeCode(MAX_COLOR_VALUE);
    set.vertex(pStartX, pStartY);
    set.vertex(pFinishX, pFinishY);
  }
  
  /**
   * Draws this node according to its children.
   * returns @{true} if success or @{false} is there was an error
  **/ 
  public void draw(GraphicSet pSet, float pCenterX, float pCenterY, float pMaxValue, float pMinValue)
  {                  
    //Establece sus valores de color y de lable segun su VALOR.
    int colorValue = MIN_COLOR_VALUE;
    if(mValue != -1) //Has a valid value
    {
      colorValue = (int)map(mValue, pMinValue, pMaxValue, MIN_COLOR_VALUE, MAX_COLOR_VALUE);
    }    
    
    //Se dibuja a si mismo
    drawCircle(pSet, pCenterX, pCenterY, mRadius, mName, colorValue, 255);
    
    //Dibuja a los hijos
    float currentAngle = 0;
    int childrenCount = mChildren.size();
    for(int i=0; i < childrenCount; i++)
    {             
        //Manda a dibujar al hijo
        mChildren.get(i).draw(pSet, pCenterX, pCenterY, currentAngle, mOrbitRadius, pMaxValue, pMinValue, true);
        
        //Para dibujar el siguiente, se debe aumentar la mitad del angulo que acabamos de dibujar
        currentAngle += mChildrenAngles[i];
    }
  }
  
  /**
   * Draws this node according to its children.
   * returns @{true} if success or @{false} is there was an error
  **/ 
  public float draw(GraphicSet pSet, float pRootX, float pRootY, float pAngle, float pPrevOrbitRadius, float pMaxValue, float pMinValue, boolean pLastNode)
  {    
    
    //Dibuja la orbita
//    if(mChildren.size()==0 && pLastNode){
//      drawCircle(pSet, pRootX, pRootY, pPrevOrbitRadius+mRadius, mName, MAX_COLOR_VALUE, 0);
//    }
      
    //Establece sus valores de color y de lable segun su VALOR.    
    int colorValue = MIN_COLOR_VALUE;
    if(mValue != -1) //Has a valid value
    {
      colorValue = (int)map(mValue, pMinValue, pMaxValue, MIN_COLOR_VALUE, MAX_COLOR_VALUE);
    }    
    
    //Se dibuja a si mismo    
    float x = pRootX + cos (pAngle) * (pPrevOrbitRadius+mRadius);
    float y = pRootY + sin (pAngle) * (pPrevOrbitRadius+mRadius);
    drawCircle(pSet, x, y, mRadius, mName, colorValue, 255);
    
    //Manda a dibujar los hijos    
    float orbit = (pPrevOrbitRadius + mRadius*2);
    int childrenCount = mChildren.size();
    if(childrenCount != 0)
    {
      for(int i=0; i < childrenCount; i++)
      {      
        orbit = mChildren.get(i).draw(pSet, pRootX, pRootY, pAngle, orbit, pMaxValue, pMinValue, pLastNode && i==(childrenCount-1));
      }
    }
    return orbit;
  }
  
  //------------------------------------------------------------------------------
  // Manejo de Radios
  //------------------------------------------------------------------------------
  
  /**
  * Establece el valor default la orbita.
  * Para cada nivel la orbita se hace mas pequena.
  * La orbita se puede hacer mas grande si los hijos no caben
  */
  public void setRadius(float pRadius)
  {
    //Establece su orbita
    mRadius = pRadius;
    
    //Establece la orbita a los hijos, en caso de que tengan hijos
    for(CandelabrumNode child : mChildren) {
       child.setRadius(pRadius*0.5);
    }
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
    float childrenDiameters = mChildren.get(0).getDiameter();
    float[] childrenAngles = new float[mChildren.size()];
        
    //Itera hasta encontrar el tamano de orbita que pueda meter a todos los hijos
    while(!getAnglesForChildren(childrenDiameters, mOrbitRadius, childrenAngles)) 
    {
      mOrbitRadius += 1; //Aumenta el tamano en un 10 porciento
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
    return 2*mRadius;
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
    float scaledDiameter = diameter;
    float temp = (2*orbitRadius*orbitRadius - scaledDiameter*scaledDiameter) / (2*orbitRadius*orbitRadius);
    return acos( temp );
  }
  
  /**
  * Obtiene los angulos que van a ocupar los hijos segun sus diametros dentro de la orbita.
  * @return {true} en caso de que los nodos se acomoden al tamano de la orbita o 
  * {false} en caso de que la orbita necesite hacerse mas grande para poder caber todos.
  */
  private boolean getAnglesForChildren(float childrenDiameters, float orbitRadius, float[] resultAngles)
  {  
    //Los nodos que tienen hijos se ponen primero. Las hojas se acomodan en el espacio que sobra.
    int childrenCount = resultAngles.length;
    if(childrenCount == 0) {
      return true;
    }
    
    float neededAnglePerChildren = getAngleForDiameter(childrenDiameters, orbitRadius);
    float availableAnglePerChildren = TWO_PI / childrenCount;    
    if(availableAnglePerChildren >= neededAnglePerChildren) {
      for(int i=0; i<resultAngles.length; i++) {

        //save the angle for every node        
        resultAngles[i] = availableAnglePerChildren;   
      }
      return true;
    }else {
      
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
    for(CandelabrumNode child : mChildren)
    {
      child.debug(pInitialSpace + "-");
    }
  }
  
}
