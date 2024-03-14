
boolean done = false;
PImage initial;
PImage second, third, fourth, fifth;

void setup(){
  size(1600, 900);
  selectInput("Select a file:", "processFile");
}

//int t = 0;

void draw(){
  background(0);
  if (done){
      //image(initial, 0, 0, width/2, height/2);
      //image(second, width/2, 0, width/2, height/2);
      //image(third, 0, height/2, width/2, height/2);
      //image(fourth, width/2, height/2, width/2, height/2);
      //int aux = 80;
      //float aux = map(sin(t), -1, 1, 0, 255);
      //tint(255, aux);
      //image(initial, 0, 0, width, height);
      //tint(255, 255-aux);
      image(fifth, 0, 0, width, height);
      //t+=1;
  }
  textAlign(LEFT, TOP);
  textSize(30);
  fill(255);
  text(nf(frameRate, 0, 2), 0, 0);
}


void processFile(File f){
  initial = loadImage(f.getAbsolutePath());
  initial.filter(GRAY);
  initial.filter(BLUR, 1);
  second = new PImage(initial.width, initial.height);
  third = new PImage(initial.width, initial.height);
  fourth = new PImage(initial.width, initial.height);
  fifth = new PImage(initial.width, initial.height);
  //edgesX();
  //edgesY();
  //finalEdges();
  edges();
  done = true;
}

/*
grayscale
x edges
y edges
final edges
*/
