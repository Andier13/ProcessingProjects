class cell{
  int i, j;
  boolean visited = false;
  int walls = 1 + 2 + 4 + 8; //15 // N E S W
  cell(int it, int jt){i=it; j=jt;}
  
  boolean  hasUnvisitedNeighbours1(){
    neighbours.clear();
    for (int k=0; k<4; k++){
      int ci = current.i + (k==2?1:0) + (k==0?-1:0);
      int cj = current.j + (k==1?1:0) + (k==3?-1:0);
      if (ci>=0 && ci<grid.length && cj>=0 && cj<grid[0].length)
          if (!grid[ci][cj].visited)
              neighbours.add(grid[ci][cj]);
    }
    return neighbours.size()>0;
  }
  
  boolean  hasUnvisitedNeighbours2(){
    neighbours.clear();
    for (int wall=current.walls, k=0; k<4; wall/=2, k++)
        if (wall%2==0){
            int ci = current.i + (k==2?1:0) + (k==0?-1:0);
            int cj = current.j + (k==1?1:0) + (k==3?-1:0);
            if (!grid[ci][cj].visited)
                neighbours.add(grid[ci][cj]);
        }
    return neighbours.size()>0;
  }
}

void displayGrid(){
  stroke(255);
  strokeWeight(1);
  for (int i=0; i<grid.length; i++)
      for (int j=0; j<grid[0].length; j++){
          int wall = grid[i][j].walls;
          for (int k=0; k<4; wall/=2, k++)
              if (wall%2==1)
                  line ((j+(k==1||k==2?1:0))*w, (i+(k==2||k==3?1:0))*w, (j+(k==0||k==1?1:0))*w, (i+(k==1||k==2?1:0))*w);
      }
}
