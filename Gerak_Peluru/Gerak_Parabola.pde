float g = 9.806;
float m = 0.15;
float D = 0.0013;
float step = 0.01;
float sudut = 35;
float v0 = 50;
float x0 = 0;
float y0 = 0;
float t0 = 0;

// DRAW //
int size = 15;

// ARRAY ADA HAMBATAN //
FloatList x1;
FloatList y1;
FloatList vx1;
FloatList vy1;
FloatList t1;
// ARRAY TANPA HAMBATAN //
FloatList x2;
FloatList y2;
FloatList vy2;
FloatList t2;

// ADA HAMBATAN //
float V;
float ax;
float ay;
float x1next;
float y1next;
float vx1next;
float vy1next;
float t1next;
// TANPA HAMBATAN //
float vx2;
float x2next;
float y2next;
float vy2next;
float t2next;

int i;

void setup() {
  size(800, 400);

  // ADA HAMBATAN //
  x1 = new FloatList();
  y1 = new FloatList();
  vx1 = new FloatList();
  vy1 = new FloatList();
  t1 = new FloatList();
  // TANPA HAMBATAN //
  x2 = new FloatList();
  y2 = new FloatList();
  vy2 = new FloatList();
  t2 = new FloatList();

  // ADA HAMBATAN //
  x1.append(x0);
  y1.append(y0);
  vx1.append(v0*cos(radians(sudut)));
  vy1.append(v0*sin(radians(sudut)));
  t1.append(t0);
  // TANPA HAMBATAN //
  x2.append(x0);
  y2.append(y0);
  vx2 = v0*cos(radians(sudut));
  vy2.append(v0*sin(radians(sudut)));
  t2.append(t0);
}


void draw() {
  background(255);

  if (y1.size() == i+1) {
    if (y1.get(i) >= 0) {
      adaHambatan();
    }
  }

  if (y2.size() == i+1) {
    if (y2.get(i) >= 0) {
      tanpaHambatan();
    }
  }


  if (i > 1) {
    //strokeWeight(2);
    for (int j=1; j<x1.size(); j++) {
      stroke(255, 0, 0, 20);
      line(x1.get(j-1), height-y1.get(j-1), x1.get(j), height-y1.get(j));
    }
    for (int h=1; h<x2.size(); h++) {
      stroke(0, 0, 255, 20);
      line(x2.get(h-1), height-y2.get(h-1), x2.get(h), height-y2.get(h));
    }
  }

  noStroke();
  fill(255, 0, 0);
  ellipse(x1next, height-y1next, size, size);
  fill(0, 0, 255);
  ellipse(x2next, height-y2next, size, size);

  textSize(15);
  fill(0);

  text("Ada Hambatan", 10, 20);
  text("x  : "+x1next, 10, 40);
  text("y  : "+y1next, 10, 60);
  text("vx : "+vx1next, 10, 80);
  text("vy : "+vy1next, 10, 100);
  text("t  : "+t1next, 10, 120);

  text("Tanpa Hambatan", 150, 20);
  text("x  : "+x2next, 150, 40);
  text("y  : "+y2next, 150, 60);
  text("vx : "+vx2, 150, 80);
  text("vy : "+vy2next, 150, 100);
  text("t  : "+t2next, 150, 120);

  analitik();

  i++;
  if (y2.get(i) <= 0) {
    noLoop();
  }
}

void adaHambatan() {
  V = sqrt(pow(vx1.get(i), 2)+(pow(vy1.get(i), 2)));
  ax = -(D/m) * V * vx1.get(i);
  ay = -g-(D/m) * V * vy1.get(i);
  vx1next  = vx1.get(i) + (ax * step);
  x1next   = x1.get(i) + (vx1next * step);
  vy1next  = vy1.get(i) + (ay * step);
  y1next   = y1.get(i) + (vy1next * step);
  t1next   = t1.get(i) + step;
  vx1.append(vx1next);
  x1.append(x1next);
  vy1.append(vy1next);
  y1.append(y1next);
  t1.append(t1next);
}

void tanpaHambatan() {
  x2next   = x2.get(i) + (vx2 * step);
  vy2next  = vy2.get(i) + (-g * step);
  y2next   = y2.get(i) + (vy2next * step);
  t2next   = t2.get(i) + step;
  x2.append(x2next);
  vy2.append(vy2next);
  y2.append(y2next);
  t2.append(t2next);
}

void analitik() {
  float t = t2.get(i);
  float x = x0 + (vx2 * t);
  float y = y0 + (vy2.get(0) * t) - (0.5 * g * t * t);

  ellipse(x, height-y, size/2, size/2);
  //println(x+" "+x2.get(i)+" "+y+" "+y2.get(i));
}

void mousePressed() {
  noLoop();
}

void mouseReleased() {
  loop();
}
