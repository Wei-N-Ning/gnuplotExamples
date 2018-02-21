#!/bin/bash

function generateData() {
    python -c "
import random
for i in xrange(25):
    print random.randint(1, 200) / 200.0
" > /tmp/_
}

function runGnuplot() {
    echo "
set key outside center top title 'Data' box 3
plot '/tmp/_' u 1:(-0.1) t 'Raw data' w p pt 7,\
'' u 1:(1/25.0) t 'Kernel density 0.1' s kdens bandwidth 0.1,\
'' u 1:(1/25.0) t 'Kernel density 0.2' s kdens bandwidth 0.2
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
