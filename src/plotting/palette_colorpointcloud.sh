#!/usr/bin/env bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateData() {
    python -c "
import math
import random
cx = 2.0
cy = 2.0
def coord(angle, radius):
    x = math.sin(math.pi * angle / 180.0) * radius
    y = math.cos(math.pi * angle / 180.0) * radius
    return x + cx, y + cy
def dist(p1, p2):
    return math.sqrt(pow(p1[0] + p2[0] , 2) + pow(p1[1] + p2[1] , 2))
for a in xrange(0, 360):
    radius = random.random() * 2.0
    x, y = coord(a, radius)
    print x, y, dist((x, y), (0, 0))
" > /tmp/_
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
set title 'Set color from palette (record: x, y, dist-to-origin)'
set key off
set palette defined ( 0 'blue', 1 'grey', 2 'red' )
plot [-1:5][-1:5]'/tmp/_' u 1:2:3 t 'particle' palette pt 7
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
