#!/usr/bin/enc python

# Python 2/3 compatibility
from __future__ import print_function
from scipy.ndimage.filters import gaussian_filter
from skimage import color, data, restoration

import numpy as np
import cv2 as cv

conv_img = np.loadtxt("11.txt")
deconv_img = conv_img
#print (conv_img.shape[0])
e0 = np.float32(conv_img[0][2])
for n in range(0, conv_img.shape[0]):
	#print (x)
	deconv_img[n][2] = np.float32((conv_img[n][2]-e0*0.98)/(1-0.98))
	y = np.float32(conv_img[0][2])
	print (y)

np.savetxt("11__python_deconvoluted.txt", deconv_img, delimiter=" ")

#In: a = np.array([[1,2,3],[4,5,6]])
#In: a.shape
#Out: (2, 3)
#In: a.shape[0] # x axis
#Out: 2
#In: a.shape[1] # y axis
#Out: 3
