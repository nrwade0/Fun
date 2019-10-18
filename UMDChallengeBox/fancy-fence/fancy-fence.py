#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 17 00:23:34 2019

@author: nick

link: https://challengebox.cs.umd.edu/2019/Fence/index.html
"""


import pylab as py
import numpy as np


# determines the polar angle (in degrees) between two points, p1 and p2
def det_polar(p1, p2):
    ang1 = np.arctan2(*p1[::-1])
    ang2 = np.arctan2(*p2[::-1])
    return np.rad2deg((ang1 + ang2) % (2 * np.pi))

# determine turn of three points: left turn = +, right turn = -
def turn(x1, y1, x2, y2, x3, y3):
    return (x2 - x1)*(y3 - y1) - (y2 - y1)*(x3 - x1)


# open input file and assign 'n' as first line with coordinates for each line.
x = []
with open("fence-test0.in.txt", 'r') as f:
    n = int(f.readline())
    x, y = np.loadtxt(f, delimiter=' ', dtype=int, unpack=True)
    print("File opened and read.")


"""
py.plot(x, y, '.')
py.grid()
print("Displaying plot...")
"""


# find p0 with lowest x and y coordinates.
p0_index = np.argmin(y)
p0_x = x[p0_index]
p0_y = y[p0_index]


# delete p0 from xy coordinate arrays
x = np.delete(x, p0_index, axis=0)
y = np.delete(y, p0_index, axis=0)


# compute polar angles from p0
polar = det_polar([p0_x,p0_y], [x,y])


# sort coordinates based on polar angles
polar_inds = polar.argsort()
ascending_y = y[polar_inds[::-1]]
ascending_x = x[polar_inds[::-1]]


# considering each of the points in the sorted array in sequence. For each
#  point, it is first determined whether traveling from the two points
#  immediately preceding this point constitutes making a left turn or a right
#  turn.
hull_x = np.zeros(n)
hull_x[0] = p0_x
hull_y = np.zeros(n)
hull_y[0] = p0_y

for i in np.arange(1, len(x)):
    
    # add current point to the convex hull
    hull_x[i] = x[i]
    hull_y[i] = y[i]
    
    # Look at the last 3 points in the convex-hull, and determine if they make
    #  a right turn or a left turn. If a right turn, the second-last point is
    #  not part of the convex hull, and lies 'inside' it. Remove it from the convex-hull.
    t = turn(hull_x[i-1], hull_y[i-1], hull_x[i], hull_y[i], ascending_x[i-1], ascending_y[i-1])
    
    if(t < 0): # left turn
        continue
    elif(t > 0): # right turn, remove second to last point
        hull_x = np.delete(hull_x, i-1, axis=0)
        hull_y = np.delete(hull_y, i-1, axis=0)

print(hull_x, hull_y)

"""
! Graham Scan for Convex Hull
! https://en.wikipedia.org/wiki/Graham_scan

  ! cycle thru the points and snatch ones that follow these rules:
  !  1. There is at least one point on the stack still.
  !  2. and ccw(next_to_top(stack), top(stack), point) < 0
  !  # pop the last point from the stack if we turn clockwise to reach this point
"""