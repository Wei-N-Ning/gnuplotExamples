#!/usr/bin/env bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateData() {
    python -c "
import random
for idx, i in enumerate(xrange(500, 550, 1)):
    print idx, i / 100.0 + ((i % 2) - 0.5) * 2.0 * random.random()
" > /tmp/_
}

function display() {
    echo "${PNG_OUTPUT}
set key outside top center
stats '/tmp/_' u 1:2 noout
sum=0
plot '/tmp/_' u 1:2 t 'data' w lp pt 7,\
'' u 1:(sum=sum+(\$2-STATS_median_y)) t 'cum sum' w l 
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
display
