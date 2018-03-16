#!/usr/bin/env bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateData() {
    /usr/bin/env python ./largeVariationsGen.py 1 365 > /tmp/_
}

function doPlot() {
    echo "${PNG_OUTPUT}
set multiplot layout 1,2
set key outside top center
plot [][0:5000] '/tmp/_' using 1:2 title 'peaks v.s. recesses' w l
set logscale y
plot [][1:5000] '/tmp/_' using 1:2 title '(log) peaks v.s. recesses' w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    doPlot
}

run
