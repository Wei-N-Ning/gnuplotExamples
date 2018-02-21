#!/bin/bash

# the second call use abbreviations
function runGnuplot() {
    gnuplot -p -e "
plot [-2.5:2.5][-2.5:2.5] 
0.3 * sin(x) + 2 title 'linespoints' with linespoints,
0.3 * sin(x) + 1.5 title 'default',
0.3 * sin(x) + 1 title 'linesp' with linesp,
0.3 * sin(x) + 0.5 title 'points' with points,
0.25 * x - 0.25 title 'boxes' with boxes
"
    gnuplot -p -e "
plot [-2.5:2.5][-2.5:2.5] 
0.3 * sin(x) + 2 title 'lp' w lp,
0.3 * sin(x) + 1.5 title 'default',
0.3 * sin(x) + 0.5 title 'p' w p,
0.25 * x - 0.25 title 'boxes' w boxes
"
}

function run() {
    runGnuplot
}

run
