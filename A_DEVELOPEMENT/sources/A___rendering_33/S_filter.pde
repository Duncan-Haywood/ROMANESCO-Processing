
/**
FILTER
2018-2018
v 0.0.3
*/
Warp warp_romanesco;
void init_filter() {
  if(FULL_RENDERING) {
    // force
    type_field = r.FLUID;
    pattern_field = r.BLANK;
    set_type_force_field(type_field);
    init_force_field();
    // set_different_force_field();
    println("init filter Force Field part");
    // warp
    init_warp();
    println("init filter warp part");
  }
}


void filter() {
  if(FULL_RENDERING && fx_button_is(0)) {
    warp();
  } 
}





/**
WARP
2018-2018
v 0.0.3
this chapter is the place where the pixel is filtering
*/
void init_warp() {
  if(warp_romanesco == null) {
    warp_romanesco = new Warp(preference_path+"/shader/");
    warp_romanesco.add(g);
  }
}


void warp() {
  float intensity_warp = map(value_slider_fx[0],0,360,0,1);
  intensity_warp *= intensity_warp;
  intensity_warp = map(intensity_warp,0,1,0,10);
  
  // cycling
  float cycling = 1;
  float ratio = map(value_slider_fx[1],0,360,0,.8);
  if(ratio > 0) {
    ratio = (ratio*ratio*ratio);
    cycling = abs(sin(frameCount *ratio));
  }

  float cx = map(value_slider_fx[2],0,360,0,1);
  float cy = map(value_slider_fx[3],0,360,0,1);
  float cz = map(value_slider_fx[4],0,360,0,1);
  float ca = 1; // change nothing at this time
  Vec4 refresh_warp = Vec4(cx,cy,cz,ca);
  if(ratio > 0) {
    refresh_warp.mult(cycling);
  }

  warp_romanesco.refresh(refresh_warp);
  warp_romanesco.shader_init();
  boolean filter_fx = fx_button_is(1);
  warp_romanesco.shader_filter(filter_fx);
  warp_romanesco.shader_mode(0);
  // here Force_field is pass
  warp_romanesco.show(force_romanesco,intensity_warp);

  if(warp_reset) {
    warp_romanesco.reset();
    warp_reset = false;
  }
}










boolean warp_reset;
void warp_keyPressed(char c_1) {
  if(key == c_1) {
    println("Reset Warp",frameCount);
    warp_reset = true;
  }
}































