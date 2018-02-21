#!/bin/bash

function runGnuplot() {
    echo '
show size
set size 2,2
show size
reset
show size
' > /tmp/_.gnuplot
    gnuplot -c /tmp/_.gnuplot
}

function run() {
    runGnuplot
}

run
