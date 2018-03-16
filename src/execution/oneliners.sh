#!/bin/bash




# each call to gnuplot will spawn a new window
# [-10:10][-2:2] sets the (min, max) range on the X and Y axis
function plotFunctions() {
    echo "${PNG_OUTPUT}
plot [-10:10][-2:2] sin(x), x, x-(x**3)/6
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    plotFunctions
}

run
