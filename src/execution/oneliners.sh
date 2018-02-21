#!/bin/bash

# each call to gnuplot will spawn a new window
# [-10:10][-2:2] sets the (min, max) range on the X and Y axis
function plotFunctions() {
    gnuplot -p -e "plot [-10:10][-2:2] sin(x), x, x-(x**3)/6"
}

function run() {
    plotFunctions
}

run
