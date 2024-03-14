class camera{
  int FOVH, FOVV;
  PVector pos;
  float ha, va;
  
  camera(PVector pos_, float ha_, float va_, int FOVH_, int FOVV_){
    pos = pos_;
    ha = ha_;
    va = va_;
    FOVH = FOVH_;
    FOVV = FOVV_;
  }
  
  void cast(colvec[][] points){
    float distMax = 5000;
    for (int i=0; i<points.length; i++){
      float fovha = map(FOVH, 0, 180, 0, PI);
      float angleh = map(i, 0, points.length-1, ha-fovha/2, ha+fovha/2);
      float cosha = cos(angleh);
      float sinha = sin(angleh);
      
      for (int j=0; j<points[0].length; j++){
        float fovva = map(FOVV, 0, 180, 0, PI);
        float anglev = map(j, 0, points[0].length-1, va-fovva/2, va+fovva/2);
        float cosva = cos(anglev);
        float sinva = sin(anglev);
        
        colvec aux = new colvec(0, pos.copy());
        coldist dmin;
        PVector base = new PVector(cosha*cosva, sinva, sinha*cosva);
        for (dmin = distMin(aux.vec); dmin.dist>1 && dmin.dist<distMax; dmin = distMin(aux.vec))
          aux.vec.add(PVector.mult(base, dmin.dist));
          
        
        if (dmin.dist<distMax){
          points[i][j] = new colvec(dmin.col, aux.vec.copy());
        }
        else
          points[i][j] = null;
      }
    }
  }
}
