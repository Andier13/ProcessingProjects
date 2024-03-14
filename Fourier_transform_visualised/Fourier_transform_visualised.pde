
float tlen;
int startTime=1000, maxFourierRange = 6;

wave[] p;

PVector[] fourier;
int k;

void setup(){
  size(1000, 600);
  //fullScreen();
  fourier = new PVector[2000];
  for (int i=0; i<fourier.length; i++)
    fourier[i] = new PVector();
  fourier[0] = new PVector(0, -1);
  k=1;
  p = new wave[2];
  p[0] = new wave(3);
  p[1] = new wave(5);
}

void draw(){
  background(0);
  
  cos_wave(50, 50, width-100, 100);
  polar_coord_graph(50, 250, 300, 300);
  res_graph(450, 250, width-500, 300);
}

void mousePressed(){
  startTime = millis();
  for (int i=0; i<fourier.length; i++)
    fourier[i] = new PVector();
  fourier[0] = new PVector(0, -1);
  k=1;
}
