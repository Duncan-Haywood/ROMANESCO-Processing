/**
CROPE
CONTROL ROMANESCO PROCESSING ENVIRONMENT
*
SLIDER 
2015 - 2018
v 1.8.0
*/
boolean molette_already_selected ;
/**
CLASS SLIDER
*/
public class Slider {
  protected iVec2 pos, size;
  protected iVec2 pos_molette, size_molette;

  protected iVec2 pos_min, pos_max;

  protected int sliderColor = color(g.colorModeX /4);
  protected int molIn = color(g.colorModeX);
  protected int molOut = color(g.colorModeX /2);
  protected int colorText = color(0);
  // label
  protected int align = LEFT;
  protected String name = null;
  protected iVec2 pos_label;
  protected int color_label = color(g.colorModeX);
  protected PFont font_label;

  protected boolean lockedMol, insideMol ;
  protected float minNorm = 0 ;
  protected float maxNorm = 1 ;
  // advance slider
  protected int new_midi_value;
  protected int id_midi = -2 ;
  protected int id = -1;
  protected String moletteShapeType = ("") ;
  
  //CONSTRUCTOR minimum
  public Slider(iVec2 pos, iVec2 size) {
    set_pos(pos);
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) {
      size_molette = iVec2(size.y); 
    } else {
      size_molette = iVec2(size.x) ;
    }
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      pos_min = pos.copy();
      int correction = size_molette.y  + size_molette.x ;
      pos_max = iVec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(iVec2 pos, iVec2 size, iVec2 size_molette, String moletteShapeType) {
    set_pos(pos);
    this.size_molette = size_molette.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      pos_min = pos.copy();
      pos_max = iVec2(pos.x +size.x +size.y,  pos.y) ;
    } else {
      pos_min = pos.copy();
      int correction = size_molette.y  + size_molette.x ;
      pos_max = iVec2(pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }

  public void set_pos(int x, int y) {
    set_pos(iVec2(x,y));
  }

  public void set_pos(iVec2 pos) {
    if(this.pos == null || this.pos_molette == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
      } else {
        this.pos.set(pos);
      }

      if(this.pos_molette == null) {
        this.pos_molette = pos.copy();
      } else {
        this.pos_molette.set(pos);
      }
    }
  }

  public void set_label(String name, iVec2 pos_label, PFont font_label, int color_label, int align) {
    this.name = name;
    if(this.pos_label == null) {
      this.pos_label = iVec2(pos_label);
    } else {
      this.pos_label.set(pos_label);
    }
    this.font_label = font_label; 
    this.color_label = color_label;
    this.align = align;  
  }

  
  public void set_id_midi(int id_midi) {
    this.id_midi = id_midi;
  }


  public void set_id(int id) {
    this.id = id;
  }



