class controlable{
  PVector pos;
  float a, avel=0.005, vel = 200;
  camera view;
  
  controlable(float x, float y, float angle){
    pos = new PVector(x, y);
    a = angle;
    view = new camera(pos, a, 70);
    points = new PVector[view.precision];
  }
  
  void update(){
    view.pos = pos;
    view.a = a;
    PVector forward = PVector.fromAngle(a + 0),
            left = PVector.fromAngle(a - HALF_PI),
            backward = PVector.fromAngle(a + PI),
            right = PVector.fromAngle(a + HALF_PI);
    PVector O = new PVector(0, 0);
    PVector dir = new PVector(0, 0);
    if (move[0] != move[2]){
      dir.add((move[0]?forward:O));
      dir.add((move[2]?backward:O));
    }
    if (move[1] != move[3]){
      dir.add((move[1]?left:O));
      dir.add((move[3]?right:O));
    }
    dir.normalize().mult(vel/frameRate);
    pos.add(dir);
  }
  
  boolean[] move = {false, false, false, false};
  
  void controls(){
    switch (key){
      case 'w': move[0] = true; break;
      case 'a': move[1] = true; break;
      case 's': move[2] = true; break;
      case 'd': move[3] = true; break;
    }
    if (keyCode == SHIFT)
      vel = 400;
  }
  
  void stop(){
    switch (key){
      case 'w': move[0] = false; break;
      case 'a': move[1] = false; break;
      case 's': move[2] = false; break;
      case 'd': move[3] = false; break;
    }
    if (keyCode == SHIFT)
      vel = 200;
  }
  
  void rotate(){
    if (mouseX != width/2){
      float mouseVel = mouseX - width/2;
      a += mouseVel * avel;
      Robot robot;
      try{
        robot = new Robot();
        robot.mouseMove(width/2, height/2);
      }
      catch (Throwable e){
        
      }
    }
  }
  
  void show(){
    fill(255); noStroke();
    circle(pos.x, pos.y, 5);
    //PVector dir = PVector.fromAngle(a);
    stroke(255);
    //line(pos.x, pos.y, pos.x + dir.x * 20, pos.y + dir.y * 20);
    float fova = map(view.FOV, 0, 180, 0, PI);
    PVector aux1 = PVector.fromAngle(a-fova/2).mult(100);
    PVector aux2 = PVector.fromAngle(a+fova/2).mult(100);
    line(pos.x, pos.y, pos.x + aux1.x, pos.y + aux1.y);
    line(pos.x, pos.y, pos.x + aux2.x, pos.y + aux2.y);
  }
  
  PVector[] points;
  
  void displayView(){
    view.cast(points);
    for (int i=0; i<view.precision; i++)
      if (points[i] != null){
        
        float d = dist(pos.x, pos.y, points[i].x, points[i].y);
        PVector aux = PVector.sub(points[i], pos);
        float dperp = PVector.dot(PVector.fromAngle(a), aux);
        
        
        float h = map(d, 0, 2000, 1.5*height, 100);//sqrt(width*width+height*height)
        h = height*300/d;
        
        float w = width/view.precision;
        float hue = map(d*d, 0, 1500*1500, 0, 1);
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
        rect(i*w, height/2-h/2, w, h);
      }
  }
}
