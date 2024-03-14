  void Damage(int dams){
      if(!player.invincible){
          TakeDamageEff.cue(0.5);
          TakeDamageEff.play();
          player.health-=dams;
          player.invs=millis();
          player.invincible=true; //<>// //<>//
          baseScore-=5;
          }
  }
  void Heal(int helths){
      RestoreHealthEff.cue(0.75);
      RestoreHealthEff.play();
      player.health+=helths;
      if (player.health>player.maxHealth) 
          player.health=player.maxHealth;
      baseScore+=10;
  }

class obstacle{
  PVector vel = new PVector(0, 0), pos;
  void update(PVector v) {pos.add(PVector.mult(v, dt()));}
  void update()          {pos.add(PVector.mult(vel, dt()));}
}


class pellet extends obstacle{
  float d, r;
  boolean friend=false;
  
  pellet(PVector position, float dt)                               {pos=position; d=dt; r=d/2;}
  pellet(PVector position, float dt, boolean friendt)              {pos=position; d=dt; r=d/2; friend=friendt;}
  pellet(PVector position, float dt, PVector v, boolean friendt)   {pos=position; d=dt; r=d/2; vel=v; friend=friendt;}
  
  boolean collidePlayer() {
         return (pos.x - r < player.pos.x + player.b &&
         pos.x + r > player.pos.x - player.b &&
         pos.y - r < player.pos.y + player.b &&
         pos.y + r > player.pos.y - player.b);}
  
  void damage(int dams) {if (collidePlayer()) Damage(dams);}
  void heal(int helths) {if (collidePlayer()) Heal(helths);}
  
  void display(){
    if (friend)
        battlefield.stroke(0, 255, 0); 
    else
        battlefield.stroke(255); 
    battlefield.strokeWeight(d); battlefield.point(pos.x, pos.y);
  }
}

class bone extends obstacle{
  float w=10;
  int h;
  boolean cyan = false;
  bone(PVector position, int ht)                                {pos=position; h=ht;}
  bone(PVector position, int ht, PVector v)                     {pos=position; h=ht; vel=v;}
  bone(PVector position, int ht, boolean cyant)                 {pos=position; h=ht; cyan=cyant;}
  bone(PVector position, int ht, PVector v, boolean cyant)      {pos=position; h=ht; vel=v; cyan=cyant;}
  
  boolean collidePlayer() {
         return (pos.x < player.pos.x + player.b &&
         pos.x + w > player.pos.x - player.b &&
         (h<0?
         pos.y < player.pos.y + player.b &&
         pos.y - h*w > player.pos.y - player.b:
         pos.y - h*w < player.pos.y + player.b &&
         pos.y > player.pos.y - player.b));}
         
  void damage(int dams) {if (collidePlayer() && (cyan?player.isMoving():true)) Damage(dams);}
  
  void display(){
      if (cyan)
          battlefield.fill(0, 255, 255);
      else
          battlefield.fill(255);
      battlefield.strokeWeight(0);
      battlefield.rect(pos.x, pos.y, w, -w*h);
  }
}
