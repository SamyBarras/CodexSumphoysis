public void mousePressed() {
  if (onoff==true){
    if ((distance/global_mult) < 100) {
      if (rotat==rotatB) {
        draw_sonar = true;
        play_bubble_sound(); // not sure this works
        if (gConnection) gConnection.send("btapp");
      } else {
        draw_badSonar = true;
      }
    }
  }
}
void mouseReleased() {
  timeur_defin();
  if (onoff==false) {
    ws_connect();
    onoff=true;
  }
}

public void rescaling() {
  w= $(window).width();
  h = $(window).height();

  if (w>h) rat= h;
  else rat = w;

  if (x_format>y_format) format= y_format;
  else format = x_format;

  if (rat > format) {
    rat2=1;
    w = x_format;
    h = y_format;
  } else {
    w = $(window).width();
    h = $(window).height();
    rat2 = rat/format;
  }
  size (w, h);
  global_mult = rat2*zoom;
}

int nMouseX, nMouseY, prevMouseX, prevMouseY;
float a, b = 0.;
float rota, oldRot, accr, rotation= 0.;
int  distance;
boolean dragging;
float damp = .9;

public void mouseP() {
  if (rat>format) {
    nMouseX = mouseX/2;
    nMouseY= mouseY/2;
  } else {
    nMouseX = mouseX;
    nMouseY= mouseY;
  }

  if ( nMouseX != prevMouseX || nMouseY != prevMouseY ) { 
    mousePresse();
  } else { 
    mouseRelease();
  }
  prevMouseX = nMouseX;
  prevMouseY = nMouseY;

  distance = int(dist((width/2), (height/2), nMouseX, nMouseY)); 

  if (dragging) {
    a = nMouseY - (height/2);
    b = nMouseX - (width/2);
    rota = atan2(a, b) * 180 / PI;
    if (rota-oldRot > 160 || rota-oldRot < -160) accr = ((0)+accr);
    else accr = ((rota-oldRot)+accr)/2;
    rotation+=accr;  
    oldRot = rota;
  } else {
    rotation+=accr;        
    if (pow(accr, 2) > .0001) accr *=  damp;
    else accr = 0;
  }
}
void mousePresse() {
  if ((distance/rat2)>130) {
    if (dragging == false) {
      dragging = true;
      a = nMouseY - (height/2);
      b = nMouseX - (width/2);
      oldRot = atan2(a, b) * 180 / PI;
    }
  }
}
void mouseRelease() {
  dragging = false;
}
void changeOnoff(r) { 
  reloadExplication ();
  onoff=r;
}
void change() {
  rotationB=random(360);
  //changeT();
  if (c == 0) {
    c = 255;
  } else {
    c = 0;
  }
}