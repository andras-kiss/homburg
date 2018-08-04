#!/usr/bin/enc python

# Here is a first attempt at porting the deconvolution algorithm
# from FORTRAN to python. The gaussian filter is not yet implemented
# in the program. Right now I do it with the plotting software (gnuplot),
# but it would be better if the python program did it. Also, I haven't
# done the command line argument interpreter yet, so the file name must
# be changed in the code every time. A GUI would be nice, and a live plot
# of the convoluted and deconvoluted image. For that, the XYZ data needs
# to be converted to a matrix.

import numpy as np
import subprocess

conv_img = np.loadtxt("11.txt")
deconv_img = np.copy(conv_img)
e0 = np.float32(conv_img[0][2])
for n in range(0, conv_img.shape[0]):
	deconv_img[n][2] = np.float32((conv_img[n][2]-e0*0.985)/(1-0.985))
	e0 = np.float32(conv_img[n][2])

np.savetxt("11_deconvoluted.txt", deconv_img, delimiter=" ")

#proc = subprocess.Popen(['gnuplot','-p'], 
#                        shell=True,
#                        stdin=subprocess.PIPE,
#                        )
#proc.stdin.write('set xrange [0:10]; set yrange [-2:2]\n')
#proc.stdin.write('plot sin(x)\n')
#proc.stdin.write('quit\n') #close the gnuplot window
