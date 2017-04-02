# -*- coding: utf-8 -*-
import imageio
import skimage
from skimage import io
import numpy

row     = 64
col     = 96
rgb     = 3
r       = 5
b       = 5
g       = 6
trash   = 2

f = open("stop_resisting.hex",'w')
A = imageio.imread("stop_resisting.bmp")
B = A
c = 0

for i in range (0, row):
    for j in range (0, col):
        B[i,j,0] = A[i,j,0]*31/255
        B[i,j,1] = A[i,j,1]*63/255
        B[i,j,2] = A[i,j,2]*31/255

for i in range (0, row):

    
    for j in range (0, col):

        
        char = ""
        char0=bin(B[i,j,0])
        n0=len(char0)
        for k0 in range (0, r-(n0-trash)):
            char = char + '0'
        for l0 in range (trash, n0):
            char = char + char0[l0]
            
        char1=bin(B[i,j,1])
        n1=len(char1)
        for k1 in range (0, g-(n1-trash)):
            char = char + '0'
            if len(char)==8:
                charf = hex(int(char,2))
                if  len(charf) == 3:
                    #f.write(charf[0])
                    #f.write(charf[1])
                    f.write("0")
                    f.write(charf[2])
                else:
                    f.write(charf[2])
                    f.write(charf[3])
                #f.write("\n")
                char = ""
        for l1 in range (trash, n1):
            char = char + char1[l1]
            if len(char)==8:
                charf = hex(int(char,2))
                if  len(charf) == 3:
                    #f.write(charf[0])
                    #f.write(charf[1])
                    f.write("0")
                    f.write(charf[2])
                else:
                    f.write(charf[2])
                    f.write(charf[3])
                #f.write("\n")
                char = ""
        char2=bin(B[i,j,2])
        n2=len(char2)
        for k2 in range (0, b-(n2-trash)):
            char = char + '0'
        for l2 in range (trash, n2):
            char = char + char2[l2]
        charf = hex(int(char,2))
        if  len(charf) == 3:
            #f.write(charf[0])
            #f.write(charf[1])
            f.write("0")
            f.write(charf[2])
        else:
            f.write(charf[2])
            f.write(charf[3])
        #f.write("\n")
f.close()

    
    