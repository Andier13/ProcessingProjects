class blob{
  PVector pos;
  int speed = 3, k=1, d;
  
  blob(int xt, int yt){
    pos=new PVector(xt, yt); d=int(0.6*w);
  }
  
  void update(){
    try{
    PVector target = new PVector(stack.get(k).j*w+w/2, stack.get(k).i*w+w/2);
    pos.add(PVector.sub(target, pos).normalize().mult(speed));
    if (PVector.sub(target, pos).mag()<speed)
        k+=1;
    }catch (IndexOutOfBoundsException e){
        mode=mazeMode.fin;
        noLoop();
    }
  }
  
  void display(){
    fill(255, 0, 0);
    strokeWeight(1);
    stroke(200, 0, 0);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, d, d);
  }
}
