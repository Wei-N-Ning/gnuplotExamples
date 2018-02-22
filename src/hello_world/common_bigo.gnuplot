# plot the common bigo time complexity functions
# beware that gnuplot use log10() for the logarithm to base 10
set title "Visualization of time complexity O(n) of common algorithms"
set key outside bottom center
set terminal pngcairo size 1024,768
set output "/tmp/out.png"
unit=1#0.012
plot [0.1:100][0.1:60] 10 * unit title "Constant", \
log10(x * unit) title "Log(n)", \
x * unit title "Linear" w l, \
unit * x * log10(x) title "nlog(n)", \
unit * x ** 2 title "Quadratic", \
unit * x ** 3 title "Cubic"
