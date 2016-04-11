/**
CORE SCENE and PRESCENE 1.1.1
*/






/**
CHECK FOLDER
*/
void init_and_update_diplay_var() {
  rectMode (CORNER) ;
  textAlign(LEFT) ;
  sizeBackgroundP3D = new PVector(width *100, height *100, height *7.5) ;
}

/**
bitmap
*/
PImage[] bitmap_import ;
ArrayList bitmap_files = new ArrayList();
boolean folder_bitmap_is_selected = true ;
String [] bitmap_path ;
int count_bitmap_selection ;
int ref_bitmap_num_files ;


void load_bitmap(int ID) {
  check_bitmap_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_bitmap[ID] > bitmap_path.length ) which_bitmap[ID] = 0 ;

  if(bitmap_path != null && bitmap_path.length > 0) {
    String bitmap_current_path = bitmap_path[which_bitmap[ID]] ;
    if(!bitmap_current_path.equals(bitmap_path_ref[ID])) {
      bitmap_import[ID] = loadImage(bitmap_current_path) ;
    }
    bitmap_path_ref[ID] = bitmap_current_path ;
  }
}

void check_bitmap_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Images" ;
  String path = import_path +"bitmap" ;

  // String path = preference_path +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_bitmap_is_selected = true ;
    ref_bitmap_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_bitmap_is_selected) {
    count_bitmap_selection++ ;
    bitmap_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          bitmap_files.add(f);
        }
      }
    }
    // edit the image path
    bitmap_path = new String[bitmap_files.size()] ;
    for (int i = 0; i < bitmap_files.size(); i++) {
      File f = (File) bitmap_files.get(i);
      bitmap_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_bitmap_is_selected = false ;
  }
}


/**
svg
*/

RPEsvg[] svg_import ;
ArrayList svg_files = new ArrayList();
boolean folder_svg_is_selected = true ;
String [] svg_path ;
int count_svg_selection ;
int ref_svg_num_files ;


void load_svg(int ID) {
  check_svg_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_svg[ID] > svg_path.length ) which_svg[ID] = 0 ;

  if(svg_path != null && svg_path.length > 0) {
    String svg_current_path = svg_path[which_svg[ID]] ;
    if(!svg_current_path.equals(svg_path_ref[ID])) {
      println(svg_current_path) ;
      svg_import[ID] = new RPEsvg(svg_current_path, svg_current_path) ;
    }
    svg_path_ref[ID] = svg_current_path ;
  }
}

void check_svg_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Images" ;
  String path = import_path +"svg" ;

  // String path = preference_path +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_svg_is_selected = true ;
    ref_svg_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_svg_is_selected) {
    count_svg_selection++ ;
    svg_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("SVG") || lastThree.equals("svg")) {
          svg_files.add(f);
        }
      }
    }
    // edit the image path
    svg_path = new String[svg_files.size()] ;
    for (int i = 0; i < svg_files.size(); i++) {
      File f = (File) svg_files.get(i);
      svg_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_svg_is_selected = false ;
  }
}




/**
text
*/
String[] text_import ;
ArrayList text_files = new ArrayList();
boolean folder_text_is_selected = true ;
String [] text_path ;
int count_text_selection ;
int ref_text_num_files ;

void load_txt(int ID) {
  check_text_folder_scene() ;
  // which_text is the int return from the dropdown menu
  if(text_path != null && text_path.length > 0) {
    if(which_text[ID] > text_path.length ) which_text[ID] = 0 ;
    text_import[ID] = importText(text_path[which_text[ID]]) ;
  } else {
    text_import[ID] = "Big Brother has been burning all the books, it's not possible to read anything" ;
  }
    
}




void check_text_folder_scene() {
  // String path = sketchPath("") +"/" +preference_path +"Karaoke" ;
  String path = import_path +"karaoke" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(ref_text_num_files != allFiles.size() ) {
    folder_text_is_selected = true ;
    ref_text_num_files = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folder_text_is_selected) {
    count_text_selection++ ;
    text_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          text_files.add(f);
        }
      }
    }
    // edit the path file
    text_path = new String[text_files.size()] ;
    for (int i = 0; i < text_files.size(); i++) {
      File f = (File) text_files.get(i); 
      text_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_text_is_selected = false ;
  }
}


/**
movie
*/
Movie[] movie_import ;
ArrayList movie_files = new ArrayList();
boolean folder_movie_is_selected = true ;
String [] movie_path ;
int count_movie_selection ;
int ref_movie_num_files ;

void load_movie() {
}
void check_movie_folder_scene() {

}



/**
method to check folder
*/
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}
/**
END CHECK FOLDER
*/


























/**
Text manager
*/
// NEW VOID TEXT
String importRaw [] ;



String importText(String path) {
  importRaw = loadStrings(path) ;
  return join(importRaw, "") ;
}


// info num Chapters
int numChapters(String txt) {
  String chapters [] = split(txt, "*") ;
  return chapters.length ;
}

// info num Sentences
int numMaxSentencesByChapter(String txt) {
  String chapters [] = split(txt, "*") ;
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  
  return maxSentencesByChapter ;
}



String whichSentence(String txt, int whichChapter, int whichSentence) {
  String chapters [] = split(txt, "*") ;
  String  [][] repartition ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  repartition = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      repartition [i][j] = sentences[j] ;
    }
  }
  //security
  if(whichChapter > chapters.length ) whichChapter = 0 ;
  if(whichSentence > maxSentencesByChapter ) whichSentence = 0 ;
  
  return repartition[whichChapter][whichSentence] ;
}

/**
End text manager
*/
















/**
MIROIR
*/

boolean syphon_on_off  ;
SyphonServer server ;


void syphon_settings() {
  PJOGL.profile=1;
}

