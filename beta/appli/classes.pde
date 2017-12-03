ArrayList <Point> points = new ArrayList <Point> ();
ArrayList <staticElement> staticElements = new ArrayList <staticElement> ();
staticElement bg_img, symbols_img, myimg;
Point pointFromArray;
//

class Point {
  float x, y;
  float xChange, yChange;
  int i;

  Point (float x_, float y_, int i_) {
    x = x_;
    y = y_;
    i = i_;
    xChange = random(-circus_speed, circus_speed);
    yChange = random(-circus_speed, circus_speed);
  }

  void shake() {
    x += xChange;
    y += yChange;
    if ((x > circus.width-5) || (x < 5)) {
      xChange = xChange * -1;
    }
    if ((y > circus.height-5) || (y < 5)) {
      yChange = yChange * -1;
    }
  }

  void goCreate() {
    circus.ellipse(x, y, 20, 20);
  }
}

class staticElement {
  PImage img;
  int x_size, y_size;

  staticElement (PImage img_) {
    img = img_;
    x_size = img_.width; //img_.width;
    y_size = img_.height; //img_.height;
  }
  void create() {
    pushMatrix();
    imageMode(CENTER);
    image(img, 0, 0, x_size, y_size);
    popMatrix();
  }
}

class spriteSheet {
  int DIM, sW, sH;
  PImage sprite_img;
  PImage[] array;
  float x, y;
  boolean loop;
  
  spriteSheet (PImage sprite_img_, int DIM_, float x_, float y_, boolean loop_) {
    DIM = DIM_;
    sprite_img = sprite_img_;
    sW = sprite_img_.width/DIM_;
    sH = sprite_img_.height;
    x= x_;
    y= y_;
    array = new PImage[DIM];
    loop = loop_;
  }
  
  void create() {
    pushMatrix();
    imageMode(CENTER);
    for (int i=0; i < array.length; i++) {
      int x = i%DIM*sW;
      array[i] = sprite_img.get(x, 0, sW, sH);
    }
    popMatrix();
  }
  
  void drawAnim() {
    pushMatrix();
    imageMode(CENTER);
    float zero_xpos = -x_format/2;
    float zero_ypos = -y_format/2;
    float x_pos = zero_xpos+(x_format*x);
    float y_pos = zero_ypos+(y_format*y);
    float anim_size = array[0].width;
    
    if (loop == true) {
      int numFrame = frame%DIM;
      image(array[numFrame], x_pos, y_pos, anim_size, anim_size);
      fill(220);
      ellipse(x_pos, y_pos, 10, 10);
    }
    else {
      if (sframe < DIM){
        image(array[sframe], x_pos, y_pos, anim_size, anim_size);
        sframe++;
      }
      else {
        draw_sonar = false;
        draw_badSonar = false;
        sframe = 0;
      }
    }
    popMatrix();
  }
}