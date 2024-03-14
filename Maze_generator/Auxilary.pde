enum mazeMode {
  generate, solve, traverse, fin;
}

void Generate(){
    current = stack.get(stack.size()-1); stack.remove(stack.size()-1);
    
    noStroke(); fill(255, 0, 0, 100);
    rect(current.j*w, current.i*w, w, w);
    fill(0, 255, 0, 100);
    for (int i=0; i<stack.size(); i++)
        rect(stack.get(i).j*w, stack.get(i).i*w, w, w);
    textSize(20); fill(255); textAlign(LEFT);
    text(nf(done*100./(grid.length*grid[0].length), 3, 2) + " % Done", width-240, 200);
    
    if (current.hasUnvisitedNeighbours1()){
        stack.add(current);
        next = neighbours.get(floor(random(0, neighbours.size())));
        switch (next.i-current.i){
            case  1: current.walls-=4; next.walls-=1; break;
            case -1: next.walls-=4; current.walls-=1; break;
        }
        switch (next.j-current.j){
            case  1: current.walls-=2; next.walls-=8; break;
            case -1: next.walls-=2; current.walls-=8; break;
        }
        grid[next.i][next.j].visited=true;
        stack.add(next);
        done++;
    }
    if (stack.size()==0)
        {mode=mazeMode.solve; noLoop();}
}

void Solve(){
    if (once){
        for (int i=0; i<grid.length; i++)
            for (int j=0; j<grid[0].length; j++)
                grid[i][j].visited = false;
        root = grid[0][0];
        goal = grid[grid.length-1][grid[0].length-1];
        stack.add(root);
        S.add(root);
        once = false;
    }
    current = stack.get(stack.size()-1); stack.remove(stack.size()-1);
    
    noStroke(); fill(255, 0, 0, 100);
    rect(current.j*w, current.i*w, w, w);
    fill(0, 255, 255, 100);
    for (int i=0; i<stack.size(); i++)
        rect(stack.get(i).j*w, stack.get(i).i*w, w, w);
    fill(0, 255, 0, 100);
    for (int i=0; i<S.size(); i++)
        if (!stack.contains(S.get(i)) && S.get(i)!=current)
            rect(S.get(i).j*w, S.get(i).i*w, w, w);
    textSize(20); fill(255); textAlign(LEFT);
    text(nf(S.size()*100./(grid.length*grid[0].length), 3, 2) + " % Checked", width-240, 200);
    text(nf(stack.size()*100./(grid.length*grid[0].length), 3, 2) + " % Path", width-240, 220);
    
    if (current.hasUnvisitedNeighbours2()){
        stack.add(current);
        next = neighbours.get(0);
        grid[next.i][next.j].visited=true;
        stack.add(next);
        S.add(next);
    }
    if (current==goal) 
        {mode=mazeMode.traverse; once=true; stack.add(current); noLoop();}
}

void Traverse(){
    if (once){
        solver = new blob(w/2, w/2);
        if (stack.get(stack.size()-1)==stack.get(stack.size()-3))
            {stack.remove(stack.size()-1);stack.remove(stack.size()-1);}
        once = false;
    }
    solver.update();
    fill(0, 255, 255, 20); strokeWeight(0); noStroke();
    for (int i=0; i<stack.size(); i++)
        rect(stack.get(i).j*w, stack.get(i).i*w, w, w); //<>//
    solver.display();
}
