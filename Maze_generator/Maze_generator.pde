cell[][] grid;
ArrayList<cell> stack = new ArrayList<cell>(), neighbours = new ArrayList<cell>(), S = new ArrayList<cell>();
cell current, next, root, goal;
int done=1;
blob solver;
boolean once = true;
mazeMode mode = mazeMode.generate;
button nextPhase;
int w = 30;

void setup(){
  size(901, 601);
  //fullScreen();
  frameRate(144);
  nextPhase = new button(new PVector(width-160, 100), 40, "Next");
  grid = new cell[height/w][(width-300)/w];
  for (int i=0; i<grid.length; i++)
      for (int j=0; j<grid[0].length; j++)
          grid[i][j] = new cell(i, j);
  
  current = grid[0][0];
  grid[current.i][current.j].visited=true;
  stack.add(current);
  
  displayGrid();
  fill(255, 0, 0);
  stroke(200, 0, 0);
  strokeWeight(5);
  nextPhase.display();
  noLoop();
}

void mousePressed(){
  if (nextPhase.pressed())
      loop();
}

void draw(){
  background(52);
  switch (mode){
      case generate: Generate(); break;
      case solve:    Solve();    break;
      case traverse: Traverse(); break;
      case fin:      exit();     break; //<>//
  }
  displayGrid();
  fill(255, 0, 0);
  stroke(200, 0, 0);
  strokeWeight(5);
  nextPhase.display();
}
