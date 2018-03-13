#!/usr/bin/env bash

function generateData() {
    rm -f /tmp/_
    cp ./access_log /tmp/_
}

function doPlot() {
    echo "
set xdata time
set timefmt '[%d/%b/%Y:%H:%M:%S'
set xtics format '%d%b\n%H:00' rotate 
set ylabel 'Hits per hour'
plot '/tmp/_' u (strcol(4)[1:15] . ':00:00'):(1) s f w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
