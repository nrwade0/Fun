#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 11 00:08:58 2019

@author: nick
"""

from math import sqrt



def countDivisors(n) : 
    cnt = 0
    for i in range(1, (int)(sqrt(n)) + 1) : 
        if (n % i == 0) : 
              
            # If divisors are equal, 
            # count only one 
            if (n / i == i) : 
                cnt = cnt + 1
            else : # Otherwise count both 
                cnt = cnt + 2
                  
    return cnt 




for i in range(2,100000):
    
    temp = sum(range(i))
    divs = countDivisors(temp)
    
    #print('Number = ', temp, ' divisors: ', divs)
    
    if(divs >= 500):
        print(temp)
        break
