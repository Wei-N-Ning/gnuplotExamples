#!/usr/bin/env bash

function generateData() {
    rm -f /tmp/_
    cp ./access_log /tmp/_
}

function transformData() {
    echo "
set xdata time
set timefmt '[%d/%b/%Y:%H:%M:%S'
set xtics format '%d%b\n%H:00' rotate 
set ylabel 'Hits per hour'
set table '/tmp/_.transformed'
plot '/tmp/_' u (strcol(4)[1:15] . ':00:00'):(1) t 'original' s f w l
unset table
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

# differencing curve over plain line chart
# comma (,) is treated as an operator similar to C's way
# therefore this expression:
# (v=$2-u, u=$2, v) is evaluated from left to right
# the final result is the value of v
function display() {
    echo "
set key outside top center
u=0
plot '/tmp/_.transformed' u 0:2 t 'original' w l lw 2,\
'' u 0:(v=\$2-u, u=\$2, v) t 'differencing' w l lw 3
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
transformData
display
