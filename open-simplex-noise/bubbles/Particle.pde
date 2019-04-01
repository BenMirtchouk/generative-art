class Particle{
  RandomLoop xloop, yloop, sloop;
  
  Particle(){
    xloop = new RandomLoop(0.25, 0 - width/2, width + width/2);
    yloop = new RandomLoop(0.25, 0 - height/2, height + height/2);
    sloop = new RandomLoop(3, 10, 50);
  }
  
  void render(float t){
    float x = xloop.eval(t);
    float y = yloop.eval(t);
    
    float vrnc = 2;
    float s = sloop.eval(vrnc*x/width, vrnc*y/height, 0.5*t);
    float b = bloop.eval(vrnc*x/width, vrnc*y/height, 0.5*t);
    float g = gloop.eval(vrnc*x/width, vrnc*y/height, 0.5*t);
    
    noStroke();
    fill(50,b,g,200);
    circle(x,y,s);
  }
}
