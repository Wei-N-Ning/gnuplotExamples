#!/usr/bin/env bash




function generateData() {
    echo "
#Model    Popularity   Performance  Value  Price
Intel/Core/i7-7700K   93471    99   99   22
AMD/Ryzen-5/1600   40691    81   95   70
Intel/Core/i5-7600K   33990    95   106   15
AMD/Ryzen-7/1700   29360    85   87   93
Intel/Core/i7-8700K   26983    111   104   99
AMD/Ryzen-5/1600X   14962    86   100   85
Intel/Core/i5-8600K   9925    105   113   43
AMD/Ryzen-3/1200   5836    69   106   34
" > /tmp/_
}

function doPlot() {
    echo "${PNG_OUTPUT}
set key outside top center
set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 1
set xtic font ',5'
set ytic font ',3'
unset xtic
plot [-1:][0:1.2] '/tmp/_' u (\$2/100000.0) t 'Popularity' lt rgb '#66BB66',\
'' u (\$3/100.0 * \$2/100000.0) t 'Performance' lt rgb '#FF6666',\
'' u (\$4/100.0 * \$2/100000.0) t 'Value' lt rgb '#6666FF',\
'' u 0:(\$2/100000.0):1 t '' with labels font ',3' offset 0,0.3

" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

generateData
doPlot
