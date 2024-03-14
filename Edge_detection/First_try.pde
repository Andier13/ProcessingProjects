void edgesX(){
  int[][] kernel = { {-1, 0, 1},
                     {-2, 0, 2},
                     {-1, 0, 1} };
  initial.loadPixels();
  for (int x=0; x<initial.width; x++)
    for (int y=0; y<initial.height; y++){
      int sum = 0;
      for (int cx=x-1; cx<=x+1; cx++)
        for (int cy=y-1; cy<=y+1; cy++)
          if (exists(cx, cy)) 
            sum += brightness( initial.pixels[cx + cy * initial.width] ) * kernel[cx-x+1][cy-y+1];
       second.pixels[x + y * initial.width] = color( map(sum, -4*255, 4*255, 0, 255) );
    }
  second.updatePixels();
}

void edgesY(){
  int[][] kernel = { {-1, -2, -1},
                     {0, 0, 0},
                     {1, 2, 1} };
  initial.loadPixels();
  for (int x=0; x<initial.width; x++)
    for (int y=0; y<initial.height; y++){
      int sum = 0;
      for (int cx=x-1; cx<=x+1; cx++)
        for (int cy=y-1; cy<=y+1; cy++)
          if (exists(cx, cy)) 
            sum += brightness( initial.pixels[cx + cy * initial.width] ) * kernel[cx-x+1][cy-y+1];
       third.pixels[x + y * initial.width] = color( map(sum, -4*255, 4*255, 0, 255) );
    }
  third.updatePixels();
}

void finalEdges(){
  second.loadPixels();
  third.loadPixels();
  for (int x=0; x<initial.width; x++)
    for (int y=0; y<initial.height; y++){
      float a = brightness(second.pixels[x + y * initial.width]);
      float b = brightness(third.pixels[x + y * initial.width]);
      int pitagora = int(sqrt((a*a + b*b)/2));
      fourth.pixels[x + y * initial.width] = color(pitagora);
    }
  fourth.updatePixels();
}
