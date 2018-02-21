# plot the common bigo time complexity functions
# beware that gnuplot use log10() for the logarithm to base 10
unit=0.012
plot [0.1:100][0.1:60] 10 * unit title "Constant", \
log10(x * unit) title "Log(n)", \
x * unit title "Linear" w l, \
unit * x * log10(x) title "nlog(n)", \
unit * x ** 2 title "Quadratic", \
unit * x ** 3 title "Cubic"
