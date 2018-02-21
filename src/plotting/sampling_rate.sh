#!/bin/bash

# set maximum number of samples
# sampling rate has no effect when plotting data, unless I use smoothing
# algorithms
function plotFunctionWithCustomSamplingRate() {
    echo '
set samples 100
plot sin(x) w lp
' > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    plotFunctionWithCustomSamplingRate
}

run

