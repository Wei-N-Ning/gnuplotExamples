#!/usr/bin/env bash

function buildProgram() {
    echo "
#include <iostream>

#include <functions.cpp>

int main(int argc, char **argv) {
    for(double i = -1.0; i < 2.0; i += 0.05) {
        std::cout << i << \" \" << saturate(i) << std::endl;
    }
    return 0;
}
" > /tmp/_.cpp
    g++ -I . -Wall -o /tmp/_ -std=c++11 -g /tmp/_.cpp
}

function generateData() {
    /tmp/_ > /tmp/_.txt
}

function doPlot() {
    echo "
plot [-1.5:3.5][-1.5:3.5] '/tmp/_.txt' t '' w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

buildProgram
generateData
doPlot
