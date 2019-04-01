import java.util.Queue;
import java.util.ArrayDeque;

color bkgrnd = color(249, 248, 244);
color c1 = color(233, 184, 156);
color c2 = color(228, 144, 126);
color c3 = color(230, 102, 101);

float t1 = PI/2, t2 = 3*PI/4;
float vt1 = 0, vt2 = 0;

float m = 1, l = 1, g = 9.8;
float p1 = 0, p2 = 0;
float dt = 0.004;

void setup(){
  size(700, 700, P3D); 
  background(bkgrnd);
  frameRate(144);

  t1 = -0.36781815;
  t2 = 76.0969;
  vt1 = 0.8442848;
  vt2 = 10.302032;
  p1 = 3.6510231;
  p2 = 3.6101503;
}

ArrayList<PVector> history3 = new ArrayList<PVector>();

void mouseClicked() {
  noLoop();
}

void draw(){
  noStroke();
  fill(bkgrnd);
  //fill(bkgrnd, 15);
  rect(0,0,width,height);
  
  draw_pen(25);
  update_t();
  draw_hist(c3, history3);
  
  textSize(32);
  fill(50);
  text(frameCount, 5, height-10);

  if (frameCount == 2400) frameRate(100);
  if (frameCount == 2500) frameRate(60);
  if (frameCount == 2890) noLoop();
}

void draw_hist(color c, ArrayList<PVector> history){
  stroke(c);
  strokeWeight(5);
  float tot = 0;
  PVector prev = history.get(history.size()-1);
  
  for (int i=history.size()-1;i>=0;i--){
    PVector pos = history.get(i);
    line(prev.x, prev.y, pos.x, pos.y);
    tot += prev.dist(pos);
    prev = pos;
    
    if (tot > 1508.4196){//2500){
      for (int j=i-1;j>=0;j--) history.remove(j);
      break;
    }
  }  
}
 
void update_t(){
  t1 += vt1 * dt;
  t2 += vt2 * dt;

  vt1 = 6./(m*l*l) * (2*p1 - 3*cos(t1-t2)*p2) / (16 - 9*cos(t1-t2)*cos(t1-t2));
  vt2 = 6./(m*l*l) * (8*p2 - 3*cos(t1-t2)*p1) / (16 - 9*cos(t1-t2)*cos(t1-t2));
  
  p1 += -1./2 * m*l*l * (vt1*vt2*sin(t1-t2) + 3*g/l*sin(t1)) * dt;
  p2 += -1./2 * m*l*l * (-vt1*vt2*sin(t1-t2) + g/l*sin(t2)) * dt;
}

void draw_pen(float sz){
  float opacity = map(frameCount, 0, 2890, 255, 0);
  
  pushMatrix();
  
  translate(width/2, height/2.5);
  
  fill(c1, opacity);
  ellipse(0, 0, sz, sz);
  
  rotate(PI/2 - t1);
  
  stroke(c1, opacity);
  strokeWeight(5);
  line(0,0,width/5,0);
  translate(width/5, 0);
  noStroke();
  
  fill(c2, opacity);
  ellipse(0, 0, sz, sz);
  
  rotate(t1-t2);
  
  stroke(c2, opacity);
  strokeWeight(5);
  line(0,0,width/5,0);
  translate(width/5, 0);
  noStroke();
  
  fill(c3);
  ellipse(0, 0, sz, sz);
  history3.add(new PVector(screenX(0,0), screenY(0,0)));
  
  popMatrix(); 
}
