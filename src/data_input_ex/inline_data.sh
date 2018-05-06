#!/usr/bin/env bash

# not using a data file; feed data directly to the plot
# command
# source:
# https://stackoverflow.com/questions/3318228/how-to-plot-data-without-a-separate-file-by-specifying-all-points-inside-the-gnu

function doPlot() {
    echo "
set key outside top center
plot '-' t 'inline data demo' w lp pt 7 ps 0.8
    3.1
    4.0
    15.9
    2.6
    5.35
    8.97
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

doPlot
