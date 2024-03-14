class planet{
  //properties
  int radius;
  PVector pos;
  float long_a, lat_a, long_vel, lat_vel;
  PImage texture;
  float[][] longitude, latitude;
  
  planet(float x_, float y_, float r, String file, float a1, float a2, float vel1, float vel2){
    pos = new PVector(x_, y_);
    radius = int(r);
    texture = loadImage(file);
    texture.loadPixels();
    long_a = a1;
    lat_a = a2;
    long_vel = vel1;
    lat_vel = vel2;
    
    
    int len = 2*radius+1;
    longitude = new float[len][len];
    latitude = new float[len][len];
    
    for (int i = int(pos.x-radius); i < int(pos.x+radius); i++)
      for (int j = int(pos.y-radius); j < int(pos.y+radius); j++){
        PVector current =  new PVector (i, j);
        PVector aux = fromTo(pos, current);
        if (aux.magSq() <= radius*radius && valid(i, j)){
          float x = aux.x;
          float y = aux.y;
          float z = sqrt(radius*radius - (x*x + y*y));
          
          //https://en.wikipedia.org/wiki/Rotation_matrix
          int ii = i - int(pos.x-radius);
          int jj = j - int(pos.y-radius);
          longitude[ii][jj] = atan2(x, z);
          latitude[ii][jj] = atan2(-y, sqrt(x*x + z*z));
        }
      }
  }
  
  void show(){
    loadPixels();
    for (int i = int(pos.x-radius); i < int(pos.x+radius); i++)
      for (int j = int(pos.y-radius); j < int(pos.y+radius); j++){
        PVector current =  new PVector (i, j);
        PVector aux = fromTo(pos, current);
        if (aux.magSq() <= radius*radius && valid(i, j)){
          int ci = i - int(pos.x-radius);
          int cj = j - int(pos.y-radius);
          float longitude = this.longitude[ci][cj];
          float latitude = this.latitude[ci][cj];

          latitude += lat_a;
          latitude = modulof(latitude, PI);
          if (latitude>HALF_PI){
            //latitude = PI - latitude;
            //longitude -= PI;
            latitude -= PI;
          }
          
          longitude += long_a;
          longitude = modulof(longitude, TWO_PI);
          if (longitude>PI) 
            longitude -= TWO_PI;
          
          int ii = int( map(longitude, -PI, PI, 3, texture.width-4) );
          int jj = int( map(latitude, PI/2, -PI/2, 0, texture.height-1) );
          int index = ii + jj*texture.width;
          if (index < texture.width*texture.height)
            pixels[i + j*width] = texture.pixels[index];
        }
      }
    updatePixels();
    long_a += long_vel * hours/s;
    lat_a += lat_vel * hours/s;
  }
  
  void testPoint(int i, int j){
        PVector current =  new PVector (i, j);
        PVector aux = fromTo(pos, current);
        line(pos.x, pos.y, current.x, current.y);
        if (aux.magSq() < radius*radius && valid(i, j)){
          int ci = i - int(pos.x-radius);
          int cj = j - int(pos.y-radius);
          float longitude = this.longitude[ci][cj];
          float latitude = this.latitude[ci][cj];
          
          latitude += lat_a;
          latitude = modulof(latitude, PI);
          if (latitude>HALF_PI){
            //latitude = PI - latitude;
            //longitude -= PI;
            latitude -= PI;
          }
          
          longitude += long_a;
          longitude = modulof(longitude, TWO_PI);
          if (longitude>PI) 
            longitude -= TWO_PI;  ;
          
          int ii = int( map(longitude, -PI, PI, 3, texture.width-4) );
          int jj = int( map(latitude, PI/2, -PI/2, 0, texture.height-1) );
          int index = ii + jj*texture.width;
          //println(-PI, longitude, PI);
          //println(PI/2, latitude, -PI/2);
          //println(texture.width, texture.height);
          //println(ii, jj);
          
          noFill(); stroke(255, 0, 0); strokeWeight(2);
          circle(map(ii, 0, texture.width, 0, width/5), map(jj, 0, texture.height, 0, height/5), 10);
        }
  }
}
