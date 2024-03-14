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
    
    void line(Vector2D pos, Vector2D v) {line(pos.x, pos.y, pos.x+v.x, pos.y+v.y);}
