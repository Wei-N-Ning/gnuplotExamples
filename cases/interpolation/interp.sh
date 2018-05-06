#!/usr/bin/env bash

# for "Lerp" see:
# https://en.wikipedia.org/wiki/Linear_interpolation
# // Imprecise method, which does not guarantee v = v1 when t = 1, due to floating-point arithmetic error.
#// This form may be used when the hardware has a native fused multiply-add instruction.
#float lerp(float v0, float v1, float t) {
#  return v0 + t * (v1 - v0);
#}
#
#// Precise method, which guarantees v = v1 when t = 1.
#float lerp(float v0, float v1, float t) {
#  return (1 - t) * v0 + t * v1;
#}

function buildProgram() {
    :
}

function generateData() {
    :
}

function doPlot() {
    echo "
set key outside top center
plot [-0.1:0.9][-0.9:0.9] '-' t 'original' w l
    0.1 0.1
    0.3 0.6
    0.75 -0.75
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

buildProgram
generateData
doPlot
