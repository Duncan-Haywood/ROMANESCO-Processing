class Galaxie extends SuperRomanesco {
  public Galaxie() {
    //from the index_objects.csv
    romanescoName = "Galaxie" ;
    IDobj = 15 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode ="1 Point/2 Ellipse/3 Rectangle" ;
  }
  //GLOBAL
    boolean makeSand = true ;
  boolean shiftGrain = false ;
  boolean gravityGrain = true ;
  PVector posCenterGrain = new PVector(0,0,0) ;

  PVector orientationStyletGrain ;

  int numGrains ;
  int numFromControler ;
  PVector [] grain ;
  float vitesseGrainA = 0.0;
  float vitesseGrainB = 0.0 ;
  PVector vitesseGrain = new PVector (0,0) ;
  float speedDust ;
  //vibration
  float vibrationGrain = 0.1 ;
  //the stream of sand
  PVector deformationGrain = new PVector (0.0, 0.0 ) ;

  PVector motionGrain = new PVector (0.0 , 0.0) ;
  float newRayonGrain = 1 ;
  float variableRayonGrain = -0.001 ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/4, 0) ;
  }
  //DRAW
  void display() {
    
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) numFromControler = int(3*(sq(quantityObj[IDobj])) ) ; else numFromControler = 30 + int(10 *quantityObj[IDobj]) ;
    if (numGrains != numFromControler && parameterButton[IDobj] == 1 ) makeSand = true ;
    if (makeSand) {
      numGrains = numFromControler ;
      grainSetup(numGrains) ;
      makeSand = false ;
    }
 
    //give back the pen info
    float pressionGrain = sq(1 + pen[IDobj].z) ;
    orientationStyletGrain = new PVector ( 4* pen[IDobj].x , pen[IDobj].y ) ;
    
    //float vitesse = vitesseGrainA ;
   // float vitesseSound = gaucheDroite ;
    // speed / vitesse
    vitesseGrainA = map(left[IDobj],0,1, 1, 2) ;
    vitesseGrainB = map(right[IDobj],0,1, 1, 2) ;
    
    if(motion[IDobj]) speedDust = map(speedObj[IDobj],0,100, 0.0001 ,2) ; else speedDust = 0.0001 ;
    
    vitesseGrain.x = vitesseGrainA *speedDust *tempo[IDobj] *pressionGrain  ;
    vitesseGrain.y = vitesseGrainB *speedDust *tempo[IDobj] *pressionGrain  ;

    posCenterGrain.x = mouse[IDobj].x ;
    posCenterGrain.y = mouse[IDobj].y ;
    
    //size
    float objWidth =  .1 + sizeXObj[IDobj] *mix[IDobj] ;
    float objHeight = .1 +sizeYObj[IDobj] *mix[IDobj] ;
    PVector size = new PVector(objWidth, objHeight) ;
    
    //thickness / épaisseur
    float e = thicknessObj[IDobj] *mix[IDobj] ;

    color colorIn = fillObj[IDobj] ;
    color colorOut = strokeObj[IDobj] ;
    
    //surface
    PVector surface = new PVector(canvasXObj[IDobj], canvasYObj[IDobj], canvasZObj[IDobj])  ;
    
    /////////
    //UPDATE
    updateGrain(upTouch, downTouch, leftTouch, rightTouch, clickLongLeft[IDobj], surface);
    
    //////////////
    //DISPLAY MODE
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      pointSable(e, colorIn) ;
    } else if (mode[IDobj] == 1 ) {
      ellipseSable(size,e , colorIn, colorOut) ;
    } else if (mode[IDobj] == 2 ) {
      rectSable(size,e , colorIn, colorOut) ;
    } else {
      pointSable(objWidth, colorIn) ;
    }
  }
    
    
    //ANNEXE VOID
  //DISPLAY MODE
  void pointSable(float diam, color c) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(diam) ;
      stroke(c) ;
      point(grain[j].x, grain[j].y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  //
  void ellipseSable(PVector size, float e, color cIn, color cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      ellipse(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  //
  void rectSable(PVector size, float e, color cIn, color cOut) {
    for(int j = 0; j < grain.length; j++) {
      strokeWeight(e) ;
      stroke(cOut) ;
      fill(cIn) ;
      rect(grain[j].x, grain[j].y, size.x, size.y);
      //set(int(grain[j].x), int(grain[j].y), colorIn);
    }
  }
  
  //SETUP
  void grainSetup( int num) {
    grain = new PVector [num] ;
    for(int i = 0; i < num ; i++) {
      grain[i] = new PVector (random(width), random(height)) ;
    }
    makeSand = true ;
  }
    
    
  //void update  
  void updateGrain(boolean up, boolean down, boolean leftSide, boolean rightSide, boolean mouseClic, PVector area) {
    
    for(int i = 0; i < grain.length; i++) {
      newRayonGrain = newRayonGrain -variableRayonGrain ;
      
      motionGrain.x = grain[i].x -posCenterGrain.x -(deformationGrain.x +right[IDobj])  ;
      motionGrain.y = grain[i].y -posCenterGrain.y -(deformationGrain.y +left[IDobj] ) ;
  
      PVector posGrain = new PVector ( 0,0, 0) ;
      float r = dist(grain[i].x/vitesseGrain.x, grain[i].y /vitesseGrain.x, int(posCenterGrain.x) /vitesseGrain.x, int(posCenterGrain.y) /vitesseGrain.x);
      
      //spiral rotation
      if (mouseClic) {
        posGrain.x = cos(-1/r*vitesseGrain.y)*motionGrain.x - ( sin(-1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(-1/r*vitesseGrain.y)*motionGrain.x + ( cos(-1/r*vitesseGrain.y)*motionGrain.y );
      } else {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x - ( sin(1/r*vitesseGrain.y)*motionGrain.y );
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x + ( cos(1/r*vitesseGrain.y)*motionGrain.y );
      }
      // to make line veticale or horizontal
      if (rightSide || leftSide  ) {
        posGrain.x = cos(1/r*vitesseGrain.y)*motionGrain.x ;
        posGrain.y = sin(1/r*vitesseGrain.y)*motionGrain.x ;
      } else if (down || up) {
        posGrain.x = sin(-1/r*vitesseGrain.y)*motionGrain.y ;
        posGrain.y = cos(-1/r*vitesseGrain.y)*motionGrain.y ;
      }

      
      //the dot follow the mouse  
      posGrain.x += posCenterGrain.x;
      posGrain.y += posCenterGrain.y;
      
      PVector vibGrain = new PVector(random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain), random(-vibrationGrain,vibrationGrain) ) ; 
      //return pos of the pixel
      grain[i].x = posGrain.x + vibGrain.x;
      grain[i].y = posGrain.y + vibGrain.y;
      
      // wall to move the pos to one border to other
      //marge around the scene
      float margeWidth = area.x ;
      float margeHeight = area.y ;
      if(grain[i].x > width +margeWidth) grain[i].x = -margeWidth;
      if(grain[i].x < -margeWidth)     grain[i].x = width +margeWidth;
      if(grain[i].y > height + margeHeight) grain[i].y = -margeHeight;
      if(grain[i].y < -margeHeight)     grain[i].y = height +margeHeight;
    }
  }

}
