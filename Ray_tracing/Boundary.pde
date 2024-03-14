class boundary{
  PVector p1, p2;
  
  boundary(float x1, float y1, float x2, float y2){
    p1 = new PVector(x1, y1);
    p2 = new PVector(x2, y2);
  }
  
  void show(){
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
