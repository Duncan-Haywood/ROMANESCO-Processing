/**
RENDERING
v 1.0.0
*/
void rendering() {
  boolean show_is = true;
  // setting display
  if(curtain_button_is()) {
    show_is = false;
  }
  if(IAM.equals("presecene") && LIVE) {
    show_is = true;
  }

  // display
  if(show_is) {
    rendering_background(USE_LAYER,0);

    rendering_item_3D(USE_LAYER,1);

    rendering_item_2D(USE_LAYER,1);
    force();
    filter();   
    rendering_info(USE_LAYER);

  } else {
    rendering_curtain(USE_LAYER);   
  }
}


void rendering_item_3D(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    get_layer(which_layer);
    begin_layer();
    rendering_item_final_3D();
    end_layer();
  } else {
    rendering_item_final_3D();
  }
}


void rendering_item_final_3D() {
 
  camera_romanesco_draw();

  // LIGHT
  
  light_position_draw(mouse[0], wheel[0]); // not in the conditional because we need to display in the info box
  light_update_position_direction();
  if(FULL_RENDERING) {
    light_call_shader();
    light_display();
    shader_draw();
  }
  
  //use romanesco object
  rpe_manager.show_item_3D(ORDER_ONE,ORDER_TWO,ORDER_THREE);

  grid_romanesco(displayInfo3D);
  stop_camera();
}




void rendering_background(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    select_layer(which_layer);
    begin_layer();
    background_romanesco();
    end_layer();
  } else {
    background_romanesco();
  }
}



void rendering_item_2D(boolean use_layer_is, int which_layer) {
  if(use_layer_is) {
    get_layer(which_layer);
    begin_layer();
    rpe_manager.show_item_2D();
    end_layer();
  } else {
    rpe_manager.show_item_2D();
  }
}



void rendering_curtain(boolean use_layer_is) {
  if(use_layer_is) {
    get_layer(get_layer_num() -1);
    begin_layer();
    curtain();
    end_layer();
  } else {
    curtain();
  }
}

void rendering_info(boolean use_layer_is) {
  if(use_layer_is) {
    get_layer(get_layer_num() -1);
    begin_layer();
    info();
    end_layer();
  } else {
    info();
  }
}






























/**
INIT Romanesco
*/
boolean init_romanesco = true ;
void init_romanesco() {
  rectMode(CORNER);
  textAlign(LEFT);
  
  if(init_romanesco) {
    int which_setting = 0 ;
    for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i ++) {
      reset_direction_item (which_setting, i) ;
      update_ref_direction(i) ;
      // check for null before start
      if(dir_item_final[i] == null) dir_item_final[i] = Vec3() ;
      if(pos_item_final[i] == null) {
        float x = -(width/2) ;
        float y = -(height/2) ;
        pos_item_final[i] = Vec3(x,y,0) ;
      }
    }
    init_romanesco = false ;
  }
}




/**
DISPLAY SETUP
2015-2018
v 1.1.0
*/
String displayMode = ("");
int depth_scene;
void display_setup(int frame_rate, int num_layer) {
  if(IAM.equals("scene")) {
    background_rope(0);
    noCursor();
  }
  frameRate(frame_rate);  // Le frameRate doit être le même dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a);


  set_screen();
  depth_scene = height;
  background_setup();
  background_shader_setup();

  // resize layer
  if(USE_LAYER) {
    init_layer(width,height,num_layer);
    for(int i = 0 ; i < get_layer_num() ; i++) {
      select_layer(i);
      begin_layer();
      colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a);
      end_layer();
    }
  } 
}


