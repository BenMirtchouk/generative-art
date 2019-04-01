class Particle{
  RandomLoop xloop, yloop;
  
  Particle(){
    //xloop = new RandomLoop(1, 0, width);
    //yloop = new RandomLoop(1, 0, height);
    
    xloop = new RandomLoop(1, -width/2, 3*width/2);
    yloop = new RandomLoop(1, -height/2, 3*height/2);
  }
  
  void render(float t){
    float x = xloop.eval(t);
    float y = yloop.eval(t);
    
    float b = bloop.eval(5*x/width, 5*y/height, t);
    float g = gloop.eval(5*x/width, 5*y/height, t);

    noStroke();
    fill(50,b,g,200);
    circle(x,y,7);
  }
}
