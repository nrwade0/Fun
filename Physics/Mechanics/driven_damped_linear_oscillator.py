# -*- coding: utf-8 -*-
"""
Created on Fri Jul 27 16:30:43 2018

@author: nit_n
"""

# Graphing a driven damped linear oscillator


import numpy as np
import pylab as py



def f(t):
    return A*np.cos(w*t - delta) + np.exp(-beta*t)*(B1*np.cos(w1*t) + B2*np.sin(w1*t))


t = np.linspace(0, 5, 100)
w = 2*np.pi     # driving frequency
w0 = 5*w        # natural frequency
beta = w0/20    # decay constant
f0 = 1000       # driving amplitude

T = 2*np.pi/w   # period


# parameters solvable by equation
A = (f0**2)/((w0*w0 - w*w)**2 + (2*beta*w)**2) # amplitude
delta = np.arctan(2*beta*w/(w0*w0 - w*w)) # phase angle
w1 = np.sqrt(w0*w0 - beta*beta)           # decayer frequency


# amplitdues of transient term (with x0 = v0 = 0)
B1 = -A*np.cos(delta)
B2 = 1/w1*(-w*A*np.sin(delta) + beta*B1)

# prints for checking
print("period = ", T)
print("amplitude = ", A)
print("phase angle = ", delta)
print("B1 = ", B1)
print("B2 = ", B2)

# motion along x(t)
xt = np.zeros(len(t))

# driving force
drivef =np.zeros(len(t))

# fill arrays
for i in range(len(t)):
    n = t[i]
    drivef[i] = f0*np.cos(w*n)
    xt[i] = f(n)

py.figure(1)
py.title("Driving force as a function of time")
py.plot(t, drivef, 'r-')
py.show()

py.figure(2)
py.title("x(t) motion of oscillator - transients die out after three oscillations (low beta)")
py.plot(t, xt, 'b-')
py.show()



