board first;

void setup(){
    size(1000, 800);
    first = new board(5, 5);
    //first.table[0][0].visited = true;
}

void draw(){
    background(152, 251, 152);// pale green
    first.show(width/2, height/2, 100);
    first.makePath();
    
    if (first.path.size()>0)
        if (first.pathBeginsWith(circle) && first.pathEndsWith(square))
            fill(0, 128, 0);
        else
            noFill();
    else
        noFill();
    ellipseMode(CENTER);
    circle(width/2, height-100, 50);
    ellipseMode(CORNER);
}

void mousePressed(){
    first.clearPath();
}
