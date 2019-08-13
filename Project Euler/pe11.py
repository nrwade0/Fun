#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 11 00:08:58 2019

@author: nick
"""

import numpy as np


grid = np.loadtxt('pe11')

prod_max = 1

for a in range(20):
    for b in range(20):
        
        # LEFT/RIGHT
        if(b < 17):
            prod = grid[a, b] * grid[a, b+1] * grid[a, b+2] * grid[a, b+3]
            if(prod > prod_max):
                prod_max = prod
        
        # UP/DOWN
        if(a < 17):
            prod = grid[a, b] * grid[a+1, b] * grid[a+2, b] * grid[a+3, b]
            if(prod > prod_max):
                prod_max = prod
            
        # DIAGONAL DOWN/LEFT
        if(a < 17 and b < 17):
            prod = grid[a, b] * grid[a+1, b+1] * grid[a+2, b+2] * grid[a+3, b+3]
            if(prod > prod_max):
                prod_max = prod
            
        # DIAGONAL DOWN/RIGHT
        if(a < 17 and b > 2):
            prod = grid[a, b] * grid[a+1, b-1] * grid[a+2, b-2] * grid[a+3, b-3]
            if(prod > prod_max):
                prod_max = prod

print(prod_max)



