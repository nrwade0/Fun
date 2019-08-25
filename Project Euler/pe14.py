#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 11 16:07:10 2019

@author: nick
"""

import numpy as np

def neven(n):
    return n/2

def nodd(n):
    return 3*n+1


n_arr = np.arange(1, 1000000)
max_count = 0
max_n = 0

for n in n_arr:
    count = 1
    temp_n = n
    
    if(n % 10000 == 0):
        print('n = ', n/10000, '%')
    
    while(n != 1):
        
        if(n % 2 == 0):   # even
            count = count + 1
            n = neven(n)
        
        elif(n % 2 == 1):   # odd
            count = count + 1
            n = nodd(n)
    
    if(count > max_count):
        max_count = count
        max_n = temp_n
        
print('count = ', max_count)
print('max n = ', max_n)