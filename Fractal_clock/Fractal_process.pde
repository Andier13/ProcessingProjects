void fractalClock(Vector2D pos, float len, float angle){
  if (len<1) return;
  Vector2D min=new Vector2D(len*cos(ma+PI+HALF_PI+angle), len*sin(ma+PI+HALF_PI+angle));
  Vector2D sec=new Vector2D(len*cos(sa+PI+HALF_PI+angle), len*sin(sa+PI+HALF_PI+angle));
  if (clockVisibility.state && len==r)
      {stroke(255); strokeWeight(5);}
  else
      {stroke((floor((second-len)*col.state))%255, 255, 255-len); strokeWeight(1);}
  line(pos, min); line(pos, sec);
  fractalClock(add(pos, min), len*scale.state, angle+map(minute, 0, 59, 0, TWO_PI));
  fractalClock(add(pos, sec), len*scale.state, angle+map(second, 0, 59, 0, TWO_PI));
}
