int  maxValue=2, maxIteration=250;
float zoom=1, IW, IH;
complex center = new complex(0, 0), prevcenter = center;

int[][] IterationCounts;
int[] NumIterationsPerPixel;
int total;

void setup(){
  size (1000, 700);
  background(255);
  //for every pixel/coordinate pair
  //iterate function until maxIteration (converges) or >maxValue (diverges)
  //if it converges ->black
  //else (it diverges) ->color=iteration%255;
  colorMode(RGB);
  IH = 4;
  IW = IH * (float(width)/height);
  IterationCounts = new int[width][height];
  NumIterationsPerPixel = new int[maxIteration+1];
  for (int i=0; i<=maxIteration; i++)
    NumIterationsPerPixel[i]=0;
}



void draw(){
  
  if (mousePressed){
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector O = new PVector(width/2, height/2);
    PVector p = PVector.sub(startPos, mousePos);
    center = pixelsToComplex(int(O.x+p.x), int(O.y+p.y), prevcenter);
  }
  
  loadPixels();
  int i, j, iteration;
  complex c, z, z2;
  println(maxIteration);
  /*
  for (i=0; i<=maxIteration; i++)
    NumIterationsPerPixel[i]=0;
  total=0;
  */
  
  for (i=0; i<width; i++)
      for (j=0; j<height; j++){
            c = pixelsToComplex(i, j, center);
            z = new complex(0, 0);
            
            //for (iteration=0; iteration<maxIteration && modulussq(z)<maxValue*maxValue; iteration++)
                 // z=c_add(c_mult(z, z), c);
                 
            z2 = new complex(0, 0);
            for (iteration=0; iteration<maxIteration && z2.re+z2.im<maxValue*maxValue; iteration++){
                  z.im = 2*z.re*z.im + c.im;
                  z.re = z2.re-z2.im + c.re;
                  z2.re = z.re * z.re;
                  z2.im = z.im *z.im;
            }
                  
            
            if (iteration==maxIteration)
                pixels[i+j*width] = color(0);
            else{
              
              //float hue = map(iteration, 0, maxIteration, 0, 255),
              //      bri = 255,
              //      sat = 255;
              //pixels[i+j*width] = color(hue, bri, sat);
              
              float t =  map(iteration, 0, maxIteration, 0, 5);
              color from = color(0, 0, 150);
              color to = color(255);
              pixels[i+j*width] = lerpColor(from, to, t);
            }
              /*
              IterationCounts[i][j] = iteration;
              NumIterationsPerPixel[iteration]++;
              if (iteration!=maxIteration)
                total++;
                */
            }
  /*      
  for (i=0; i<width; i++)
      for (j=0; j<height; j++){
        float t=0;
        for (int k=0; k<=IterationCounts[i][j]; k++)
          t += float(NumIterationsPerPixel[k])/total;
        if (t>=0.99)
          pixels[i+j*width] = color(0);
        else{
          color from = color(0, 0, 255);
          color to = color(255);
          pixels[i+j*width] = lerpColor(from, to, t);
        }
        
      }
  */
  updatePixels();
}


PVector startPos;

void mousePressed(){
  startPos = new PVector(mouseX, mouseY);
}

void mouseReleased(){
  prevcenter = center;
}

void mouseWheel(MouseEvent event){
  if (event.getCount()==1)
         zoom*=(1/0.9);
     else
         zoom*=0.9;
}

void keyPressed(){
  switch (keyCode){
    case UP:   maxIteration+=50; break;
    case DOWN: maxIteration-=50; break;
  }
}
