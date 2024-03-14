class camera{
  int FOV, precision = width;
  PVector pos;
  float a;
  
  camera(PVector pos_, float angle, int FOV_){
    pos = pos_;
    a = angle;
    FOV = FOV_;
  }
  
  void cast(PVector[] points){
    for (int i=0; i<precision; i++){
      float fova = map(FOV, 0, 180, 0, PI);
      float angle = map(i, 0, precision-1, a-fova/2, a+fova/2);
      
      PVector aux = pos.copy();
      while (distMin(aux)>1 && distMin(aux)<width+height)
        aux.add(PVector.fromAngle(angle).mult(distMin(aux)));
      
      if (distMin(aux)<width+height){
        //fill(255, 0, 0); noStroke();
        //circle(aux.x, aux.y, 5);
        //stroke(255, 0, 0); strokeWeight(1);
        //line(pos.x, pos.y, aux.x, aux.y);
        points[i] = aux.copy();
      }
      else
        points[i] = null;
    }
  }
}
