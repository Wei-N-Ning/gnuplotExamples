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
def sort_them(size):
    workload = [random.randint(1, 0xFFFFFFF) for i in xrange(size)]
    s = time.time()
    workload.sort()
    return time.time() - s
print '#Size Time'
for size in (1, 50, 500, 5000, 50000, 100000):
    print '{} {}'.format(size, sort_them(size))
" > /tmp/complexity
}

function runGnuplot() {
    gnuplot -p -e 'plot "/tmp/complexity" using 1:2 with lines'
}

function run() {
    runPythonExec
    runGnuplot
}

run
