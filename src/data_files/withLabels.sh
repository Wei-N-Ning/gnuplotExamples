#!/usr/bin/env bash

function generateData() {
    du ../ | awk '
BEGIN { 
    FS = "../" 
    n = 1
}
/[a-z]+$/ { print n++, strtonum($1), gensub(/_/, "-", "g", $2)}
' > /tmp/_
}

function doPlot() {
    echo "
set key outside top center
plot '/tmp/_' u 1:2 with boxes,\
'' u 1:2:3 with labels font ',3' offset 0,0.25
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    doPlot
}

run
