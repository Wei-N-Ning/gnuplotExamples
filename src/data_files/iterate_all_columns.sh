#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateDataFile() {
    python -c "
print 'AK74 M16 G36 FNFAL SIG552'
for i in xrange(1, 1000, 100):
    print i, 0.3 * i, 0.4 * i, 0.5 * i, 0.6 * i
" > /tmp/_
}

function generateGnuplotScript() {
    echo "${PNG_OUTPUT}
set key autotitle columnhead
stats '/tmp/_'
set key outside bottom center
plot for [i=1:STATS_columns] '/tmp/_' u 0:i w lp pt 7 ps 1.0
" > /tmp/_.gnuplot
}

function run() {
    generateDataFile
    generateGnuplotScript
    gnuplot -p -c /tmp/_.gnuplot
}

run
