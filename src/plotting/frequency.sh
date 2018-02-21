#!/bin/bash

function generateData() {
    python -c "
import random
for i in xrange(200):
    print random.randint(1, 20)
" > /tmp/_
}

function runGnuplot() {
    echo "
set key outside center top
set xlabel 'Values'
set ylabel 'Frequency (number of hits)'
plot '/tmp/_' using 1:(1.0) title 'Frequency' w p pt 7 ps 1.5 smooth frequency
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
