
function generateDataFile() {
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

print 'Workload DumbSort TimSort'
for i in xrange(1, 1000, 100):
    print i, sort_them(i, func=dumb_sort), sort_them(i)
" > /tmp/_
}

function generateGnuplotScript() {
    echo "
set key autotitle columnhead
set key outside bottom center
plot '/tmp/_' u 1:2 w lp pt 7 ps 1,\
'' u 1:3 w lp pt 7 ps 1
" > /tmp/_.gnuplot
}

function run() {
    generateDataFile
    generateGnuplotScript
    gnuplot -p -c /tmp/_.gnuplot
}

run
