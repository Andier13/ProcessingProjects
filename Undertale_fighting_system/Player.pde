class heart{
  String type;
  PVector pos, vel;
  float speed=2.5;
  int l=16, hl=l/2, b=hl-2;
  int health=20, maxHealth=20;
  boolean invincible = false; int invs=0;
  boolean changing = false; int change=0;
  PGraphics sprite = createGraphics(l, l);
  boolean[] move = {false, false, false, false};
  boolean ableToJump=false, jumping=false;
  
  heart(float xt, float yt, String typet){
      pos = new PVector(xt, yt);
      vel = new PVector(0, 0);
      type = typet;
      sprite.beginDraw();
      sprite.clear();
      switch (type){
      case "red":sprite.image(Red_heart, 0, 0, sprite.width, sprite.height); break;
      case "blue":sprite.image(Blue_heart, 0, 0, sprite.width, sprite.height); break;
      }
      sprite.endDraw();
  }
  
  boolean isMoving() {
    switch (type){
        case "red": return (move[0] || move[1] || move[2] || move[3]);
        case "blue": return (move[0] || vel.mag()!=0 || move[2] || move[3]);
    }return false;
  }
  
  void display(){
    battlefield.imageMode(CENTER);
    if (!invincible)
        battlefield.image(sprite, pos.x, pos.y);
    else if (frame(10)||frame(10, 1)||frame(10, 2)||frame(10, 3)||frame(10, 4))
        battlefield.image(sprite, pos.x, pos.y);
    //int b = hl - 2; battlefield.strokeWeight(1); battlefield.stroke(255); battlefield.noFill(); battlefield.rect(pos.x-b-1, pos.y-b-1, 2*b, 2*b);
    if (changing) {
        float scale = map(millis()-change, 0, 500, 1, 5); 
        battlefield.push();
        battlefield.tint(255, map(scale, 1, 5, 255, 0)); 
        battlefield.image(sprite, pos.x, pos.y, sprite.width*scale, sprite.height*scale);
        battlefield.pop();
    }
  }
  
  void setType(String typet){
      if (type!=typet){
          PingEff.cue(0.3);
          PingEff.play();
          change=millis();
          changing=true;
          type = typet;
          sprite.beginDraw();
          sprite.clear();
          switch (type){
          case "red":sprite.image(Red_heart, 0, 0, sprite.width, sprite.height); break;
          case "blue":sprite.image(Blue_heart, 0, 0, sprite.width, sprite.height); break;
          }
          sprite.endDraw();
      }
  }
  
  void move() {motion(true);}
  void stop() {motion(false);}
  
  void update(){
      PVector cvel = new PVector(0, 0);
      switch (type){
          case "red":
              if (move[0] && !move[1]) cvel.add(PVector.fromAngle(PI+HALF_PI));
              if (move[1] && !move[0]) cvel.add(PVector.fromAngle(HALF_PI));
              if (move[2] && !move[3]) cvel.add(PVector.fromAngle(PI));
              if (move[3] && !move[2]) cvel.add(PVector.fromAngle(0));
              cvel.normalize().mult(speed*dt());
              pos.add(cvel);
              break;
          case "blue":
              if (move[0] && (!ableToJump && jumping)) ;//vel=PVector.fromAngle(PI+HALF_PI).mult(3*dt());
              if (move[2] && !move[3]) cvel.add(PVector.fromAngle(PI));
              if (move[3] && !move[2]) cvel.add(PVector.fromAngle(0));
              vel.add(new PVector(0, 0.06).mult(dt()));
              if (vel.mag()<0.1) jumping=false;
              cvel.normalize().mult(speed*dt()).add(vel);
              pos.add(cvel);
              break;
      }
      //println(ableToJump, jumping, move[0]);
      if (pos.x-hl<0) pos.x=hl;
      if (pos.x+hl>battlefield.width) pos.x=battlefield.width-hl;
      if (pos.y-hl<0) pos.y=hl;
      if (pos.y+hl>battlefield.height) pos.y=battlefield.height-hl;
      if (pos.y+hl>=battlefield.height) {vel = new PVector(0, 0); ableToJump=true;}
      if (millis()-invs>1000) invincible = false;
      if (millis()-change>1000) changing = false;
  }
  
  void motion (boolean val){
      switch (key){
          case 'w': move[0] = val; break;
          case ' ': case 'z':
          if (type=="blue"){
              move[0] = val;
              if (move[0] && ableToJump) {ableToJump=false; jumping=true; vel=PVector.fromAngle(PI+HALF_PI).mult(4*fixedFps/fps);}
              if (!move[0] && jumping) {jumping=false; vel = new PVector(0, 0);}
          }
          break;
          case 's': move[1] = val; break;
          case 'a': move[2] = val; break;
          case 'd': move[3] = val; break;
      }
      
      switch (keyCode){
          case UP:    move[0] = val; break;
          case DOWN:  move[1] = val; break;
          case LEFT:  move[2] = val; break;
          case RIGHT: move[3] = val; break;
      }
  }
}
