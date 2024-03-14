class blob
{
  float r;
  vector pos, vel, acc;
  
  blob(float xtemp, float ytemp, float rtemp, vector v)
  {
    pos = new vector(xtemp, ytemp);
    vel = new vector(v.x, v.y);
    acc = new vector(0, 0);
    r = rtemp;
  }
  
  void update()
  {
    for (int timestep=0; timestep<1/dt; timestep++);
        {
          acc = multv(200, field_function(pos));
          vel.addv(multv(dt, acc));
          pos.addv(multv(dt, vel));
        }
  }
  
  void display()
  {
    fill(255);
    strokeWeight(3);
    colorMode(HSB);
    //println(floor(field_function(pos).magn()/colorSensitivity)%255);
    println(pos.magn(), vel.magn(), acc.magn());
    stroke(floor(field_function(pos).magn()/colorSensitivity)%255, 255, 255);
    ellipse (pos.x, pos.y, 2*r, 2*r);
  }
}

void grid(float unit)
{
  float x, y;
  vector O = new vector(width/2, height/2);
  colorMode(RGB);
  stroke(10, 25, 64);
  strokeWeight(1);
  for (x=O.x+unit; x<=width; x+=unit)
      line(x, 0, x, height);
  for (x=O.x-unit; x>=0; x-=unit)
      line(x, 0, x, height);
  for (y=O.y+unit; y<=height; y+=unit)
      line(0, y, width, y);
  for (y=O.y-unit; y>=0; y-=unit)
      line(0, y, width, y);
  stroke(255);
  line(O.x, 0, O.x, height);
  line(0, O.y, width, O.y);
      
}

void field_display(float unit)
{
  float x, y;
  for (x=(width/2)%unit ; x<=width ; x+=unit)
      for (y=(height/2)%unit ; y<=height; y+=unit)
          vector_display(x, y, unit);
}

void vector_display(float x, float y, float unit)
{
  vector pos = new vector(x, y), v = multv(upLimit(field_function(pos).magn(), unit/2), versor(field_function(pos)));
  colorMode(HSB);
  color c=color(floor(field_function(pos).magn()/colorSensitivity)%255, 255, 200);
  arrow(pos, v, c, 2);
}
