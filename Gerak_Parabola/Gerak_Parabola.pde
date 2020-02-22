float g, m, D, step, sudut ,v0, x0, y0, t0;

// ARRAY ADA HAMBATAN //
FloatList x1, y1, vx1, vy1, t1;
// ARRAY TANPA HAMBATAN //
FloatList x2, y2, vy2, t2;

// ADA HAMBATAN //
float V, ax, ay, x1next, y1next, vx1next, vy1next, t1next;
// TANPA HAMBATAN //
float x2next, y2next, vx2, vy2next, t2next;

int i;
int ball;

void setup() {
  size(800, 400);
  g = 9.806;
  m = 0.15;
  D = 0.0013;
  step = 0.01;
  sudut = 35;
  v0 = 50;
  x0 = 0;
  y0 = 0;
  t0 = 0;
  
  ball = 10;

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
  ellipse(x1next, height-y1next, ball, ball);
  fill(0, 0, 255);
  ellipse(x2next, height-y2next, ball, ball);

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

  //ellipse(x, height-y, ball/2, ball/2);
  //println(x+" "+x2.get(i)+" "+y+" "+y2.get(i));
}

//void mousePressed() {
//  noLoop();
//}

//void mouseReleased() {
//  loop();
//}
