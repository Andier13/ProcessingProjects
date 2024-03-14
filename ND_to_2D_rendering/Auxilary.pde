void interact(){
  dimension.update();
  distance.update();
  size.update();
  angleSpeed.update();
  
  textSize(15);
  textAlign(LEFT);
  text(nf(frameRate, ceil(log10(frameRate)), 2) + " FPS", 0, 15);
  dimension.display();
  distance.display();
  size.display();
  angleSpeed.display();
  textAlign(LEFT);
  for (int i=0; i<10; i++)
      if(i<dimension.state) rotate[i].display();
  showCoords.display();
  perspective.display();
}

void hypercube(){
    int D = int(dimension.state);
  float[][] points = new float[D][int(pow(2, D))];
  float[][] p = new float[2][points.length];
  for (int i=0; i<points[0].length; i++)
      for (int ci=i, j=0; j<points.length; ci/=2, j++)
          points[j][i] = map(ci%2, 0, 1, 100, -100);
  
  translate(width/2, height/2);

  float[][] C=points;
  for (int j=D; j>0; j--)
      C=rotate(C, j, a[j-1]);
  for (int j=0; j<D-3; j++)
      C=project(C, distance.state, "perspective");
  C=project(C, distance.state, (perspective.state?"stereographic":"perspective"));
  p=C;
  
  if (prevD!=D || frameCount==1){
      con.clear();
      for (int i=0; i<points[0].length; i++)
          for (int j=0; j<points[0].length; j++)
              if(i!=j) if(dist(points, i, j)==200)
                           con.add(new intpair(i, j));        
  }                       
  strokeWeight(1); stroke(255, 100);
  for (intpair pair : con)
      connect(p, pair.i, pair.j);
  
  for (int i=0; i<10; i++)
      if (rotate[i].state)
        a[i]+=0.01*angleSpeed.state;
  prevD=D;
}

void connect(float[][] p, int i, int j){
  line(p[0][i], p[1][i], p[0][j], p[1][j]);
}

void XYZ(){
   float size=100;
   float[][] coord = {
     {0, size, 0, 0},
     {0, 0, size, 0},
     {0, 0, 0, size}
   };
   float[][] C = coord;
   for (int i=3; i>0; i--)
      C=rotate(C, i, a[i-1]);
   C=project(C, distance.state, (perspective.state?"stereographic":"perspective"));
   strokeWeight(1); colorMode(RGB);
   stroke(255, 0, 0); connect(C, 0, 1);
   stroke(0, 255, 0); connect(C, 0, 2);
   stroke(0, 0, 255); connect(C, 0, 3);
}
