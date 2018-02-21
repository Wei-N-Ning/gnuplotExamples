#!/bin/bash

function generateDataFile() {
    echo "
# Lines beginning with a hash mark are ignored
1 2 3
2 3 4 
3 4 5
" > /tmp/test
}

function runGnuplot() {
    gnuplot -p -e 'plot "/tmp/test" using 1:3 with lines'
}

function run() {
    generateDataFile
    runGnuplot
}

run
