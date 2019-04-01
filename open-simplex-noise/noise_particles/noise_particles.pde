color bkgrnd = color(249, 248, 244);
int seed = 7461;
boolean record = false;
int frames = 480;

RandomLoop sloop, bloop, gloop;
Particle[] particles;

void setup(){
  size(800, 800); 
  background(bkgrnd);
  frameRate(60);
  
  randomSeed(seed);
  
  sloop = new RandomLoop(.5, 30, 40);
  bloop = new RandomLoop(.5, 50, 255);
  gloop = new RandomLoop(.5, 50, 255);
    
  particles = new Particle[5000];
  for (int i=0;i<particles.length;i++)
    particles[i] = new Particle();
}

float r = 0.01;
float t = 0;

void draw(){
  fill(bkgrnd);
  rect(0,0,width,height);
  drawparticles();
  
  t += 2*PI/frames;
  
  //if (frameCount == 1 ||
  //    1 < frameCount && frameCount <= 1000 && frameCount % 100 == 0 || 
  //    1000 < frameCount && frameCount <= 2000)
  //    particles = (Particle[]) append(particles, new Particle());

  if (record && (frameCount <= frames || false))
    saveFrame("frames/frame_####.jpg");
}

void drawparticles(){
  for (Particle particle : particles)
    particle.render(t);
}
