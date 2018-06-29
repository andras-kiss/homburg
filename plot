set size ratio 0.8
set pm3d map
set dgrid3d 51, 41 # , 10 , gauss 1,1 
#set pm3d interpolate 3,3
#set contour
set cntrparam levels auto 10
#set key outside
#set term jpeg

#set terminal png size 400,300

set term postscript enhanced color

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
set xtics 0, 10, 50
set ytics 0, 10, 40
set yrange [0:40]
set xrange [0:50]
set lmargin 0

### SCANS
#set colorbox vertical user origin .7, 0 size 0.02, 0.5 
#set colorbox horizontal
set cblabel "i / pA"

set object 1 circle at 45,5 size 5 fc rgb "black" front

set cbrange [1.3:1.7]
set label "A" at 1, 37 tc rgb "black" font ",40" front
set out "11.eps" 
splot "11.txt" u ($1):($2/38*40):($3) notitle
unset label

set cbrange [1.4:1.7]
set label "B" at 1, 37 tc rgb "black" font ",40" front
#set label "deconvoluted" at 1, 31 tc rgb "white" font ",40" front
set out "11_deconvoluted.eps" 
splot "11_deconvoluted.txt" u ($1):($2/38*40):($3) notitle
unset label

set dgrid3d 51, 41 , 10 # , gauss 1,1 
#set cbrange [1.4:1.7]
set label "C" at 1, 37 tc rgb "black" font ",40" front
#set label "deconvolution" at 1, 32 tc rgb "black" font ",40" front
set out "11_wiener_deconvoluted.eps" 
splot "11_wiener_deconvoluted_finalres.txt" u (($1-1)*5/45*50):(($2-1)*4/36*40):($3) notitle
unset label


unset object 1
set object 2 circle at 40,5 size 5 fc rgb "black" front

set size ratio 1.1111111
set dgrid3d 46, 51 # , 10 # , gauss 1,1 
set xtics 0, 15, 45
set ytics 0, 10, 50
set yrange [0:50]
set xrange [0:45]

set cbrange [5.35:5.5]
set label "original" at 1, 47 tc rgb "white" font ",40" front
#set label "deconvoluted" at 1, 31 tc rgb "white" font ",40" front
set out "140514/6_original.eps" 
splot "140514/6_original_xyz.txt" u ($1):($2/49*50):($3) notitle
unset label

set label "deconvoluted" at 1, 47 tc rgb "white" font ",40" front
#set label "deconvolution" at 1, 32 tc rgb "black" font ",40" front
set out "140514/6_deconvoluted.eps" 
splot "140514/6_deconvoluted_xyz.txt" u (($1-1)*5):(($2-1)*5.8):($3) notitle
unset label

set label "deconvoluted" at 1, 47 tc rgb "white" font ",40" front
#set label "deconvolution" at 1, 32 tc rgb "black" font ",40" front
set out "140514/6_deconvoluted.eps" 
splot "140514/6_deconvoluted_xyz2.txt" u (($1-1)*5):(($2-1)*5.8):($3) notitle
unset label

