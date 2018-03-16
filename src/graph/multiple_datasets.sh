#!/usr/bin/env bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function createMultiDatasetFile() {
    echo "
# Hits
100
101
102


70
71
72
" > /tmp/_
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
set key outside top center
plot '/tmp/_' index 0 using 1 t 'dataset index 0' w lp pt 7,\
'' index 1 using 1 t 'dataset index 1' w lp pt 7
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    createMultiDatasetFile
    runGnuplot
}

run
