
boundary[] wall = new boundary[14];
light_source sun;

void setup(){
  size(900, 900);
  wall[0] = new boundary(0, 0, 0, height);
  wall[1] = new boundary(0, height, width, height);
  wall[2] = new boundary(width, height, width, 0);
  wall[3] = new boundary(width, 0, 0, 0);
  for (int i=4; i<wall.length; i++)
    wall[i] = new boundary(random(width), random(height), random(width), random(height));
  sun = new light_source();
}

void draw(){
  background(0);
  
  sun.update();
  
  stroke(255);
  strokeWeight(1);
  for (int i=0; i<wall.length; i++)
    wall[i].show();
  sun.cast();
  sun.show();
}
