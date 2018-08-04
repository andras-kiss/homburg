gfortran deconvolution.F90
./a.out
#gnuplot plot
#./autoplot.sh

gnuplot plot

ls *.eps > eps_files
for i in $(cat eps_files)
do
   ps2pdf $i
done


#gnuplot lineplot
#gnuplot plot_transient
#pdflatex deconvolution.tex
