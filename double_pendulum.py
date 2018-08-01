# -*- coding: utf-8 -*-
"""
Created on Sun Jul 29 19:38:03 2018

@author: nit_n
"""

# double pendulum

import numpy as np
import pylab as py
from vpython import sphere, vector, canvas, color, rate, cylinder

""" Good initial conditions

"""


# initial conditions
# angles for bob 1 and 2
theta1i = 78
theta2i = 42

# initial speeds for bob 1 and 2
omega1i = 00
omega2i = 0

# lengths for rods 1 and 2
l1 = 1
l2 = 2

# masses for bob 1 and 2
m1 = 5
m2 = 6

# -----------------------------------------------------------------------------
# define some constants
g = 9.81
a = 0
b = 100
N = 10000

h = (b - a)/N

# theta 1 and 2 ODE
# solved using fourth order Runge-Kutta method
# Runge-Kutta method: https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods
# equations: web.mit.edu/jorloff/www/chaosTalk/double-pendulum/double-pendulum-en.html
def f(r, t):
    
    # omega1 = theta1 prime
    # saves previous values for theta1 and d/dt of theta1
    theta1 = r[0]
    omega1 = r[1]
    
    # saves previous values for theta2 and d/dt of theta2    
    theta2 = r[2]
    omega2 = r[3]
    
    # pushes r[1] (previous theta1 dot) into r[0] spot and
    # calculates new r[1] as fomega1
    ftheta1 = omega1
    # components to the long equations of omega1 prime
    a = -g*(2*m1 + m2)*np.sin(theta1)
    b = m2*g*np.sin(theta1 - 2*theta2)
    c = 2*m2*np.sin(theta1 - theta2)
    d = omega2**2*l2 + omega1**2*l1*np.cos(theta1 - theta2)
    e = l1*(2*m1 + m2 - m2*np.cos(2*theta1 - 2*theta2))
    fomega1 = (a - b - c*d)/e
    
    # pushes r[3] (previous theta2 dot) into r[2] spot and
    # calculates new r[3] as fomega1
    ftheta2 = omega2
    f = 2*np.sin(theta1 - theta2)
    z = omega1**2*l1*(m1  + m2)
    h = g*(m1 + m2)*np.cos(theta1)
    i = omega2**2*l2*m2*np.cos(theta1 - theta2)
    j = l2*(2*m1 + m2 - m2*np.cos(2*theta1 - 2*theta2))
    fomega2 = (f*(z + h + i)/j)

    # returns next values into form of r
    return np.array([ftheta1, fomega1, ftheta2, fomega2], float)

# saves values of [theta1, ftheta, theta2, ftheta2] in one four column array
# intiial values
r = np.array([theta1i, omega1i, theta2i, omega2i], float)

# saves t values from a to b in steps of h
tpoints = np.arange(a, b, h)

# saves theta1 and theta2 points
# saves angular velocity points
theta1_points = []
omega1_points = []
theta2_points = []
omega2_points = []

# increment thru tpoints and find each corresponding
# theta1, omega1, theta2, omega2
for t in tpoints:
    
    # now do some runge-kutta
    k1 = h*f(r, t)
    k2 = h*f(r + 0.5*k1, t + 0.5*h)
    k3 = h*f(r + 0.5*k2, t + 0.5*h)
    k4 = h*f(r + k3, t + h)
    
    r += (k1 + 2*k2 + 2*k3 + k4)/6
    
    theta1_points.append(r[0])
    omega1_points.append(r[1])
    theta2_points.append(r[2])
    omega2_points.append(r[3])
    
# figure outputs
py.figure(1)
py.clf()
py.title(r"time vs $\theta_1$ & $\theta_2$")
py.plot(tpoints, theta1_points, 'r-', label=r'$\theta_1$')
py.plot(tpoints, theta2_points, 'b-', label=r'$\theta_2$')
py.xlabel("time (s)")
py.ylabel("angle (deg)")
py.legend()
py.show()

py.figure(2)
py.clf()
py.title(r"time vs $\omega_1$ & $\omega_2$")
py.plot(tpoints, omega1_points, 'r-', label=r'$\omega_1$')
py.plot(tpoints, omega2_points, 'b-', label=r'$\omega_2$')
py.xlabel("time (s)")
py.ylabel(r"$\omega$ angular velocity (rad/s)")
py.legend()
py.show()

py.figure(3)
py.clf()
py.title(r"$\theta_1$ vs $\theta_2$")
py.plot(theta1_points, theta2_points, 'g-')
py.xlabel(r"$\theta_1$ (deg)")
py.ylabel(r"$\theta_2$ (deg)")
py.show()


# drawing parameters (w x h), scaling factors
w = 800
h = 800

# initial positions for ball 1
x10 = l1*np.sin(theta1_points[0])
y10 = l1*np.cos(theta1_points[0])

# initial positions for ball 2
x20 = x10 + np.sin(theta2_points[0])*l2
y20 = x10 + np.cos(theta2_points[0])*l2

# build scene
scene = canvas(width = w, height = h, center = vector(0,0,0), background = color.white)

# create balls
ball1 = sphere(pos = vector(-x10, -y10, 0), radius = 1e-1, color = color.red, make_trail=True)
ball2 = sphere(pos = vector(-x20, -y20, 0), radius = 1e-1, color = color.blue, make_trail=True)

# create rods axis opposite of ball side
rod1 = cylinder(pos=vector(0, 0, 0), axis = vector(-x10, -y10, 0), radius = 1e-2, color = color.red)
rod2 = cylinder(pos=vector(-x10, -y10, 0), axis = vector(-x20, -y20, 0), radius = 1e-2, color = color.blue)


"""
Negatives used to flip image vertically!!!
"""

# calulcate thru all points found for theta1 and theta2
for t in range(len(tpoints)):
    # steps per second
    rate(1e2)
    
    # new points for ball 1
    x1 = -l1*np.sin(theta1_points[t])
    y1 = -l1*np.cos(theta1_points[t])
    
    # and ball 2
    x2 = -l2*np.sin(theta2_points[t])
    y2 = -l2*np.cos(theta2_points[t])
    
    # update ball positions
    ball1.pos = vector(x1, y1, 0)
    ball2.pos = vector(x1 + x2, y1 + y2, 0)
    
    # update rod1 axis (position stays the same)
    rod1.axis = vector(x1, y1, 0)
    
    # update rod2 axis and position
    rod2.axis = vector(x2, y2, 0)
    rod2.pos = vector(x1, y1, 0)
    












