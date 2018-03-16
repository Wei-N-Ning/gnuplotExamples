#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateDataFile() {
    python -c "
import random
def linear():
    for x in xrange(1, 100):
        print x, x * 2.0 * (1 + random.random())
linear()
" > /tmp/_
}

# See In Action Book, P46 (75)
# acsplines: approximation splines
# using the 3rd parameter (inside ()):
# the smaller the value, the weaker the influence each point has to the 
# resulting spline;
# compare 0.1 (noisy curve) and 0.00001 (almost straight curve)
function runGnuplot() {
    echo "${PNG_OUTPUT}
set key outside top center
plot '/tmp/_' u 1:2 t 'data' w p pt 7 ps 1.1,\
'' u 1:2:(0.00001) t 'acsplines' s acs lt 1 lw 2
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateDataFile
    runGnuplot
}

run
