// CLASS ROMANESCO MANAGER
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<SuperRomanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<SuperRomanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "SuperRomanesco");
  }
  
  //STEP ONE
  //ADD CLASSES
  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        classes.add(c[i]);
        numClasses = classes.size() ;
      }
    }
    createIndex(numClasses) ;
    
    //init the String info
    objectNameRomanesco = new String[numClasses] ;
    for ( int i =0 ; i <objectNameRomanesco.length ; i++) objectNameRomanesco[i] =("") ;
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        objectNameRomanesco[numObjectRomanesco] = c[i].getSimpleName() ;
        numObjectRomanesco += 1 ;
      }
    }
    
    writeIndex() ;
    
    //show info object classes in the monitor
    /*
    println("Classes extends from " + superClassName + ":");  
    println(objectNameRomanesco);
    */
    return classes;  
  }
  //END ADD CLASSES
  /////////////////
  
  
  
  /////////////////////////////////////////////
  //CREATE an index.csv for the objects classes
  String pathObjects = sketchPath("")+"preferences/objects/" ;
  
  //create the canvas index
  void createIndex(int num) {
    indexObjects = new Table() ;
    indexObjects.addColumn("Library Order") ;
    indexObjects.addColumn("ID") ;
    indexObjects.addColumn("Version") ;
    indexObjects.addColumn("Name") ;
    indexObjects.addColumn("Author") ;
    indexObjects.addColumn("Class name") ;
    
    numObj = num +1 ;
    objectName = new String[numObj] ;
    objectID = new int[numObj] ;
    
    // add row
    rowIndexObject = new TableRow [numObj-1] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
  }
  
  // put information in the index
  void writeIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  
  //external void
  void finishTheIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      SuperRomanesco objR = (SuperRomanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.romanescoID) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
  }
    
  
  //END of the INDEX
  //////////////////
  
  
  
  
  /////////////////////////////////
  //ADD OBJECT from the sub-classes
  void addObjectRomanesco() {
    int n = floor(objectRomanescoList.size()-1) ;
    for( int i = 0 ; i <= n ; i++) {
    addObject(i) ;
    }
  }
  //
  public SuperRomanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    SuperRomanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (SuperRomanesco) constructors[0].newInstance(parent);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add object 
    if (f != null) {
      addObject(f);
    }
    return f;
  }
  
  // finalization of adding object
  private void addObject(SuperRomanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  
  
  
  // RENDERING
  void displayObject() {
    for (SuperRomanesco objR : RomanescoList) { 
      objR.display() ;
    }
  }
  // END RENDERING
}
//END OBJECT ROMANESCO MANAGER