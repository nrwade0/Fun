# -*- coding: utf-8 -*-
"""
Classical Mechanics Hoopla
"""

import numpy as np
import pylab as py

# Lissajous figure
# oscillations in 2D
# when any w values is rational


# constants
Ax = 5
Ay = 5

lot = 1e2

wx = np.sqrt(2)
wy = 1

delta = 200

print("w = ", wx/wy)
print("delta = ", delta)

t = np.linspace(0, lot, 1e5)
length = len(t)

xt = np.zeros(len(t))
yt = np.zeros(len(t))


for i in range(length):
    xt[i] = Ax*np.cos(wx*t[i])
    yt[i] = Ay*np.cos(wy*t[i] - delta)
    
py.plot(xt, yt, 'k-')
py.show()
