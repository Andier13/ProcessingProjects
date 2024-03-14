float signedDistToCircle(PVector p, circle c){
  return dist(p.x, p.y, c.pos.x, c.pos.y) - c.r;
}

float signedDistToRect(PVector p, rectangle s){
  PVector aux = PVector.sub(p, s.pos);
  aux.x = abs(aux.x);
  aux.y = abs(aux.y);
  PVector offset = PVector.sub(aux, new PVector(s.w/2, s.h/2));
  PVector aux2 = new PVector(max(offset.x, 0), max(offset.y, 0));
  float unsignedDist = aux2.mag();//max(offset.x, offset.y, 0);//(offset.x<0 && offset.y<0 ? 0 : offset.mag());
  float aux3 = (offset.x<0 && offset.y<0 ?  offset.mag() : 0);
  float distInsideRect = (aux3==0 ? 0 : max(offset.x, offset.y));
  return unsignedDist + distInsideRect;
}

//float signedDistToCircle(PVector p, circle c){
//  return dist(p.x, p.y, c.pos.x, c.pos.y) - c.r;
//}

//float signedDistToRect(PVector p, rectangle s){
//  PVector aux = PVector.sub(p, s.pos);
//  aux.x = abs(aux.x);
//  aux.y = abs(aux.y);
//  PVector offset = PVector.sub(aux, new PVector(s.w/2, s.h/2));
  
//  PVector aux2 = new PVector(max(offset.x, 0), max(offset.y, 0));
//  float unsignedDist = aux2.mag();
  
//  PVector aux3 = new PVector(min(offset.x, 0), min(offset.y, 0));
//  float distInsideRect = min(aux3.x, aux3.y);
  
//  return unsignedDist + distInsideRect;
//}

float distMin(PVector p){
  float dmin=0;
  for (int i=0; i<box.length; i++)
    if (dmin==0 || signedDistToRect(p, box[i])<dmin)
      dmin = signedDistToRect(p, box[i]);
  for (int i=0; i<sphere.length; i++)
    if (dmin==0 || signedDistToCircle(p, sphere[i])<dmin)
      dmin = signedDistToCircle(p, sphere[i]);
  return dmin;
}

int sign(float x){
  if (x==0)
    return 0;
  else if (x>0)
    return 1;
  else
    return -1;
}
