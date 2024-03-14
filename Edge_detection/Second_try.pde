void edges(){
  initial.loadPixels();
  for (int x=0; x<initial.width; x++)
    for (int y=0; y<initial.height; y++){
      float a = Gx(x, y);
      float b = Gy(x, y);
      float c = sqrt(a*a + b*b);
      c = map(c, 0, sqrt(2)*4*255, 0, 255);
      colorMode(HSB);
      fifth.pixels[x + y * initial.width] = color(map(atan2(b, a), -PI, PI, 0, 255), 255, int(c)+50);
      //fifth.pixels[x + y * initial.width] = color(int(c));
    }
}

float Gx(int x, int y){
  int[][] kernel = { {-1, 0, 1},
                     {-2, 0, 2},
                     {-1, 0, 1} };
  int sum = 0;
  for (int cx=x-1; cx<=x+1; cx++)
    for (int cy=y-1; cy<=y+1; cy++)
      if (exists(cx, cy))
        sum += brightness( initial.pixels[cx + cy * initial.width] ) * kernel[cx-x+1][cy-y+1];
  return sum;
}

float Gy(int x, int y){
  int[][] kernel = { {-1, -2, -1},
                     { 0,  0,  0},
                     { 1,  2,  1} };
  int sum = 0;
  for (int cx=x-1; cx<=x+1; cx++)
    for (int cy=y-1; cy<=y+1; cy++)
      if (exists(cx, cy)) 
        sum += brightness( initial.pixels[cx + cy * initial.width] ) * kernel[cx-x+1][cy-y+1];
  return sum;
}

boolean exists(int x, int y){
  return (0<=x && x<initial.width && 0<=y && y<initial.height);
}
