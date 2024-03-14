class Vector2D
{
    float x, y;

    Vector2D(){}
    Vector2D(float xt, float yt) {x=xt; y=yt;}

    void add(Vector2D v)    {this.x+=v.x; this.y+=v.y;}
    void sub(Vector2D v)    {this.x-=v.x; this.y-=v.y;}
    void dot(float scalar)  {this.x*=scalar; this.y*=scalar;}
    float mag()             {return sqrt(this.x*this.x+this.y*this.y);}
    float angle()           {return atan2(y, x);}

};

    Vector2D add(Vector2D u, Vector2D v)      {return new Vector2D(u.x+v.x, u.y+v.y);}
    Vector2D sub(Vector2D u, Vector2D v)      {return new Vector2D(u.x-v.x, u.y-v.y);}
    Vector2D dot(Vector2D v, float scalar)    {return new Vector2D(scalar*v.x, scalar*v.y);}
    Vector2D dot(float scalar, Vector2D v)    {return new Vector2D(scalar*v.x, scalar*v.y);}
    float   dot(Vector2D u, Vector2D v)       {return u.x*v.x+u.y*v.y;}
    Vector2D polarVector2D(float r, float a)  {return new Vector2D(r*cos(a), r*sin(a));}
    Vector2D randomVector2D(float mag)        {float angle=random(0, TWO_PI); return new Vector2D(mag*cos(angle), mag*sin(angle));}
    Vector2D versor(Vector2D v)               {return dot(v, 1/v.mag());}
    
    void eqqTriangle(Vector2D pos, float l, float rot, color c){
        fill(c);
        beginShape();
        vertex(pos.x, pos.y);
        Vector2D v1 = add(pos, polarVector2D(l, PI+PI/6-rot)); vertex(v1.x, v1.y);
        Vector2D v2 = add(pos, polarVector2D(l, PI-PI/6-rot)); vertex(v2.x, v2.y);
        endShape(CLOSE);
    }
    void arrow(Vector2D pos, Vector2D v, color c, int stroke){
        stroke(c); strokeWeight(stroke);
        if (v.mag()>1)
            {float r=log(v.mag()); Vector2D vf = add(pos, v);
            line(pos.x, pos.y, vf.x, vf.y); eqqTriangle(vf, r, -v.angle(), c);}
        else
            point(pos.x, pos.y);
    }
