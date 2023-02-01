#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Nick Wade
HW 1
Problem 5
Euler and RK method of integration
"""

import numpy as np
import matplotlib.pyplot as plt



def inf_norm(vector): # infinity norm
    return max(abs(row.sum()) for row in vector)

def y_prime(t, y): # ODE
    return np.exp(t) * np.sin(y)

def y_function(t, C):
    C = 2.8895803590438893
    return 2*np.arctan(np.exp(np.exp(t)-C))

def get_C(y0, t0):
    return np.exp(t0) - np.log(np.tan(y0/2))

def euler(h, C, y0=0.3, t0=0): # h=step size; C = integration constant; y0 initial cond.
    t = np.arange(t0, 10 + h, h) # Numerical grid
    
    # set up vars
    y = np.zeros(len(t))
    y[0] = y0
    
    # euler method execution
    for i in range(0, len(t) - 1):
        y[i + 1] = y[i] + h*y_prime(t[i], y[i])
    
    # plot results
    plt.figure(figsize = (12, 8))
    plt.plot(t, y, 'b-', label=f"Euler's method y0={y0}")
    plt.plot(t, y_function(t, C), 'g', label=f'Exact solution ({round(y_function(t[-1], C), 5)})')
    plt.title(f"HW 1 Problem 5d (dt={h})")
    plt.xlabel('t')
    plt.ylabel('y(t)')
    plt.grid()
    plt.legend()
    plt.show()
    

def rungekutta4(y0, t0, h):
    t = np.arange(t0, 10 + h, h) # Numerical grid
    n = len(t)
    y = np.zeros(len(t))
    y[0] = y0
    
    for i in range(n - 1):
        h = t[i+1] - t[i]
        k1 = y_prime(t[i], y[i])
        k2 = y_prime(t[i] + h/2, y[i] + k1*h/2)
        k3 = y_prime(t[i] + h/2, y[i] + k2*h/2)
        k4 = y_prime(t[i] + h, y[i] + k3*h)
        y[i+1] = y[i] + (h/6) * (k1 + 2*k2 + 2*k3 + k4)
        
    # plot results
    plt.figure(figsize = (12, 8))
    plt.plot(t, y, 'b-', label=f"Runge Kutta y0={y0}")
    plt.plot(t, y_function(t, C), 'g', label=f'Exact solution ({round(y_function(t[-1], C), 5)})')
    plt.title(f"HW 1 Problem 5f (dt={h})")
    plt.xlabel('t')
    plt.ylabel('y(t)')
    plt.grid()
    plt.legend()
    plt.show()





if __name__ == "__main__":
    
    # 5b
    C = get_C(y0=0.3, t0=0)
    euler(h=0.3, C=C)
    
    # 5c
    euler(h=0.001, C=C)
    euler(h=0.002, C=C)
    euler(h=0.003, C=C)
    
    # 5d
    C = get_C(0.3, 0)
    euler(h=0.3, C=C, y0=0.301)
    C = get_C(0.3, 0)
    euler(h=0.3, C=C, y0=0.302)
    
    # 5f
    C = get_C(y0=0.3, t0=0)
    rungekutta4(t0=0, y0=0.3, h=0.3)
    
    rungekutta4(y0=0.3, t0=0, h=0.001)
    rungekutta4(y0=0.3, t0=0, h=0.002)
    rungekutta4(y0=0.3, t0=0, h=0.003)
    
    
    
    