#!/usr/bin/env bash
# this example is based on boxplots.sh
# it uses a histogram to summarise the distribution of values
# recall the similar plotting feature on Kibana

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
    echo "
bin(x,s) = s*floor(x/s)
binc(x,s) = s*(floor(x/s) + 0.5)
set boxwidth 0.1
stats '/tmp/_' u 2 noout
set key outside top center
plot '/tmp/_' u (binc(\$2,0.1)):(1.0/(0.1*STATS_records)) smooth frequency with boxes
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateData
    doPlot
}

run
