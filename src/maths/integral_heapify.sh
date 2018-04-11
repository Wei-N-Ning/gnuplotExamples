#!/usr/bin/env bash

# see ADM P127-128; there is also a evernote clip talking about the same equation
# gnuplot has only built-in function for natural base and 10-base therefore 
# the base-changing technique is used

# NOTE: it is very difficult to calculate integral of a function in 
# gnuplot
#~ function doPlotNotUsed() {
    #~ echo "
#~ set key outside top center
#~ set xtics font ',4'
#~ set ytics font ',4'
#~ set xrange [1 : 100]
#~ lg(n) = log(n)/log(2.0)
#~ n = 100
#~ term(h) = n / 2.0 ** (lg(h) + 1.0)
#~ plot term(x) title 'heapify()' w l
#~ " > /tmp/_.gnuplot 
    #~ gnuplot -p -c /tmp/_.gnuplot
#~ }

function generateData() {
    python -c "
import math
def lg(x):
    return math.log(x, 2)
def frange(s, e, step=0.1):
    t = s
    while t <= e:
        yield t
        t += step
def term(n, h):
    return n / pow(2, h+1) * h
def calc(n):
    r = 0
    for h in frange(0, lg(n), step=0.01):
        r += term(n, h)
    return r
for n in frange(1, 10, step=1.0):
    print n, calc(n)
" > /tmp/_
}

function doPlot() {
    echo "
set key outside top center
set xtics font ',4'
set ytics font ',4' 
plot '/tmp/_' u 1:2 t '' w l
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot

