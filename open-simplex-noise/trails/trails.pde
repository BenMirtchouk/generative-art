color bkgrnd = color(249, 248, 244);
//int seed = 7461;
int seed = (int)random(100);
boolean record = false;
int frames = 480;

RandomLoop sloop, bloop, gloop;
Particle[] particles;

void setup(){
  size(700, 700); 
  background(bkgrnd);
  frameRate(60);
  
  randomSeed(seed);
  
  sloop = new RandomLoop(.5, 30, 40);
  bloop = new RandomLoop(.5, 50, 255);
  gloop = new RandomLoop(.5, 50, 255);
    
  particles = new Particle[0];
  for (int i=0;i<particles.length;i++)
    particles[i] = new Particle();
}

float r = 0.01;
float t = 0;

void draw(){
  fill(bkgrnd, 35);
  rect(0,0,width,height);
  drawparticles();
  
  t += 2*PI/frames;
  
  if (frameCount <= 501 && frameCount % 100 == 1 || frameCount > 501 && frameCount % 10 == 0)
    particles = (Particle[]) append(particles, new Particle());
  
  if (record && (frameCount <= frames || true))
    saveFrame("frames/frame_####.jpg");
}

void drawparticles(){
  for (Particle particle : particles){
    PVector pos = particle.coords(t);
    
    //float s = sloop.eval(pos.x, pos.y, t);
    float b = bloop.eval(5*pos.x/width, 5*pos.y/height, t);
    float g = gloop.eval(5*pos.x/width, 5*pos.y/height, t);
    
    noStroke();
    fill(50,b,g,200);
    circle(pos.x,pos.y,5);
  }
}
