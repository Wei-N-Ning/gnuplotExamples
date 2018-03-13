#!/usr/bin/env bash

function generateData() {
    echo "" | awk '
BEGIN {
    for (i=1; i<100; i++) {
        print i, rand() ** 10 + 2
    }
}
' > /tmp/_
}

function doPlot() {
    echo "
set key outside top center
plot '/tmp/_' u 1:2 smooth frequency with boxes
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    doPlot
}

run
