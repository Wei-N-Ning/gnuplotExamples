#!/bin/bash

function generateDataFile() {
    echo "" > /tmp/_gplot_data
    while read line
    do
        echo $line >> /tmp/_gplot_data
    done < /dev/stdin
}

function generateGnuplotScript() {
    echo "
set key autotitle columnhead
set key outside bottom center
plot '/tmp/_gplot_data' u 1:2 w lp pt 7 ps 1,\
'' u 1:3 w lp pt 7 ps 1
" > /tmp/_gplot.gnuplot
}

function run() {
    generateDataFile
    generateGnuplotScript
    gnuplot -p -c /tmp/_gplot.gnuplot
}

run
