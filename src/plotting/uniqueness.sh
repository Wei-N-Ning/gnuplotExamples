#!/bin/bash

function generateData() {
    python -c "
import random
for i in xrange(200):
    print random.randint(1, 20), random.randint(1, 200) / 200.0
" > /tmp/_
}

# this also shows how set dynamic point size 
# note the extra column "1:2:2" and "ps variable"
# see: http://gnuplot.sourceforge.net/demo/pointsize.html
# see: https://stackoverflow.com/questions/2689403/gnuplot-dot-plot-with-data-depending-dot-size
function runGnuplot() {
    echo "
set key outside center top
set xlabel 'Unique groups'
set ylabel 'Average per group'
plot [][-2:2] '/tmp/_' using 1:2:2 t 'Raw data' w p pt 6 ps variable,\
'' using 1:2 t 'Average' smooth unique w p lt 1 pt 7 ps 1.5
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run

