#!/usr/bin/env bash

# source:
# https://en.wikipedia.org/wiki/Smoothstep
#
# excerpt:
#
# In MSDN and OpenGL libraries, smoothstep implements
# the cubic Hermite interpolation after clamping
#
# Ken Perlin suggests[5] an improved version of the smoothstep function, which has
# zero 1st- and 2nd-order derivatives at x = 0 and x = 1


function buildProgram() {
    echo "
#include <iostream>

#include <functions.cpp>

int main(int argc, char **argv) {
    for(double i = -1.0; i < 1.2; i += 0.01) {
        std::cout << i << \" \" <<
            smoothStep(i, 0.0, 1.0) << \" \" <<
            smoothStepPerlin(i, 0.0, 1.0) << \" \" <<
            smoothStepQuintic(i, 0.0, 1.0) << \" \" <<
            cosine(i, 0.0, 1.0) <<
            std::endl;
    }
    return 0;
}
" > /tmp/_.cpp
    g++ -I . -Wall -o /tmp/_ -std=c++17 -g /tmp/_.cpp
}

function generateData() {
    /tmp/_ > /tmp/_.txt
}

function doPlot() {
    echo "
set key outside top center
plot [-0.1:1.1][-0.1:1.1] '/tmp/_.txt' u 1:2 t 'smooth step' w l,\
'' u 1:3 t 'smooth step perlin' w l,\
'' u 1:4 t 'smooth step quintic' w l,\
'' u 1:5 t 'cosine' w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

buildProgram
generateData
doPlot