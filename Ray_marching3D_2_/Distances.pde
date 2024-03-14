coldist signedDistToSphere(PVector p, sphere c){
  float dist = dist(p, c.pos) - c.r;
  color col = c.col;
  coldist aux = new coldist(col, dist);
  return aux;
}

coldist signedDistToBox(PVector p, box b){
  //PVector bv = new PVector(b.w/2, b.h/2, b.d/2);
  //PVector q = PVector.sub(abs(p), bv);
  //return max(q, 0).mag() + min(max(q), 0);
  PVector bv = new PVector(b.w/2, b.h/2, b.d/2);
  PVector q = PVector.sub(abs(p), bv);
  float dist = max(q, 0).mag() + min(max(q), 0);
  color col = b.col;
  coldist aux = new coldist(col, dist);
  return aux;
}


coldist distMin(PVector p){
  coldist dmin = new coldist(0, 0);
  coldist aux;
  for (int i=0; i<boxes.length; i++){
    aux = signedDistToBox(p, boxes[i]);
    if (dmin.dist==0 || aux.dist<dmin.dist)
      dmin = aux;
  }
  for (int i=0; i<spheres.length; i++){
    aux = signedDistToSphere(p, spheres[i]);
    if (dmin.dist==0 || aux.dist<dmin.dist)
      dmin = aux;
  }
  return dmin;
}

float dist(PVector p1, PVector p2){
  return dist(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
}

PVector abs(PVector p){
  return new PVector(abs(p.x), abs(p.y), abs(p.z));
}

PVector max(PVector p, float x){
  return new PVector(max(p.x, x), max(p.y, x), max(p.z, x));
}

float max(PVector p){
  return max(p.x, p.y, p.x);
}
