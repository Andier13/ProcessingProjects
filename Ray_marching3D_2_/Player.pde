class controlable{
  PVector pos;
  float avel=0.005, vel = 200;
  camera view;
  
  controlable(float x, float y, float z, float ha_, float va_){
    pos = new PVector(x, y, z);

    view = new camera(pos, ha_, va_, 70, int(70.*height/width));
    //view = new camera(pos, ha_, va_, 70, 180);
    int aux = 200;
    points = new colvec[aux][int(float(aux*height)/width)];
  }
  
  void update(){
    view.pos = pos;
    PVector forward = new PVector(cos(view.ha + 0), 0, sin(view.ha + 0)),
            left = new PVector(cos(view.ha - HALF_PI), 0, sin(view.ha - HALF_PI)),
            backward = new PVector(cos(view.ha + PI), 0, sin(view.ha + PI)),
            right = new PVector(cos(view.ha + HALF_PI), 0, sin(view.ha + HALF_PI));
    PVector O = new PVector(0, 0, 0);
    PVector dir = new PVector(0, 0, 0);
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
    if (mouseX != width/2 && frameCount>1){
      float mouseVel = mouseX - width/2;
      view.ha += mouseVel * avel;
    }
    if (mouseY != height/2 && frameCount>1){
      float mouseVel = mouseY - height/2;
      view.va += mouseVel * avel;
    }
    view.va = constrain(view.va, -PI/2, PI/2);
    Robot robot;
      try{
        robot = new Robot();
        robot.mouseMove(width/2, height/2);
      }
      catch (Throwable e){
        
      }
  }

  colvec[][] points;
  
  void displayView(){
    view.cast(points);
    //loadPixels();
    for (int i=0; i<points.length; i++)
      for (int j=0; j<points[0].length; j++)
        if (points[i][j] != null){
          
          float d = dist(pos, points[i][j].vec);
  
          float hue = map(d*d, 0, 1500*1500, 0, 1);
          //PVector c1 = new PVector(255, 0, 0),
          //        c2 = new PVector(0, 255, 0),
          //        c3 = new PVector(0, 0, 255);
          //float t1 = 0,
          //      t2 = 0.3,
          //      t3 = 0.8;
          //PVector cf = PVector.add(
          //             PVector.mult(c1, map(abs(hue - t1), 0, 1, 1, 0)), 
          //             PVector.mult(c2, map(abs(hue - t2), 0, 1, 1, 0)), 
          //             PVector.mult(c3, map(abs(hue - t3), 0, 1, 1, 0)) );
          //cf.x = constrain(cf.x, 0, 255);
          //cf.y = constrain(cf.y, 0, 255);
          //cf.z = constrain(cf.z, 0, 255);
          ////pixels[j*width+i] = color(cf.x, cf.y, cf.z);
          //fill(cf.x, cf.y, cf.z); noStroke();
          fill(lerpColor(points[i][j].col, color(100, 100, 255), hue-0.5)); noStroke();
          rect(map(i, 0, points.length, 0, width), map(j, 0, points[0].length, 0, height), float(width)/points.length+1, float(width)/points[0].length+1);
        }
        
    //updatePixels();
  }
}
