class Particle{
  RandomLoop xloop, yloop;
  
  Particle(){
    xloop = new RandomLoop(1, 0, height);
    yloop = new RandomLoop(1, 0, width);
  }
  
  PVector coords(float t){
    float x = xloop.eval(t);
    float y = yloop.eval(t);
    return new PVector(x,y);
  }
}