void syphon_setup() {
  String name_syphon = (nameVersion + " " + prettyVersion +"."+version) ;
  server = new SyphonServer(this, name_syphon);
}

void syphon_draw() {
  if(yTouch) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
}
/**
END MIROIR
*/










/**
DISPLAY INFO
*/
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


void info() {
  color color_text = color(0,0,100) ;
  color color_bg = color(0,100,100,50) ;
  if (displayInfo) {
    //perspective() ;
    displayInfoScene(color_bg,color_text) ;
    displayInfoObject(color_bg,color_text) ;
  }
  if (displayInfo3D) displayInfo3D(color_text) ;
}

void displayInfoScene(color bg_txt, color txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(txt) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(fullRendering) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon_on_off + " / press “y“ to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(pen[0]) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Directional light ONE || pos " + int(pos_light[1].x)+ " / " + int(pos_light[1].y) + " / "+ int(pos_light[1].z) + " || dir " + decimale(dir_light[1].x,2) + " / " + decimale(dir_light[1].y,2) + " / "+ decimale(dir_light[1].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  text("Directional light TWO || pos " + int(pos_light[2].x)+ " / " + int(pos_light[2].y) + " / "+ int(pos_light[2].z) + " || dir " + decimale(dir_light[2].x,2) + " / " + decimale(dir_light[2].y,2) + " / "+ decimale(dir_light[2].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + right_volume_info, 15, 15 *(posInfo)) ;  
  text("left "  + left_volume_info,  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;

void displayInfoObject(color bg_txt, color txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(txt) ;
  textFont(SansSerif10, 10) ;
  
  posInfoObj = 1 ;
  // for (Romanesco objR : RomanescoList)
  for(int i = 0 ; i < numObj ; i++) {
    
    if(show_object[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)posObjX[i] + " y:" + (int)posObjY[i]+ " z:" + (int)posObjZ[i]) ;
      text(objectName[i] + " - Coord " + position + " - " + objectInfo[objectID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
void displayInfo3D(color txt) {
   String posCam = ( int(-1 *sceneCamera.x ) + " / " + int(sceneCamera.y) + " / " +  int(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( int(eyeCamera.x) + " / " + int(eyeCamera.y) ) ;
  fill(txt) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}



//////
//P3D

//REPERE 3D
void repere(int size, PVector pos, String name) {
  pushMatrix() ;
  translate(pos.x +20 , pos.y -20, pos.z) ;
  fill(blanc) ;
  text(name, 0,0) ;
  popMatrix() ;
  line(-size +pos.x,pos.y, pos.z,size +pos.x, pos.y, pos.z) ;
  line(pos.x,-size +pos.y, pos.z, pos.x,size +pos.y, pos.z) ;
  line(pos.x, pos.y,-size +pos.z, pos.x, pos.y,size +pos.z) ;
}
//repere cross
void repere(int size) {
  line(-size,0,0,size,0,0) ;
  line(0,-size,0,0,size,0) ;
  line(0,0,-size,0,0,size) ;
}



//END P3D
/////////
/**
END DISPLAY INFO
*/





//DRAWING
//CROSS
void crossPoint2D(PVector pos, color colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}


// other cross
void crossPoint2D(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
void crossPoint3D(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x,0, pos.x, pos.y +size.x,0) ;
  //vertical
  line(pos.x +size.y, pos.y,0, pos.x -size.y, pos.y,0) ;
  //depth
  line(pos.x, pos.y,size.z, pos.x, pos.y,-size.z) ;
}
//


//END DRAWING
////////////
















// MISC
///////


//curtain
void curtain() {
  if(!onOffCurtain) {
    rectMode(CORNER) ;
    fill (0) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
  }
}
//end curtain



// OS mac DETECTION
boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}



// END MISC
///////////








//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch, cmdTouch ;
//long touch
boolean cLongTouch, lLongTouch, nLongTouch, vLongTouch,
        spaceTouch, shiftLongTouch ;  

//END KEYBOARD
//////////////






//DETECTION
//CIRLCLE
boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}
//DETECTION





////////
//TIME
int minClock() {
  return hour()*60 + minute() ;
}


//timer
int chrnmtr, chronometer, newChronometer ;

int timer(float tempo) {
  int translateTempo = int(1000 *tempo) ;
  newChronometer = millis()%translateTempo ;
  if ( chronometer > newChronometer ) {
    chrnmtr += 1  ;
  }
  chronometer = newChronometer ;
  return chrnmtr ;
}

//make cycle from speed
float totalCycle ;
float cycle(float add) {
  totalCycle += add ; // choice here the speed of the cycle
  return sin(totalCycle) ;
}


//END TIME
///////////



// EASING
////////
PVector targetIN = new PVector () ;
//Pen
PVector easingIN = new PVector () ;
//
PVector easing(PVector targetOUT, float effectOUT) {
  targetIN.x = targetOUT.x;
  float dx = targetIN.x - easingIN.x;
  if(abs(dx) > 1) {
    easingIN.x += dx * effectOUT;
  }
  
  targetIN.y = targetOUT.y;
  float dy = targetIN.y - easingIN.y;
  if(abs(dy) > 1) {
    easingIN.y += dy * effectOUT;
  }
  return easingIN ;
}
//
void resetEasing(PVector targetOUT) {
  easingIN.x = targetOUT.x ; easingIN.y = targetOUT.y ;
}
//end easing




//////////////////
//tracking with pad
void nextPreviousKeypressed() {
    //tracking
  nextPrevious = true ;
}
//
int tracking(int t, int n) {
  if (nextPrevious) {
    if (downTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    } else if (upTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } 
  }
  if (nextPrevious) {
    if ( leftTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } else if ( rightTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    }
  }
  nextPrevious = false ;
  return trackerUpdate ;
}
//END nextPrevious







