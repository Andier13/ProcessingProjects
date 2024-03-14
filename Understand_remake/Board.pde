
class board{
    int rows, cols;
    cell[][] table;
    ArrayList<pairInt> path;
    
    board(int rows_, int cols_){
        rows = rows_;
        cols = cols_;
        table = new cell[rows][cols];
        for (int i=0; i<rows; i++)
            for (int j=0; j<cols; j++)
                table[i][j] = new cell(random_int(square));
        path = new ArrayList<pairInt>();
    }
    
    void makePath(){
        if (mousePressed){
            for (int i=0; i<rows; i++)
                for (int j=0; j<cols; j++){
                    pairInt last, current;
                    current = new pairInt(i, j);
                    if (path.size()>0)
                        last = last(path);
                    else
                        last = new pairInt(-100, -100); //won't be adjacent to anything
                    if (table[i][j].pressed() && !table[i][j].visited && (adjacent(last, current) || path.size()==0)){
                        path.add(current);
                        table[i][j].visited = true;
                    }
                }
        }
    }
    
    void clearPath(){
        for (int i=path.size()-1; i>=0; i--){
            pairInt c = path.get(i);
            table[c.i][c.j].visited = false;
            path.remove(i);
        }
    }
    
    void show(float cx, float cy, float unit){
        float x = cx - rows/2. * unit;
        float y = cy - cols/2. * unit;
        for (int i=0; i<rows; i++)
            for (int j=0; j<cols; j++)
                table[i][j].show(x + j*unit, y + i*unit, unit);
        noFill();
        strokeWeight(8);
        strokeCap(PROJECT);
        strokeJoin(MITER);
        beginShape();
        for (int i=0; i<path.size() && path.size()>1; i++){
            pairInt c = path.get(i);
            vertex(x + c.j*unit + unit/2, y + c.i*unit + unit/2);
        }
        endShape();
        if (path.size()>0){
            pairInt c = path.get(0);
            float len = unit*80./100;
            rectMode(CENTER);
            square(x + c.j*unit + unit/2, y + c.i*unit + unit/2, len);
            rectMode(CORNER);
        }
    }
    
    //Path tests
    
    boolean pathBeginsWith(int type){
        pairInt c = path.get(0);
        return (table[c.i][c.j].type == type);
    }
    
    boolean pathEndsWith(int type){
        pairInt c = last(path);
        return (table[c.i][c.j].type == type);
    }
}
