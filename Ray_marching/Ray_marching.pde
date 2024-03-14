import java.awt.*;
controlable player;
int total = 10;
rectangle[] box;
circle[] sphere;

void setup(){
  //size(1200, 900);
  fullScreen();
  noCursor();
  int n = floor(random(1, total));
  box = new rectangle[n];
  sphere = new circle[total-n];
  for (int i=0; i<box.length; i++)
    box[i] = new rectangle(random(width), random(height), random(50, 100), random(50, 100));
  for (int i=0; i<sphere.length; i++)
    sphere[i] = new circle(random(width), random(height), random(50, 100));
  player = new controlable(width/2, height/2, 0);
  Robot robot;
  try{
    robot = new Robot();
    robot.mouseMove(width/2, height/2);
    robot.mousePress(1);
  }
  catch (Throwable e){
    
  }
}

void draw(){
  background(0);
  
  //float dmin=0;
  //PVector mouse = new PVector(mouseX, mouseY);
  //for (int i=0; i<box.length; i++)
  //  if (dmin==0 || signedDistToRect(mouse, box[i])<dmin)
  //    dmin = signedDistToRect(mouse, box[i]);
  //for (int i=0; i<sphere.length; i++)
  //  if (dmin==0 || signedDistToCircle(mouse, sphere[i])<dmin)
  //    dmin = signedDistToCircle(mouse, sphere[i]);
      
  //for (int i=0; i<box.length; i++)
  //  box[i].show();
  //for (int i=0; i<sphere.length; i++)
  //  sphere[i].show();
    
  //fill(255, 100);
  //stroke(255, 150);
  //strokeWeight(3);
  //circle(mouseX, mouseY, 2*dmin);
  player.update();
  player.rotate();
  //player.show();
  //player.view.cast();
  player.displayView();
  
  
  for (int i=0; i<width; i++){
    float hue = map(i, 0, width, 0, 1);
    PVector c1 = new PVector(255, 0, 0),
            c2 = new PVector(0, 255, 0),
            c3 = new PVector(0, 0, 255);
    float t1 = 0,
          t2 = 0.3,
          t3 = 0.8;
    PVector cf = PVector.add(
                 PVector.mult(c1, map(abs(hue - t1), 0, 1, 1, 0)), 
                 PVector.mult(c2, map(abs(hue - t2), 0, 1, 1, 0)), 
                 PVector.mult(c3, map(abs(hue - t3), 0, 1, 1, 0)) );
    cf.x = constrain(cf.x, 0, 255);
    cf.y = constrain(cf.y, 0, 255);
    cf.z = constrain(cf.z, 0, 255);
    fill(cf.x, cf.y, cf.z); noStroke();
    rect(i, height-50, 1, 50);
  }
}

void keyPressed(){
  player.controls();
}

void keyReleased(){
  player.stop();
}
