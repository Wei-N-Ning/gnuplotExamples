#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateData() {
    python -c "
import random
for i in xrange(50):
    print random.randint(1, 200000) / 200000.0
" > /tmp/_
}

# see Gnuplot in Action 2nd, P96 (125) about internal variable
# STATS_records
function runGnuplot() {
    echo "${PNG_OUTPUT}
set key outside center top title 'Data' box 3
stats '/tmp/_'
plot '' u 1:(-0.1) t 'Raw data' w p pt 7,\
'' u 1:(1.0/STATS_records) t 'Kernel density 0.05' s kdens bandwidth 0.05,\
'' u 1:(1.0/STATS_records) t 'Kernel density 0.1' s kdens bandwidth 0.1
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    runGnuplot
}

run
