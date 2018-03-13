#!/usr/bin/env bash

function generateData() {
    python -c "
import random
import string
def token(cset):
    return random.choice(cset)
pie = 1.0
while pie > 0.0000001:
    v = random.random() * 0.5
    print ''.join([token(string.lowercase) for _ in xrange(10)]), 100* (v if v < pie else pie)
    pie -= v
    
" > /tmp/_
}

function doPlot() {
    echo "
set size square
set angles degrees
unset key
unset tics
unset border
beg(x) = (b=a, a=a+x, 360.0*b)
end(x) = (c=c+x, 360.0*c)
med(x) = (u=v+x/2, v=v+x, 360.0*u)
a=b=c=u=v=0
plot [-1:1][-1:1] '/tmp/_' u (0):(0):(1):(beg(\$2/100.0)):(end(\$2/100.0)) w circ,\
'' u (0.75*cos(med(\$2/100.0))):(0.75*sin(360.0*u)):1 w labels
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
