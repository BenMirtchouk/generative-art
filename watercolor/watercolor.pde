int seed = 8359;
int n = 5;
color c1 = color(233, 184, 156);
color c2 = color(228, 144, 126);
color c3 = color(230, 102, 101); // pink red
color c4 = color(134, 82, 89);   // grey
color c5 = color(124, 141, 144); // sky blue
color c6 = color(106, 183, 109); // light green

void setup(){
  size(700, 700, P2D); 
  background(249, 248, 244);
  randomSeed(seed);
  
  //ArrayList<PVector> pts1 = deform(get_circ(width/2, height/2 - 150, 120, 7), 1);
  
  //ArrayList<ArrayList<PVector>> pts = new ArrayList<ArrayList<PVector>>();
  //pts.add(pts1);
  //ArrayList<Integer> clrs = new ArrayList<Integer>();
  //clrs.add(c3);
  //noStroke();
  //draw_blured(pts,clrs);
  
  three_circ();
  //five_rect();
  
  textSize(32);
  fill(50);
  text(seed, 5, height-10);
}

void three_circ(){
  ArrayList<PVector> pts1 = deform(get_circ(width/2, height/2 - 150, 120, 7), 1);
  ArrayList<PVector> pts2 = deform(get_circ(width/2, height/2      , 120, 7), 1);
  ArrayList<PVector> pts3 = deform(get_circ(width/2, height/2 + 150, 120, 7), 1);
  
  ArrayList<ArrayList<PVector>> pts = new ArrayList<ArrayList<PVector>>();
  pts.add(pts1);
  pts.add(pts2);
  pts.add(pts3);
  ArrayList<Integer> clrs = new ArrayList<Integer>();
  clrs.add(c3);
  clrs.add(c5);
  clrs.add(c6);
  noStroke();
  draw_blured(pts,clrs);
}

ArrayList<PVector> get_circ(float x, float y, float r, float n){
  ArrayList<PVector> pts = new ArrayList<PVector>();
  for(float theta = 0; theta < 2*PI; theta += 2*PI/n)
    pts.add(new PVector(x+r*cos(theta), y+r*sin(theta)));
  return pts;
}

int o = 150;

void five_rect(){
  int o = height/10;
  int h = (height+6*o)/5;
  ArrayList<PVector> pts1 = deform(get_rect(0, -o + 0*(h-o),width, h), 4);
  ArrayList<PVector> pts2 = deform(get_rect(0, -o + 1*(h-o),width, h), 4);
  ArrayList<PVector> pts3 = deform(get_rect(0, -o + 2*(h-o),width, h), 4);
  ArrayList<PVector> pts4 = deform(get_rect(0, -o + 3*(h-o),width, h), 4);
  ArrayList<PVector> pts5 = deform(get_rect(0, -o + 4*(h-o),width, h), 4);
  
  ArrayList<ArrayList<PVector>> pts = new ArrayList<ArrayList<PVector>>();
  pts.add(pts1);
  pts.add(pts2);
  pts.add(pts3);
  pts.add(pts4);
  pts.add(pts5);
  ArrayList<Integer> clrs = new ArrayList<Integer>();
  clrs.add(c1);
  clrs.add(c2);
  clrs.add(c3);
  clrs.add(c4);
  clrs.add(c5);
  
  noStroke();
  draw_blured(pts,clrs);
}

int res = 4;
ArrayList<PVector> get_rect(float x, float y, float h, float w){
  ArrayList<PVector> pts = new ArrayList<PVector>();
  
  for(float nx = x; nx <= x+h; nx += h/res)
    pts.add(new PVector(nx, y));
  for(float ny = y; ny <= y+w; ny += w/res)
    pts.add(new PVector(x+h, ny));
  for(float nx = x+h; nx >= x; nx -= h/res)
    pts.add(new PVector(nx, y+w));
  for(float ny = y+w; ny >= y; ny -= w/res)
    pts.add(new PVector(x, ny));
  
  return pts;
}

void draw_blured(ArrayList<ArrayList<PVector>> pts, ArrayList<Integer> clrs){
  for(int i = 0; i < 100; i++)
    for (int st = 0; st < pts.size(); st++){
      PGraphics pg = createGraphics(height, width);
      pg.beginDraw();
      
      fill(clrs.get(st),round(255*0.03));
      PShape ps = get_shape(deform(pts.get(st), 3));
      pg.shape(ps);
      
      pg.blendMode(REPLACE);
      fill(255, 255, 255, 0);
      for(int j = 0; j < 1000; j++)
        pg.shape(createShape(ELLIPSE, 
                             random(0, height),
                             random(0, width),
                             20, 20));
      
      pg.endDraw();  
      image(pg,0,0); 
    }
}

void draw_dashed(ArrayList<ArrayList<PVector>> pts, ArrayList<Integer> clrs){
  for(int i = 0; i < 30; i++)
    for (int st = 0; st < pts.size(); st++){
      PGraphics pg = createGraphics(height, width);
      pg.beginDraw();
      
      fill(clrs.get(st),round(255*0.03*100/30));
      PShape ps = get_shape(deform(pts.get(st), 3));
      pg.shape(ps);
      
      pg.blendMode(REPLACE);
      fill(255, 255, 255, 0);
      for(int j = 0; j < 700; j++)
        pg.shape(createShape(RECT, 
                             random(0, height),
                             random(0, width),
                             2, 20));
    
      pg.endDraw();  
      image(pg,0,0); 
    }
}

PVector get_noise(float r){
  float x = constrain(randomGaussian()*r*3/5, -r, r);
  float y = constrain(randomGaussian()*r*3/5, -r, r);
  return new PVector(x, y);
}

ArrayList<PVector> deform(ArrayList<PVector> org, int depth_limit){
  ArrayList<PVector> pts = new ArrayList<PVector>();
  
  for(int i = 0; i < org.size(); i++){
    ArrayList<PVector> nw = deform(org.get(i), org.get((i+1) % org.size()), depth_limit);
    pts.addAll(nw);
  }
  
  return pts;
}

ArrayList<PVector> deform(PVector a, PVector b, int depth_limit){
  ArrayList<PVector> ret = new ArrayList<PVector>();
  
  if (depth_limit == 0){
    ret.add(a);
    return ret;
  }
  
  PVector rnd = a.copy();
  rnd.sub(b);
  rnd.setMag(rnd.mag()/2);
  rnd.add(get_noise(rnd.mag()));
  rnd.add(b); 
  
  ret.addAll(deform(a, rnd, depth_limit-1));
  ret.addAll(deform(rnd, b, depth_limit-1));
  
  return ret;
}

PShape get_shape(ArrayList<PVector> pts){
  PShape ret = createShape();
  ret.beginShape();
  for(int i = 0; i < pts.size(); i++)
    ret.vertex(pts.get(i).x, pts.get(i).y);
  ret.endShape(CLOSE); 
  return ret;
}

void draw(){
  
}
