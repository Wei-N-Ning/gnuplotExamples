#!/usr/bin/env bash




function generateData() {
    python -c "
import random
import string
def token(cset):
    return random.choice(cset)
step = 159
for i in xrange(50, 1270, step):
    print ''.join([token(string.uppercase)] + [token(string.lowercase) for _ in xrange(random.randint(5, 10))]), step * (1 + random.random()) + i
" > /tmp/_
}

function doPlot() {
    echo "${PNG_OUTPUT}
set key outside top center
set ytics font ',5'
set xtics font ',5'
plot '/tmp/_' u (\$2):0:ytic(1) t 'rank' w p pt 7
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
