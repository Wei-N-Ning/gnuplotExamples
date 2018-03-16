#!/usr/bin/env bash
# this is also based on boxplot but use a smooth kernel to 
# represent the density - see how easy to invoke the built-in
# smooth kernel function in gunplot
# P302 (335) also introduced the math model of Gaussian kernel

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateData() {
    echo "" | awk '
BEGIN {
    for (i=1; i<100; i++) {
        print i, rand() ** 10 + 2
    }
}
' > /tmp/_
}

function doPlot() {
    echo "${PNG_OUTPUT}
set key outside top center
stats '/tmp/_' u 2 noout
plot [][0:5] '/tmp/_' u 2:(1.0/STATS_records) t '0.005' smooth kdensity bandwidth 0.005,\
'/tmp/_' u 2:(1.0/STATS_records) t '0.01' smooth kdensity bandwidth 0.01,\
'/tmp/_' u 2:(1.0/STATS_records) t '0.05' smooth kdensity bandwidth 0.05,\
'/tmp/_' u 2:(1.0/STATS_records) t '0.1' smooth kdensity bandwidth 0.1,\
'/tmp/_' u 2:(1.0/STATS_records) t '0.5' smooth kdensity bandwidth 0.5
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
