
class cell{
    int type;
    boolean visited;
    float x, y, unit;
    
    cell(int type_){
        type = type_;
        visited = false;
    }
    
    boolean pressed(){
        return (x <= mouseX && mouseX < x+unit) && (y <= mouseY && mouseY < y+unit);
    }
    
    void show(float x, float y, float unit){
        this.x = x;
        this.y = y;
        this.unit = unit;
        if (visited)
            fill(120, 218, 120);//light green-20
        else
            noFill();
        strokeWeight(4);
        stroke(0, 128, 0); //green
        square(x, y, unit);
        
        float cx = x+unit/2,
              cy = y+unit/2;
        float len = unit*55./100;
        rectMode(CENTER);
        ellipseMode(CENTER);
        if (visited)
            fill(0, 128, 0); //green
        else
            noFill();
        
        switch (type){
            case empty:      break;
            case circle:     circle(cx, cy, len); break;
            case square:     square(cx, cy, len); break;
            case triangle:   beginShape();
                             vertex(cx-len/2, cy+len/2);
                             vertex(cx+len/2, cy+len/2);
                             vertex(cx, cy+len*(0.5-sqrt3/2));
                             endShape(CLOSE);
                             break;
            case u_triangle: beginShape();
                             vertex(cx-len/2, cy-len/2);
                             vertex(cx+len/2, cy-len/2);
                             vertex(cx, cy-len*(0.5-sqrt3/2));
                             endShape(CLOSE);
                             break;
        }
        rectMode(CORNER);
        ellipseMode(CORNER);
    }
}

final int empty = 0,
          circle = 1,
          triangle = 2,
          u_triangle = 3,
          square = 4;
final float sqrt3 = sqrt(3);
