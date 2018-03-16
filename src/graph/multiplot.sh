#!/bin/bash

source ../_helpers/outputUtils.sh
PNG_OUTPUT=`setPNGOutput $( pwd )"/"$0`

function createData() {
    if ! (python ./multiplot_datagen.py 100 > /tmp/_); then
        echo "failed to create data"
        exit 1
    fi
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
unset key
set multiplot layout 2,2 margins 0.06,0.95,0.085,0.95 spacing 0.075,0.1

# ----
set xtics 2,2
set mxtics 2
set label 1 'Orders per Day' at 8,3
plot [1:14] '/tmp/_' u (strcol(2)[9:10]+0):(1) s f w lp pt 7
set xtics 1
unset mxtics
# ----
set label 1 'Histogram:\nItems per Order' at 3.5,50
plot [0:7] '' u 4:(1) s f w boxes
# ----
set label 1 'Value v.s. Weight' at 4,7
plot '' u 5:6 w p pt 6
# ----
set xtics ('Date' 1, 'Items' 2, 'Weight' 3, 'Value' 4, 'Ship' 5)
unset ytics

set style parallel lw 1
set linetype 1000 lc '0xff000000'
ship(c) = 0+strcol(c)[1:1]
unset label 1
plot [1:5] '' u (strcol(2)[9:10]+0):4:5:6:(ship(7)) w parallel lt 10,\
'' u (strcol(2)[9:10]+0):4:5:6:(ship(7)):(ship(7)==0?1:1000) w parallel lc var
unset multi
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    createData
    runGnuplot
}

run
