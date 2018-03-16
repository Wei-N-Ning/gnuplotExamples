#!/usr/bin/env bash




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
plot [][0:100] '/tmp/_' u 2:(1.0/STATS_records * 100.0) \
t 'probability for a value < x to appear' \
smooth cumulative
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
