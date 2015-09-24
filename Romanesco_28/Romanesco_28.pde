  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.1.1 / version 28 / made with Processing 3.0b7 ///
////////////////////////////////////////////////////////////////////
/* 730 lines of code the 4th may !!!! */
String version = ("28") ;
String prettyVersion = ("1.1.1") ;
String nameVersion = ("Romanesco Unu") ;


void settings() {
  size(400, 220);
}


void setup() {
  colorSetup() ;
  diplaySetup() ;
  
  structureSetup() ;
  loadSetup() ;
}
void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Launcher");
  displayDraw() ;
  launcherDraw() ;
}
// END DRAW








//MOUSEPRESSED
void mousePressed() {
  //which type of SCENE display full screen or window
  //to re-init the button
  if (buttonFullscreen.inside || buttonWindow.inside || buttonScene.inside || buttonMiroir.inside) {
    buttonScene.OnOff = false ;
    buttonMiroir.OnOff = false ;
    buttonFullscreen.OnOff = false ;
    buttonWindow.OnOff = false ;
  }
  // after the re-init we can check what's happen on the button
  buttonScene.mouseClic() ;
  buttonMiroir.mouseClic() ;
  buttonFullscreen.mouseClic() ;
  buttonWindow.mouseClic() ;
  
  //which screen for the fullscreen mode
  if(buttonFullscreen.OnOff) whichScreenPressed() ;
  
  //button start
  buttonStart.mouseClic() ;
  if(buttonStart.OnOff ) {
    saveProperty() ;
    openApp(openScene) ;
  }
  buttonStart.OnOff = false ;
}


//MOUSELEASED
void mouseReleased() {
  if(buttonFullscreen.OnOff) whichScreenReleased() ;
}



