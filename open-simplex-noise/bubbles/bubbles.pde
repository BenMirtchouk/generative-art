color bkgrnd = color(249, 248, 244);
//int seed = 7461;
int seed = (int)random(100);
boolean record = false;
int frames = 240;

RandomLoop bloop, gloop;
Particle[] particles;

void setup(){
  size(700, 700); 
  background(bkgrnd);
  frameRate(60);
  randomSeed(seed);
  
  bloop = new RandomLoop(3, 50, 255);
  gloop = new RandomLoop(3, 50, 255);
    
  particles = new Particle[300];
  for (int i=0;i<particles.length;i++)
    particles[i] = new Particle();
}

float t = 0;

void draw(){
  fill(bkgrnd);
  rect(0,0,width,height);
  drawparticles();
  
  t += 2*PI/frames;
  
  if (frameCount % frames == 0) println("loop " + frameCount/frames);
  if (record && (frameCount <= frames || false))
    saveFrame("frames/frame_####.jpg");
}

void drawparticles(){
  for (Particle particle : particles)
    particle.render(t);
}