void set_screen() {
  Table configurationScene = loadTable(preference_path +"sceneProperty.csv","header");
  TableRow row = configurationScene.getRow(0);
  int w = width;
  int h = height;
  int x = 0;
  int y = 0;

  if(IAM.equals("prescene")) {
    x = row.getInt("prescene_x"); 
    y = row.getInt("prescene_y");
  } else {
    x = row.getInt("scene_x"); 
    y = row.getInt("scene_y");
  }

  if(FULL_RENDERING) {
    w = row.getInt("width"); 
    h = row.getInt("height");
    
    if(!FULL_SCREEN) {
      surface.setLocation(x,y);
      surface.setSize(w,h);
    } else {
      int target_screen = row.getInt("whichScreen");
      println("The",IAM,"is on the screen",target_screen,"on",get_display_num(),"screen available");    
      int ox = get_screen_location(target_screen).x;
      int oy = get_screen_location(target_screen).y;
      surface.setLocation(ox,oy);
      int sx = get_screen_size(target_screen).x;
      int sy = get_screen_size(target_screen).y;
      surface.setSize(sx,sy);
      for(int i = 0 ; i < get_display_num() ; i++) {
        println("screen",i,"location",get_screen_location(i));
        println("screen",i,"size",get_screen_size(i));
      }
      println("target screen",target_screen,"location:",ox,oy);
      println("target screen",target_screen,"size:",sx,sy);
      w = sx; 
      h = sy;
    }   
  } else {
    w = row.getInt("preview_width"); 
    h = row.getInt("preview_height");
    surface.setLocation(x,y);
    surface.setSize(w,h);
  }
  scene_width = w;
  scene_height = h;
  println(IAM,"screen size [",w,",",h,"]"); 
}
























/**
OPENING
2018-2018
*/
void opening_display_message() {
  if(IAM.equals("scene")) {
  // if(IAM.equals("scene") || !LIVE) {
    background_rope(0);
    message_opening();
  } else if(IAM.equals("prescene") && FULL_RENDERING) {
    background_rope(0);
    message_opening();
  }
}


void message_opening() {
  fill(blanc);
  stroke(blanc);
  textSize(48);
  textAlign(CENTER);
  start_matrix();
  translate(width/2, height/2, abs(sin(frameCount * .005)) *(height/2)) ;
  text(nameVersion.toUpperCase(),0,-12);
  textSize(24);
  text(prettyVersion+"." + version,0,16);
  text("rendering " +IAM,0,36);
  stop_matrix() ;
  textAlign(LEFT) ;
}
































































































/**
MIROIR
v 0.1.0
*/
boolean syphon_on_off  ;
SyphonServer server ;
void syphon_settings() {
  PJOGL.profile=1;
}

void syphon_setup() {
  String name_syphon = (nameVersion + " " + prettyVersion +"."+version) ;
  server = new SyphonServer(this, name_syphon);
  println("Syphon setup done") ;
}

void syphon_draw() {
  if(key_y) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
}






















/**
DISPLAY INFO
v 0.2.1
*/
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;
void info() {
  sounda.info(displayInfo);
  color color_text = color(0,0,100);
  color color_bg = color(0,100,100,50);

  if (displayInfo) {
    //perspective() ;
    displayInfoScene(color_bg,color_text) ;
    displayInfoObject(color_bg,color_text) ;
  }
  if (displayInfo3D) {
    displayInfo3D(color_text);
  }
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
  if(FULL_RENDERING) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon_on_off + " / press “y“ to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(Vec2(pen[0].x,pen[0].y)) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Directional light ONE || pos " + int(pos_light[1].x)+ " / " + int(pos_light[1].y) + " / "+ int(pos_light[1].z) + " || dir " + decimale(dir_light[1].x,2) + " / " + decimale(dir_light[1].y,2) + " / "+ decimale(dir_light[1].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  text("Directional light TWO || pos " + int(pos_light[2].x)+ " / " + int(pos_light[2].y) + " / "+ int(pos_light[2].z) + " || dir " + decimale(dir_light[2].x,2) + " / " + decimale(dir_light[2].y,2) + " / "+ decimale(dir_light[2].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (get_time_track() > 1 ) text("the track play until " +get_time_track() + " – tempo " + get_tempo_name() + " " + get_tempo() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + get_right(100), 15, 15 *(posInfo)) ;  
  text("left "  + get_left(100),  50, 15 *(posInfo)) ;
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
  for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++) {
    if(show_item[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)pos_item[i].x + " y:" + (int)pos_item[i].y+ " z:" + (int)pos_item[i].z) ;
      text(item_name[i] + " - Coord " + position + " - " + item_info[item_ID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}











//INFO 3D
void displayInfo3D(color txt) {
  String posCam = ( int(-1 *sceneCamera.x ) + " / " + int(sceneCamera.y) + " / " +  int(sceneCamera.z -height/2));
  String eyeDirectionCam = (int(eyeCamera.x) + " / " + int(eyeCamera.y));
  fill(txt); 
  textFont(SansSerif10, 10);
  textAlign(RIGHT);
  text("Position " +posCam, width/2 -30 , height/2 -30);
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15);
}


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











