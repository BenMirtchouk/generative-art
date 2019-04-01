class RandomLoop{
  float r, min, max;
  OpenSimplexNoise rnd;
  
  RandomLoop(float r, float mn, float mx){
    this.r = r;
    min = mn;
    max = mx;
    rnd = new OpenSimplexNoise((long) random(10000));
  }
  
  float eval(float x, float y, float a){
    float u = map(cos(a), -1, 1, 0, r);
    float v = map(sin(a), -1, 1, 0, r);
    float val = (float) rnd.eval(x, y, u, v);
    return map(val, -1, 1, min, max);
  }
  
  float eval(float a){
    float x = map(cos(a), -1, 1, 0, r);
    float y = map(sin(a), -1, 1, 0, r);
    float val = (float) rnd.eval(x, y);
    return map(val, -1, 1, min, max);
  }
}
