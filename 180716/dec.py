#!/usr/bin/enc python

'''
Deconvolution of distorted SECM images.
Copyright (C) 2018 András Kiss

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


 Here is a first attempt at porting the deconvolution algorithm
 from FORTRAN to python. The gaussian filter is not yet implemented
 in the program. Right now I do it with the plotting software (gnuplot),
 but it would be better if the python program did it. Also, I haven't
 done the command line argument interpreter yet, so the file name must
 be changed in the code every time. A GUI would be nice, and a live plot
 of the convoluted and deconvoluted image. For that, the XYZ data needs
 to be converted to a matrix.

'''

import numpy as np
import subprocess

conv_img = np.loadtxt("9_41_meandered.txt")
deconv_img = np.copy(conv_img)
e0 = np.float32(conv_img[0][2])
for n in range(0, conv_img.shape[0]):
	deconv_img[n][2] = np.float32((conv_img[n][2]-e0*0.68)/(1-0.68))
	e0 = np.float32(conv_img[n][2])

np.savetxt("9_41_meandered_deconvoluted.txt", deconv_img, delimiter=" ")

#proc = subprocess.Popen(['gnuplot','-p'], 
#                        shell=True,
#                        stdin=subprocess.PIPE,
#                        )
#proc.stdin.write('set xrange [0:10]; set yrange [-2:2]\n')
#proc.stdin.write('plot sin(x)\n')
#proc.stdin.write('quit\n') #close the gnuplot window
