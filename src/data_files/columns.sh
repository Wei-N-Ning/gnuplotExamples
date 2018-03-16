#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function generateDataFile() {
    echo "
# Lines beginning with a hash mark are ignored
1 2 3
2 3 4 
3 4 5
" > /tmp/test
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
plot '/tmp/test' using 1:3 with lines
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    generateDataFile
    runGnuplot
}

run