  // setting the position from a specific value
  public void set_molette(float normPos) {
    // security to constrain the value in normalizing range.
    if(normPos > 1.) normPos = 1. ;
    if(normPos < 0) normPos = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) {;
      pos_molette.x = round(size.x *normPos +pos_min.x -(size_molette.y *normPos)); 
    } else {
      pos_molette.y = round(size.y *normPos +pos_min.y -(size_molette.x *normPos));
    }
  }


  
  public void select_molette() {
    lockedMol = select(lockedMol(), lockedMol) ;
  }


  public void update_molette() {
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (pos_molette.x < pos_min.x ) {
        pos_molette.x = pos_min.x ;
      }
      if (pos_molette.x > pos_max.x ) {
        pos_molette.x = pos_max.x ;
      }
    } else {
      // for the vertical slider
      if (pos_molette.y < pos_min.y ) {
        pos_molette.y = pos_min.y ;
      }
      if (pos_molette.y > pos_max.y ) {
        pos_molette.y = pos_max.y ;
      }
    }

    if (lockedMol) {
      if (size.x >= size.y) { 
        pos_molette.x = round(constrain(mouseX -(size_molette.x *.5), pos_min.x, pos_max.x)); 
      } else { 
        pos_molette.y = round(constrain(mouseY -(size_molette.y *.5), pos_min.y, pos_max.y));
      }
    }
  }

  // privat method
  public boolean select(boolean locked_method, boolean result) {
    // boolean result = original ;
    if(!molette_already_selected) {
      if (locked_method) {
        molette_already_selected = true ;
        result = true ;
      }
    } else {
      if (locked_method && shift_key) {
        result = true ;
      }
    }

    if (!mousePressed) { 
      result = false ; 
      molette_already_selected = false ;
    }
    return result ;
  }



  

  
  
  
  
  
  /**
  DISPLAY SLIDER
  v 2.0.0
  */
  //Slider display classic
  public void show() {
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
  }
  
  //Slider update with title
  public void show_label() {
    textAlign(align);
    textFont(font_label);
    fill(color_label);
    text(name,add(pos,pos_label));
  }

  
  //display molette
  void show_molette() {
    if(lockedMol || insideMol) { 
      fill(molIn); 
    } else { 
      fill(molOut ) ;
    }
    shape_molette() ;
    noStroke() ;
  }
  
  // display molette advanced
  void show_molette(color molIn, color molOut, color strokeIn, color strokeOut, float thickness) {
    this.molIn = molIn ;
    this.molOut = molOut ;

    strokeWeight(thickness) ;
    if(lockedMol || insideMol) {
      fill(molIn);
      stroke(strokeIn) ;
    } else {
      fill(molOut ) ;
      stroke(strokeOut) ;
    }
    shape_molette() ;
    noStroke() ;
  }
  
  void shape_molette() {
    if(moletteShapeType.equals("ELLIPSE") ) {
      ellipse(size_molette.x *.5 +pos_molette.x, size.y *.5 +pos_molette.y, size_molette.x , size_molette.y) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
    } else rect(pos_molette.x, pos_molette.y, size_molette.x , size_molette.y ) ;
  }
  
  


  
  
  // check if the mouse is inside the molette or not
  //rect
  boolean inside_slider() { 
    if(inside(pos,size,iVec2(mouseX,mouseY),RECT)) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  
  
  boolean inside_molette_rect() {
    if(inside(pos_molette,size_molette,iVec2(mouseX,mouseY),RECT)) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  

  //ellipse
  boolean insideMol_Ellipse() {
    float radius = size_molette.x ;
    int posX = int(radius *.5 +pos_molette.x ) ; 
    int posY = int(size.y *.5 +pos_molette.y) ;
    if(pow((posX -mouseX),2) + pow((posY -mouseY),2) < pow(radius,sqrt(3))) {
      insideMol = true ; 
    } else {
      insideMol = false ;
    }
    return insideMol ;
  }
  
  
  

  boolean lockedMol() {
    if (insideMol && mousePressed) {
      return true ; 
    } else {
      return false ;
    }
  }


  // update position from midi controller
  void update_midi(int val) {
    //update the Midi position only if the Midi Button move
    if (new_midi_value != val) { 
      new_midi_value = val ; 
      pos_molette.x = round(map(val, 1, 127, pos_min.x, pos_max.x));
    }
  }

  

  void load(int load) {
    pos_molette.x = load ;
  }
  
  // give the ID from the controller Midi
  /*
  void select_id_midi(int num) { 
    this.midi_id = num ; 
  }
  */
  
  //give the IDmidi 
  int get_id_midi() { 
    return this.id_midi ; 
  }

  int get_id() {
    return this.id;
  }


  float get_value() {
    float value ;
    if (size.x >= size.y) {
      value = map (pos_molette.x, pos_min.x, pos_max.x, minNorm, maxNorm) ; 
    } else {
      value = map (pos_molette.y, pos_min.y, pos_max.y, minNorm, maxNorm) ;
    }
    return value ;
  }
  
  float get_value_min() {
    return minNorm ;
  }
  float get_value_max() {
    return maxNorm ;
  }
  
  iVec2 get_pos_min() {
    return pos_min;
  }

  iVec2 get_pos_max() {
    return pos_max;
  }

  public iVec2 get_pos() {
    return pos;
  }

  public iVec2 get_size() {
    return size;
  }

  public iVec2 get_pos_molette() {
    return pos_molette;
  }

  public iVec2 get_size_molette() {
    return size_molette;
  }
}
/**
END SLIDER
*/




















/**
SLIDER ADJUSTABLE
v 1.0.0
*/
public class Slider_adjustable extends Slider {
  // size
  protected iVec2 sizeMinMax;
  protected iVec2 sizeMolMinMax;
  int widthMinMax = 10 ;
  // pos  
  protected iVec2 posMinMax;
  protected iVec2 newPosMin;
  protected iVec2 newPosMax;
  // color
  protected color adjIn = color(255) ;
  protected color adjOut = color(125) ; ;

  boolean lockedMin, lockedMax;
    
  Slider_adjustable(iVec2 pos, iVec2 size) {
    super(pos, size);
    this.newPosMax = iVec2();
    this.posMinMax = pos.copy();
    this.newPosMin = posMinMax.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = iVec2(widthMinMax, size.y);
  }
  
  //slider with external molette
  Slider_adjustable(iVec2 pos, iVec2 size, iVec2 size_molette, String moletteShapeType) {
    super(pos, size, size_molette, moletteShapeType);
    this.newPosMax = iVec2();
    this.newPosMin = iVec2();
    this.posMinMax = pos.copy();
    this.sizeMinMax = size.copy();
    this.sizeMolMinMax = iVec2(widthMinMax, size.y);
  }


  
  
  
  /**
  METHOD
  */
  void update_min_max() {
    float newNormSize = maxNorm -minNorm ;
    
    if (size.x >= size.y) sizeMinMax = iVec2(round(size.x *newNormSize), size.y) ; else sizeMinMax = iVec2(round(size.y *newNormSize), size.x) ;
    
    pos_min = iVec2(round(pos.x +(size.x *minNorm)), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    pos_max = iVec2(round(pos.x -size_molette.x +(size.x *maxNorm)), pos.y) ;
  }
  
  // update Min and Max value
  // update min value

  void select_min() {
    lockedMin = select(lockedMin(), lockedMin) ;
  }
  void update_min() {
    float range = size_molette.x *1.5 ;
    //
    /*
    if (lockedMin()) lockedMin = true ;
    if (!mousePressed) lockedMin = false ; 
    */
    
    if (lockedMin) {  
      if (size.x >= size.y) {
        // security
        if (newPosMin.x < pos_min.x ) newPosMin.x = pos_min.x ;
        else if (newPosMin.x > pos_max.x -range) newPosMin.x = round(pos_max.x -range);
        
        newPosMin.x = round(constrain(mouseX, pos.x, pos.x+size.x -range)); 
        // norm the value to return to method minMaxSliderUpdate
        minNorm = map(newPosMin.x, pos_min.x, pos_max.x, minNorm,maxNorm) ;
      } else newPosMin.y = round(constrain(mouseY -sizeMinMax.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
    }
  }
  
  void select_max() {
    lockedMax = select(lockedMax(), lockedMax) ;
  }
  // update maxvalue
  void update_max() {
    float range = size_molette.x *1.5 ;
    /*
    if (lockedMax()) lockedMax = true ;
    if (!mousePressed) lockedMax = false ; 
    */
    
    if (lockedMax) {  // this line is not reworking for the vertical slider
      if (size.x >= size.y) {
        // security
        if (newPosMax.x < pos_min.x +range)  newPosMax.x = round(pos_min.x +range);
        else if (newPosMax.x > pos_max.x ) newPosMax.x = pos_max.x ;
         newPosMax.x = round(constrain(mouseX -(size.y *.5) , pos.x +range, pos.x +size.x -(size.y *.5))); 
         // norm the value to return to method minMaxSliderUpdate
        pos_max = iVec2(round(pos.x -size_molette.x +(size.x *maxNorm)), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        Vec2 tempPosMax = Vec2(pos.x -(size.y *.5) +(size.x *maxNorm), pos_max.y) ;
        maxNorm = map(newPosMax.x, pos_min.x, tempPosMax.x, minNorm, maxNorm) ;
      } else newPosMax.y = round(constrain(mouseY -sizeMinMax.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
    }
    
  }
  
  // set min and max position
  void setMinMax(float newNormMin, float newNormMax) {
    minNorm = newNormMin ;
    maxNorm = newNormMax ;
  }
  
  
  
  
  
  
  
  
  
  // Display classic
  void display_min_max() {
    if(lockedMin || lockedMax || insideMax() || insideMin()) fill(adjIn) ; else fill(adjOut) ;
    noStroke() ;
    rect(pos_min.x, pos_min.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
    //  rect(newPosMin.x, newPosMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
  }
  
  // Display advanced
 void display_min_max(float normPos, float normSize, color adjIn, color adjOut, color strokeIn, color strokeOut, float thickness) {
    this.adjIn = adjIn ;
    this.adjOut = adjOut ;
    strokeWeight(thickness) ;
    if(lockedMin || lockedMax || insideMax() || insideMin()) {
      fill(adjIn) ;
      stroke(strokeIn) ;
    } else {
      fill(adjOut) ;
      stroke(strokeOut) ;
    }
    rect(pos_min.x, pos_min.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    // rect(newPosMin.x, newPosMin.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    noStroke() ;
  }
  
  
  
  
  
  
  // ANNEXE
  // INSIDE
  boolean insideMin() {
    if(inside(pos_min, sizeMolMinMax,iVec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  boolean insideMax() {
    iVec2 tempPosMax = iVec2(round(pos.x -(size.y *.5) +(size.x *maxNorm)), pos_max.y) ;
    if(inside(tempPosMax, sizeMolMinMax,iVec2(mouseX,mouseY),RECT)) return true ; else return false ;
  }
  
  //LOCKED
  boolean lockedMin () {
    if (insideMin() && mousePressed) return true ; else return false ;
  }
  
  boolean lockedMax () {
    if (insideMax() && mousePressed) return true ; else return false ;
  }



}
// END Extends class SLIDER
///////////////////////////
