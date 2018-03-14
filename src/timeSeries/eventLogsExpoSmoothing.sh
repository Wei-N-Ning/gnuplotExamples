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

# exponential smoothing curve over plain line chart
# the larger the parameter a, the closer the expo curve fits to the original
# one - compare a=0.2 and a=0.5
function display() {
    echo "
set key outside top center
s=1
hw(x,a) = a*x + (1-a)*s
plot '/tmp/_.transformed' u 0:2 t 'original' w l lw 2,\
'' u 0:(s=hw(\$2,0.2)) t 'expo smoothing' w l lw 3
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
transformData
display
