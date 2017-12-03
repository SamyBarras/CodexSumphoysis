void initImages () {
  // this only to load non dynamic medias... make sure having duplicates in @pjs
  // statics
  bg = loadImage("medias/ui_bg_v3.png"); // this is supposed to be the biggest image.
  x_format = bg.width;
  y_format = bg.height;
  symbols = loadImage("medias/symbols_circle.png");
  titre = loadImage("medias/titre_low.png");
  fond_RndomPtsAndLines = loadImage("medias/fond_linesAndPoints.png");  
  bttn = loadImage("medias/bttn_v3.png");
  bttn_shadow = loadImage("medias/bttn_shadow_v3.png");
  bttn_clic = loadImage("medias/bttn_clic.png");
  // jauges
  mask_jauges = loadImage("medias/jauges/jauges_alpha.jpg");
  jauges = loadImage("medias/jauges/jauges.png");
  // spritesheets
  scrabouillis = loadImage("medias/scrabouillis_sprite.png");
  sonar = loadImage("medias/sonar_filmstrip.png");
  badsonar = loadImage("medias/badsonar_filmstrip.png");
}
public void drawTitre() {
  pushMatrix();
  imageMode(CENTER);

  image(titre, 0, (-y_format/2)+50, titre.width, titre.height); 
  popMatrix();
}

public void drawBttn() {
  //draw button's shadow
  pushMatrix();
  imageMode(CENTER);
  translate(3, 3);
  if (snap) { 
    rotat = int(map(rotation, 0, 360, 0, 24))%24;
    rotate(radians(map(rotat, 0, 24, 0, 360)));
  } else { 
    rotate(radians(rotation));
  }
  image(bttn_shadow, 0, 0, bttn.width, bttn.height); 
  popMatrix();
  // draw real button
  pushMatrix();
  imageMode(CENTER);
  //translate((width/2), (height/2));

  if (snap) { 
    rotat = int(map(rotation, 0, 360, 0, 24))%24;
    rotate(radians(map(rotat, 0, 24, 0, 360)));
  } else { 
    rotate(radians(rotation));
  }
  if (rotat!=rotatB){
    image(bttn, 0, 0, bttn.width, bttn.height);
  }
  else{
    image(bttn, 0, 0, bttn.width, bttn.height);
    image(bttn_clic, 0, 0, bttn_clic.width, bttn_clic.height);
  }
  popMatrix();
}

public void drawCarrousel() { ////// carrousel de points //////
  float radius=(format/3.9);
  int numPoints=6;
  float angle=TWO_PI/(float)numPoints;
  pushMatrix();
  rotatB = int(map(rotationB, 0, 360, 0, 24));
  rotate(radians(map(rotatB, 0, 24, 0, 360)));
  for (int i=0; i<numPoints; i++)
  {
    if (i==(numPoints/2)) {
      if (rotat==rotatB) { fill(color(242,105,97)); }
      else fill(255);
    }
    else { fill (0); }
    ellipse(radius*sin(angle*i), radius*cos(angle*i), 38, 38);
  }
  popMatrix();
}

// extra graphic elements
// jauges
void drawJauges() {
  pushMatrix();
  imageMode(CENTER);
  shapeMode(CENTER);
  float x_pos = -(x_format/2)+125;//-(x_format/4);
  float y_pos = (y_format/2)-150;    
  float jauges_w = jauges.width/2;
  float jauges_h = jauges.height/2;
  // rect
  fill(125);
  //image(jauges, x_pos, y_pos, jauges_w, jauges_h);
  // add some texts
  fill(0);
  textAlign(LEFT);
  float text_size = map(global_mult, 0, 1, 0, 25);
  textSize(text_size);
  text ("◯" + nfs(rotation, 3, 2), x_pos, y_pos-10);
  text ("▲" + nfs(frame, 4) + "@" + nfs(frameRate, 2, 2), x_pos, y_pos+20);
  popMatrix();
}
// scrabouillis anim



int circus_numpoints = 6; // for pointsCircus
int circus_speed = 2; // for pointsCircus // rotation random value for pointsCircus apparition
int circus_timeStart = 25; // time start for pointsCircus
void drawCircus() {
  PGraphics circus = createGraphics(175, 170);
  circus.beginDraw();
  for (int i=0; i < circus_numpoints; i++) {
    float x = random(circus.width-10);
    float y = random(circus.height-10);
    x = constrain(x, 0, circus.width-10);
    y = constrain(y, 0, circus.height-10);
    //circle.ellipse(x,y, 10,10);
    Point pt = new Point(x, y, i);
    points.add(pt);
  }
  circus.endDraw();
}
void drawRndomPtsAndLines() {
  pushMatrix();
  shapeMode(CENTER);
  circus.background(color(0), 0);
  for (int i = 0; i < points.size(); i++) {
    Point pointFromArray = (Point) points.get(i);
    float point_x = pointFromArray.x;
    float point_y = pointFromArray.y;
    if (i > 0) { 
      Point oldpoint = (Point) points.get(i-1);
      float oldpoint_x = oldpoint.x;
      float oldpoint_y = oldpoint.y;
      circus.line(point_x, point_y, oldpoint_x, oldpoint_y);
    } else {
      Point oldpoint = (Point) points.get(points.size()-1);
      float oldpoint_x = oldpoint.x;
      float oldpoint_y = oldpoint.y;
      circus.line(point_x, point_y, oldpoint_x, oldpoint_y);
    }

    if (i == 2) {
      for (int p = 0; p < points.size(); p++) {
        Point oldpoint = (Point) points.get(p);
        float oldpoint_x = oldpoint.x;
        float oldpoint_y = oldpoint.y;
        if (p != i && (p-1) != i-1 && dist(point_x, point_y, oldpoint_x, oldpoint_y) < 150) {
          circus.line(point_x, point_y, oldpoint_x, oldpoint_y);
        }
      }
    }

    pointFromArray.shake();
    pointFromArray.goCreate();
  }

  float zero_xpos = -x_format/2;
  float zero_ypos = -y_format/2;
  float x_pos = zero_xpos+(x_format*.3855);
  float y_pos = zero_ypos+(y_format*.306);
  float size = fond_RndomPtsAndLines.width*.5;
  imageMode(CENTER);
  image(fond_RndomPtsAndLines, x_pos, y_pos, size, size);
  image(circus, x_pos, y_pos, size*.8, size*.8);

  popMatrix();
}