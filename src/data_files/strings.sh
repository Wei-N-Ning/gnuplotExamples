#!/bin/bash




function generateData() {
    echo "
# year title
1993 \"Doom 2\"
2003 \"Doom 3\"
" > /tmp/_
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
set key outside top center
plot '/tmp/_' using 1 t 'Record with strings' w p pt 7 ps 1
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
