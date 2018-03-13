#!/usr/bin/env bash

function generateData() {
    echo "
1989 0.1
1990 0.2
1991 0.2
1992 0.05
1993 0.15
1994 0.3
1995 0.1
" >  /tmp/_
}

function doPlot() {
    echo "
reset
set key at graph 0.24, 0.85 horizontal samplen 0.1
set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 1
set xtics offset 0,-1.5 rotate by 90 font '0,8'
unset ytics
set y2tics offset 0,-0.5 rotate by 90 font ',8'
set yrange [0:0.35]; set xrange [-0.5:6.5]
set y2label 'Output' offset -2.5
set xlabel ' '
set size 0.6, 1
set label 1 'Year' at graph 0.5, -0.125 centre rotate by 180
set label 2 'Nowhere' at graph 0.045, 0.85 left rotate by 90 font ',8'
set label 3 'Everywhere' at graph 0.185, 0.85 left rotate by 90 font ',8'
set terminal pngcairo
set output '/tmp/test.png'
p '/tmp/_' u 2 title '', \
'' u (\$2/2.0+rand(0)/10.0) title '', \
'' u 0:(0):xticlabel(1) w l title ''
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot

convert -rotate 90 /tmp/test.png /tmp/final.png
eog /tmp/final.png
