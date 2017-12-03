PImage bg, symbols, titre, fond_RndomPtsAndLines, bttn, bttn_clic, scrabouillis, jauges, mask_jauges, sonar, badsonar, explic;
staticElement symbols_img, bg_img;
spriteSheet scrabouillis_anim, sonar_anim, badsonar_anim;
int rat, rat2, w, h, rotat, rotatB;
int frame = 0;
float x_format, y_format, format;
PGraphics circle;
var onoff=true;
var rotationB=0;
float global_mult;
boolean draw_sonar = false;
boolean draw_badSonar = false;
int sframe=0;
String[] explications_imgs;
// customable variables //
boolean show_matrice = false;
int fps = 25; // framerate
float zoom=1.2; // scale in window
boolean snap = true; // bttn rotation snap / false
String explications_dir = "http://maudetsamy.com/symphoisis/medias/explications/";


public void setup()
{
  /*@pjs preload="medias/ui_bg_v3.png,
   medias/symbols_circle.png,
   medias/fond_linesAndPoints.png,
   medias/bttn_v3.png,
   medias/bttn_clic.png,
   medias/titre_low.png,
   medias/bttn_shadow_v3.png,
   medias/jauges/jauges_alpha.jpg,
   medias/jauges/jauges.png,
   medias/scrabouillis_sprite.png,
   medias/sonar_filmstrip.png,
   medias/badsonar_filmstrip.png;"*/
  /* @pjs transparent="true"; */
  //jProcessingJS(this, {fullscreen:true, mouseoverlay:false});
  frameRate(fps);
  textSize(22);
  initImages();
  makeGraphics();
  rescaling();
  ws_connect();
}

public void draw() {
  frame++;
  mouseP();
  // out bastard!
  if (onoff==false) {
    background(255);
    pushMatrix();
    translate(width/2, height/2);
    scale(global_mult);
    imageMode(CENTER);
    image(explic, 0, 0, explic.width/zoom, explic.height/zoom);
    text("z\'etes out, appuyez sur l'écran !", 10, 50);
    popMatrix();
  } else
  {
    background(color(235, 221, 189), 1);
    pushMatrix(); // matrice which scale everything according to window's size
    translate(width/2, height/2);
    scale(global_mult);
    if (show_matrice) {
      fill (color(155, 155, 125));
      rect(-x_format/2, -y_format/2, x_format, y_format);
    }
    // draw background static images
    drawTitre();
    symbols_img.create();
    drawBttn();
    bg_img.create();
    drawCarrousel();
    drawCircus();  
    //
    scrabouillis_anim.drawAnim();
    //
    if (draw_sonar == true) sonar_anim.drawAnim();
    if (draw_badSonar == true) badsonar_anim.drawAnim();
    drawJauges();
    popMatrix();
    
  }
}

void makeGraphics() {
  symbols_img = new staticElement(symbols);
  bg_img = new staticElement(bg);
  scrabouillis_anim = new spriteSheet(scrabouillis, 12, .396, .6755, true);
  scrabouillis_anim.create();
  sonar_anim = new spriteSheet(sonar, 25, .621, .28875, false);
  sonar_anim.create();
  badsonar_anim = new spriteSheet(badsonar, 11, .621, .28875, false);
  badsonar_anim.create();
  // explications random loading
  explications_imgs = loadStrings("medias/explications/imgs_list.txt");
  explications = new PImage[explications_imgs.length];
  for (int exp=0; exp < explications_imgs.length; exp++) {
    PImage newexp = loadImage(explications_dir+explications_imgs[exp]);
    explications[exp] = newexp;
  }
}
public void reloadExplication () {
  explic = explications[int(random(0, explications.length-1))];
}
public void resizeSketch()
{
  rescaling();
}