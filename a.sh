# gfortran ULL_deconvolution.F90 -o ULL_a.out
# ./ULL_a.out
# gnuplot ULL_plot

#gnuplot lineplot
#ls *.eps > eps_files
#for i in $(cat eps_files)
#do
#   ps2pdf $i
#done
#gnuplot plot_transient

# gnuplot plot_sb
pdflatex -shell-escape procedure.tex
bibtex procedure
pdflatex -shell-escape procedure.tex
#rm *.{aux,bbl,blg,lof,log,lot,out,toc}
