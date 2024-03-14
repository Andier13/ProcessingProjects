
float dt(){
  return 1./frameRate;
}

void conservationOfEnergy(){
    
  float elasticEnergy = 0;
  for (int i=0; i<springs.length; i++)
    elasticEnergy += springs[i].getEnergy();
    
  float potentialEnergy = 0;
  for (int i=0; i<particles.length; i++)
    potentialEnergy += particles[i].getPotentialEnergy(window);
    
  float kineticEnergy = 0;
  for (int i=0; i<particles.length; i++)
    kineticEnergy += particles[i].getKineticEnergy(window);
    
  println(nf(elasticEnergy, 0, 2), nf(potentialEnergy, 0, 2), nf(kineticEnergy, 0, 2), nf(elasticEnergy + potentialEnergy + kineticEnergy, 0, 2));
}
