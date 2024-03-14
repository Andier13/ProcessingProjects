float hudoff=50;
slider dimension = new slider(new PVector(50, hudoff), 100, 3, 10, 3, 1, "Dimensions");
slider distance = new slider(new PVector(50, hudoff+50), 100, 1, 1000, 500, 1, "Camera distance");
slider size = new slider(new PVector(50, hudoff+100), 100, 1, 1000, 500, 1, "Length size");
slider angleSpeed = new slider(new PVector(50, hudoff+150), 100, -10, 10, 1, 0.5, "Rotation speed");
checkbox[] rotate = new checkbox[10];
float[] a = new float[10];
checkbox showCoords, perspective;

class intpair {int i, j; intpair(int it, int jt){i=it; j=jt;}}
ArrayList<intpair> con = new ArrayList<intpair>();
int prevD=int(dimension.state);

void setup(){
  fullScreen();
  frameRate(144);
  for (int i=0; i<10; i++)
      {rotate[i] = new checkbox(new PVector(50/*+(i%4)*40*/, hudoff+200+i*40/*(i/4)*40*/), 20, false, "Rotate "+(i+1)); a[i]=0;}
  showCoords = new checkbox(new PVector(width-200, hudoff), 20, false, "Display coordinates");
  perspective = new checkbox(new PVector(width-200, hudoff+40), 20, false, "Perspective/stereo-\ngraphic projection");
}

void mouseClicked(){
  for (int i=0; i<10; i++)
      rotate[i].pressed();
  showCoords.pressed();
  perspective.pressed();
}
void mousePressed(){
  dimension.pressed();
  distance.pressed();
  size.pressed();
  angleSpeed.pressed();
}
void mouseReleased(){
  dimension.unpressed();
  distance.unpressed();
  size.unpressed();
  angleSpeed.unpressed();
}

void draw(){
  background(0);
  interact();
  hypercube();
  if (showCoords.state) XYZ();
}
