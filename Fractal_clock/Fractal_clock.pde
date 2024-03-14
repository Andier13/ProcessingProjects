float r, offset;
float second, minute, sa, ma;
Vector2D origin, mouse;
checkbox clockVisibility = new checkbox(new Vector2D(50, 50), 20, true, "Visible clock");
slider scale = new slider(new Vector2D(50, 100), 100, 0.3, 0.7, 0.67, 0.01, "Line scale");
slider speed = new slider(new Vector2D(50, 150), 100, 0.5, 10, 1, 0.5, "Speed");
slider col = new slider(new Vector2D(50, 200), 100, 0.0, 10, 1, 0.01, "Color multiplier");
PImage clockbg;

void setup(){
  fullScreen(); frameRate(144);
  r=height/6; offset=height/10;origin = new Vector2D(width/2, height/2);
  clockbg = loadImage("Analog clock(2).png");
}

void mouseClicked(){
  clockVisibility.change(mouse);
}
void mousePressed(){
  scale.pressed(mouse);
  speed.pressed(mouse);
  col.pressed(mouse);
}
void mouseReleased(){
  scale.unpressed();
  speed.unpressed();
  col.unpressed();
}
void keyPressed(){
  if (key=='e') displaySettings=!displaySettings;
}

void draw(){
  background(0);
  
  mouse = new Vector2D(mouseX, mouseY);
  scale.update(mouse);
  speed.update(mouse);
  col.update(mouse);
  
  if (clockVisibility.state) 
      image(clockbg, width/2-r-offset, height/2-r-offset, 2*(r+offset), 2*(r+offset));

  second=speed.state*millis()/1000.;   minute=second/60.;
  sa=map(second, 0, 59, 0, TWO_PI);    ma=map(minute, 0, 59, 0, TWO_PI);
  colorMode(HSB); fractalClock(origin, r, 0);
  
  if (displaySettings){
      clockVisibility.display();
      scale.display();
      speed.display();
      col.display();
      textSize(20);
      text("Press E to hide/show settings", 50, 250);
      text(frameRate, width/2, height-50);
  }
}
