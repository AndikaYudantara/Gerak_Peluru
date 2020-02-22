import math



g = 9.806
m = 0.15
D = 0.0013
step = 0.01
sudut = 35
v0 = 50
x0 = 0
y0 = 0
t0 = 0
i = 0

x1 = []
y1 = []
vx1 = []
vy1 = []
t1 = []

x1.append(x0)
y1.append(y0)
vx1.append(v0*math.cos(math.radians(sudut)))
vy1.append(v0*math.sin(math.radians(sudut)))
t1.append(t0)

while y1[i]>=0 :
    V = math.sqrt(math.pow(vx1[i], 2) + math.pow(vy1[i], 2))
    ax = -(D/m) * V * vx1[i]
    ay = -g-(D/m) * V * vy1[i]
    vx1next  = vx1[i] + (ax * step)
    x1next   = x1[i] + (vx1next * step)
    vy1next  = vy1[i] + (ay * step)
    y1next   = y1[i] + (vy1next * step)
    t1next   = t1[i] + step
    vx1.append(vx1next)
    x1.append(x1next)
    vy1.append(vy1next)
    y1.append(y1next)
    t1.append(t1next)
    i += 1
    print(x1[i], y1[i], vx1[i], vy1[i], t1[i])