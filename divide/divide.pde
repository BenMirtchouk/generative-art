int n = 700;
int DEPTH_LIMIT = 14;

void setup(){
  size(700, 700); 
  frameRate(1);
}

void startdivide(){
  background(0xffffff);
  
  PVector c0 = new PVector(0,0);
  PVector c1 = new PVector(0,n);
  PVector c2 = new PVector(n,n);
  PVector c3 = new PVector(n,0);
  
  line(0, 0, 0, n);
  line(0, n, n, n);
  line(n, n, n, 0);
  line(n, 0, 0, 0);
  line(0, 0, n, n);
  
  subdivide(c0, c1, c2, 0);
  subdivide(c0, c3, c2, 0);
}

float get_rand(float mean, float stdev, float bl, float br){
  return constrain(randomGaussian()*stdev + mean, bl, br);   
}

void subdivide(PVector a, PVector b, PVector c, int depth){
  //if (depth >= DEPTH_LIMIT || random(0,1) < map(depth, 0, DEPTH_LIMIT, 0, 0.1)) return;
  if (depth >= DEPTH_LIMIT) return;
  
  if (depth == 3) depth = round(get_rand((DEPTH_LIMIT-3)*1/3. + 3, DEPTH_LIMIT * 1/3., 3, (float)DEPTH_LIMIT));
  
  
  PVector pts[] = {a,b,c};
  double d[] = {b.dist(c), a.dist(c), a.dist(b)}; 
  
  int mx = 0;
  for(int i=1; i<3; i++) if (d[i] > d[mx]) mx = i;
  
  PVector rnd = pts[(mx+1)%3].copy();
  rnd.sub(pts[(mx+2)%3]);
  rnd.setMag(rnd.mag() * get_rand(0.5, 0.1, 0, 1));
  rnd.add(pts[(mx+2)%3]);
  
  line(pts[mx].x, pts[mx].y, rnd.x, rnd.y);
  
  subdivide(pts[(mx+1)%3], pts[mx], rnd, depth+1);
  subdivide(pts[(mx+2)%3], pts[mx], rnd, depth+1);
}

void draw(){
  clear();
  startdivide();
}
