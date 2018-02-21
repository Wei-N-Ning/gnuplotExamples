#!/bin/bash

function runPythonExec() {
    python -c "
import bisect
import random
import time
def dumb_sort(workload):
    _ = list()
    for n in workload:
        bisect.insort(_, n)
    return _
def sort_them(size, func=sorted):
    workload = [random.randint(1, 0xFFFFFFF) for i in xrange(size)]
    s = time.time()
    func(workload)
    return time.time() - s
print '#Size Time(Tim) Time(Dumb)'
for size in xrange(100, 10000, 100):
    print '{} {} {}'.format(size, sort_them(size), sort_them(size, func=dumb_sort))
" > /tmp/complexity
}

function runGnuplot() {
    echo '
unset xtics
unset ytics
set size square
set xlabel "Workload"
set ylabel "Run time [sec]"
plot "/tmp/complexity" using 1:2 title "Tim" with lines, "/tmp/complexity" using 1:3 title "Dumb" with lines
' > /tmp/_.gnuplot
    gnuplot -p /tmp/_.gnuplot
}

function run() {
    runPythonExec
    runGnuplot
}

run
