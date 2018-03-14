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

# expo smooth function:
# s=a*\$2+(1-a)*s 

# identfy outlier (if v > dRatio * standard deviation)
# abs(\$2-s)>dRatio*STATS_ssd_y?\$2:NaN

# estimate the typical fluctuation range:
# upper bound: s+dRatio*STATS_ssd_y
# lower bound: s-dRatio*STATS_ssd_y
function display() {
    echo "
set key outside top center
s=0
a=0.25
dRatio=2.0
stats '/tmp/_.transformed' u 0:(s=a*\$2+(1-a)*s, $2-s) noout
plot '/tmp/_.transformed' u 0:2 t 'original' w l lw 2,\
'' u 0:(s=a*\$2+(1-a)*s) t 'expo smoothed' w l lt 3 lw 2,\
'' u 0:(s=a*\$2+(1-a)*s, abs(\$2-s)>dRatio*STATS_ssd_y?\$2:NaN) t 'outliers' w p lc 2 pt 7,\
'' u 0:(s=a*\$2+(1-a)*s, s+dRatio*STATS_ssd_y):(s-dRatio*STATS_ssd_y) t 'est. range of fluctuation' \
    w filledc fs transparent solid 0.25 lc rgb 'dark-grey'
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
transformData
display
