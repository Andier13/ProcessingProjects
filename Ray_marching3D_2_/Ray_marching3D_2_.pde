import java.awt.*;

controlable player;
int total = 10;
box[] boxes;
sphere[] spheres;
float sceneSize = 1000;

void setup(){
  fullScreen();
  noCursor();
  int n = floor(random(1, total));
  n=3;
  boxes = new box[n];
  spheres = new sphere[total-n];
  //boxes[0] = new box(0, -200, 0, random(sceneSize), 10, random(sceneSize));
  for (int i=0; i<boxes.length; i++)
    boxes[i] = new box(random(sceneSize), 0, random(sceneSize), random(50, 100), random(50, 100), random(50, 100));
  for (int i=0; i<spheres.length; i++)
    spheres[i] = new sphere(random(sceneSize), random(-100, 100), random(sceneSize), random(20, 100));
  player = new controlable(sceneSize/2, 0, sceneSize/2, 0, 0);
  Robot robot;
  try{
    robot = new Robot();
    robot.mouseMove(width/2, height/2);
    robot.mousePress(2);
  }
  catch (Throwable e){
    
  }
}

void draw(){
  background(100, 100, 255);
  
  player.update();
  player.rotate();
  player.displayView();
  
  
  //class Color{
  //  color c;
  //  float t;
  //  Color(float r, float g, float b, float t_){
  //    c = color(r, g, b);
  //    t = t_;
  //  }
  //}
  //Color[] colors = new Color[4];
  
  //colors[0] = new Color(255, 0, 0, 0);
  //colors[1] = new Color(0, 255, 0, 0.33);
  //colors[2] = new Color(0, 0, 255, 0.66);
  //colors[3] = new Color(255, 0, 255, 1);
  
  //for (int i=0; i<width; i++){
  //  float hue = map(i, 0, width, 0, 1);
  //  int j;
  //  boolean g = false;
  //  for (j=0; j<colors.length-1 && !g; j++)
  //    if (hue > colors[j].t)
  //      g = true;
    
  //  fill(
  //    lerpColor(colors[j-1].c, colors[j].c, 
  //      (hue-colors[j-1].t) / (colors[j].t-colors[j-1].t)
  //    )
  //  ); 
  //  noStroke();
  //  rect(i, height-50, 1, 50);
  //}
  textAlign(LEFT, TOP);
  textSize(30);
  fill(255);
  text(nf(frameRate, 0, 2)+'\n'
  +nf(map(player.view.ha, -PI, PI, -180, 180), 0, 2)+' '+nf(map(player.view.va, -HALF_PI, HALF_PI, 90, -90), 0, 2)+'\n'
  +nf(player.pos.x, 0, 2)+' '+nf(player.pos.y, 0, 2)+' '+nf(player.pos.z, 0, 2)
  , 0, 0);
}

void keyPressed(){
  player.controls();
}

void keyReleased(){
  player.stop();
}
