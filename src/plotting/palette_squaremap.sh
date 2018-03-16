#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

# Gnuplot in Action, 2nd D24 (449)

function generateData() {
    python -c "
import random
def f(v):
    return pow(v, 8) * 7.3 + 0.1
for day in xrange(1, 31):
    for machine in xrange(1, 21):
        print day, machine if random.random() < 0.8 else 'NAN', f(random.random())
" > /tmp/_
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
# do not draw legend
unset key

# ---- label ----
# label for x, y axis and the color bar (cblab)
set xlab 'Day'
set ylab 'Machine'
set cblab 'Defects'

# ---- define the palette ----
set palette defined (0 'web-green', \
0.5 'goldenrod', 0.999 'red', 1 'black')

# ---- specify the color range explicitly ----
# min: 0/web-green; max: 7/red; out-of-range: >7/black 
# 
# if you relied on gnuplot's autoscaling of cbrange, then almost all
# the data points would be drawn in green;
# fixing the palette using set cbrange [0:7] ensures that the
# interesting data points are distributed across the entire palette
# the palette was designed for this scenario:
# its uppermost edge is black so that points exceeding the interval 
# defined by cbrange stand out
set cbrange [0:7]

# ---- plotting ----
# for shading, use the 3rd column for point color; 
# note that use of palette (pal)
# for the wireframe, use lw and lc
plot [0:32][0:21] '/tmp/_' u 1:2:3 w p pt 5 ps 1.5 pal,\
'' u 1:2 w p pt 4 ps 1.5 lw 0.5 lc black
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
