#!/usr/bin/env bash

# source:
# http://lowrank.net/gnuplot/plot3d2-e.html#6.6

function generateData() {
    python -c "
from __future__ import print_function
import math
ang = 0.0
r = 0.5
z = 0.0
for i in range(1000):
    inc = float(i) / 1000
    x = r * (1 + inc * 12.3) * math.sin(math.radians(ang))
    y = r * (1 + inc * 12.3) * math.cos(math.radians(ang))
    z = inc * 100
    print(x, y, z)
    ang = (ang + 5.0) % 360.0
" > /tmp/_
}

function doPlot() {
    echo "
splot '/tmp/_' u 1:2:3 t '' w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
