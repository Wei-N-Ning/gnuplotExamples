#!/bin/bash

function runGnuplot() {
    echo '
set terminal pngcairo
set output "/tmp/test.png"
plot x, x**2
' > /tmp/_.gnuplot
    gnuplot -c /tmp/_.gnuplot
}

function assertPNGFile() {
    if [ ! -f "/tmp/test.png" ]; then
        echo "failed (png file not found)"
        exit 1
    fi
}

function run() {
    runGnuplot
    assertPNGFile
}

run
