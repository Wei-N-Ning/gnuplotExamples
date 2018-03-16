#!/bin/bash

function generateGnuplotScript() {
    echo "
\$data << EOD
1 2
3 4
EOD

set key outside top center
plot \$data using 1:2 w p pt 7 ps 3
" > /tmp/_.gnuplot
}

function run() {
    generateGnuplotScript
    gnuplot -p -c /tmp/_.gnuplot
}

run
