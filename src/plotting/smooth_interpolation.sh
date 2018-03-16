#!/bin/bash




function generateData() {
    python -c "
import random
for i in xrange(10):
    print i, ' ', random.randint(1, 20)
" > /tmp/_
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
plot '/tmp/_' using 1:2 title 'Raw data' with points,\
'' using 1:2 title 'mcsplines' with linespoints smooth mcsplines,\
'' using 1:2 title 'csplines' smooth csplines,\
'' using 1:2:(1.0) title 'acsplines 1.0' smooth acsplines
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
