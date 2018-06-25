set size ratio 0.8
set pm3d map
set dgrid3d 51, 40 , 10 #, gauss 1,1 
#set pm3d interpolate 3,3
#set contour
set cntrparam levels auto 10
#set key outside
#set term jpeg

set terminal png size 400,300

#set term postscript enhanced color

#set terminal pdf

set xlabel "X / {/Symbol m}m"
set ylabel "Y / {/Symbol m}m"
#set palette gray
#set palette rgbformulae -30, -31, -32 # quickgrid
set palette rgbformulae 22, 13, -31 # quickgrid
#set palette rgbformulae 33, 13, 10 # rainbow
set xtics font "Helvetica, 25"
set ytics font "Helvetica, 25"
set xlabel font ",25"
set ylabel font ",25"
set cblabel font ",25"
set cbtics font ",25"
set cblabel offset 4,0
set ylabel offset -3,0
set xlabel offset 0,-1
set xtics 0, 25, 50
set ytics 0, 19, 38
set yrange [0:38]
set xrange [0:50]

### SCANS
#set colorbox vertical user origin .7, 0 size 0.02, 0.5 
#set colorbox horizontal
set cblabel "i / pA"

set cbrange [1.2:1.7]
#set label "140128-1-E1-11-3D.asc" at 1, 35 tc rgb "white" font ",40" front
set out "11.png" 
splot "11.txt" u ($1):($2):($3) notitle
unset label

set cbrange [1.2:1.7]
set label "140128-1-E1-11-3D.asc" at 1, 35 tc rgb "white" font ",40" front
set label "deconvoluted" at 1, 31 tc rgb "white" font ",40" front
set out "11_deconvoluted.png" 
splot "11_deconvoluted.txt" u ($1):($2):($3) notitle
unset label

