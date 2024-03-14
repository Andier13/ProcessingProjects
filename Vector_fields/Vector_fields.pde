blob bob;
vector O, v0;
float dt, colorSensitivity=500;
boolean hold=true;

//f(x, y) = (4x^2 + 3) / sqrt(y)
//f(x, y) = sqrt((28 + x)^2 + 4)/fprima

vector field_function(vector pos)
{
  vector u, v;
  float x=pos.x-width/2, y=pos.y-height/2, scale=1, f1, f2;
  f1=y*y;
  f2=3*x-6*y;
  //f1=x+5*y;
  //f2=1/y*x*x;
  //f1 = (4*x*x + 3) / sqrt(abs(y));
  //f2 = sqrt(pow((28 + x), 2) + 4)/f1;
  //v = new vector(f1/scale, f2/scale);
  //u = subv(pos, O);
  //v = polarVector(u.magn(), u.angle()-PI);
  v = new vector(f1, f2);
  v = multv(1, v);
  return v;
}

void setup()
{
  size(1000, 600);
  background(51);
  //translate(width/2, height/2);
  O = new vector(width/2, height/2);
  v0=O;
  dt = 0.001;
  bob = new blob(width/10, height/2-10, 10, v0);
}

void draw()
{
  background(51);
  vector mouse=new vector (mouseX, mouseY);
  grid(20);
  field_display(35);
  if (hold)
    {
    bob.pos=mouse;
    bob.vel=O;
    bob.acc=O;
    }
  else
    bob.update();
  bob.display(); 
}

void mouseClicked()
{
  if (!hold)
    {
      bob.pos=new vector (mouseX, mouseY);
      bob.vel=O;
      bob.acc=O;
    }
  hold=!hold;
}
