#!/bin/bash

function generateDataFile() {
    python -c "
import random
def linear():
    for x in xrange(1, 100):
        print x, x * 2.0 * (1 + random.random())
linear()
" > /tmp/_
}

function runGnuplot() {
    echo "
set key outside top center
plot '/tmp/_' u 1:2 t 'data' w p pt 7 ps 1.1,\
'' u 1:2:(1e-2) t 'aspline' s acs lt 1 lw 2
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateDataFile
    runGnuplot
}

run
