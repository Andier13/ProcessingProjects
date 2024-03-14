Circle[] objects;
int i, j, n;
Vector2D g, O;
float miu, dt, K, rho_air, Cd;
boolean applyGravity, applyFriction, applyColisions, showAcceleration, showVelocity, printEnergy, applyAirResistance; 

/*
To do:
- make it 3D
- introduce heat(hue) and densitity(saturation/brightness)
- make it object pair based
- make forces object based
- introduce universal atracion, object friction
- introduce rotation & rotational forces
- add other objects (walls, rectangles, triangles, inclined planes)
- add arrows as show Vector2Ds *done
- show forces on object
*/

void setup()
{
  size(1080, 600);
  background(51);
  O = new Vector2D(0, 0); 
  
  //Settings
  n = 10; //Number of objects
  miu = 0.05;
  dt = 0.001;
  K=  0.1;  //Universal atracion constant
  Cd = 1;  //Drag constant
  rho_air = 0.05;
  g = new Vector2D(0, 9.81*0.1); //Gravitational acceleration
  applyGravity = true;
  applyFriction = true;
  applyColisions = true;
  applyAirResistance = false;
  showVelocity = true;
  showAcceleration = true;
  printEnergy = true;
  //End settings
  
  objects = new Circle[100];
  for (i=0; i<n; i++)
      objects[i]= new Circle(random(5, 50), new Vector2D(random(width), random(height)), randomVector2D(10), O);
}

float Energy(Circle C){
      float E=0;
      E+=1./2*objects[i].m*C.vel.mag()*C.vel.mag(); //Kinetic
      if (applyGravity)  E+=C.m*g.mag()*(height-(C.pos.y+C.r)); //Potential
      return E;
}

void draw ()
{
  background (51);
  float E=0;
  for (i=0; i<n; i++){
      for (int ts=0; ts<1/dt; ts++) {objects[i].update();}
      objects[i].show();
      E+=Energy(objects[i]); //<>//
      }
  if (printEnergy) println(E);
  if (E<1)         noLoop();
}

      //if (applyUniversalAtraction)
      //    for (k=0; k<n; k++)
      //        if (i!=k)
      //            {
      //            Vector2D rUA = sub(objects[k].pos, objects[i].pos), versorUA = versor(rUA);
      //            float magn = K * objects[i].m * objects[k].m / pow(rUA.mag(), 2);
      //            UA.add(dot(magn, versorUA));
      //            }
