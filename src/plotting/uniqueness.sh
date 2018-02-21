#!/bin/bash

function generateData() {
    python -c "
import random
for i in xrange(200):
    print random.randint(1, 20), random.randint(1, 200) / 200.0
" > /tmp/_
}

function runGnuplot() {
    echo "
set key outside center top
set xlabel 'Unique groups'
set ylabel 'Average per group'
plot [][-2:2] '/tmp/_' using 1:2 t 'Raw data' w p pt 7 ps 0.5,\
'' using 1:2 smooth unique w p pt 7 ps 1.5
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run

