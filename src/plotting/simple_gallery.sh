#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

# the second call use abbreviations
# note also the use of linecolor modifier
function runGnuplot() {
    echo "${PNG_OUTPUT}
plot [-2.5:2.5][-2.5:2.5] \
0.3 * sin(x) + 2 title 'linespoints' with linespoints,\
0.3 * sin(x) + 1.5 title 'default',\
0.3 * sin(x) + 1 title 'linesp' with linesp linecolor '0xFF8800',\
0.3 * sin(x) + 0.5 title 'points' with points,\
0.25 * x - 0.25 title 'boxes' with boxes
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    runGnuplot
}

run
