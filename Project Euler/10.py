#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Project Euler 10
Summation of primes

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
"""

# Sieve implementation
def sieve(n):
    prime = [True for i in range(n+1)]       # array of potential primes, [2 ... n]
      
    p = 2
    while(p * p <= n):                       # condition to check up to sqrt(n)
        
        if (prime[p] == True):               # check if next number is prime
               
            for i in range(p * 2, n + 1, p): # scratch out multiples
                prime[i] = False
        p += 1
    
    ssum = 0
  
    # sum prime numbers 
    for p in range(2, n): 
        if prime[p]: 
            ssum += p
    return ssum 



stop = 2000000
s = sieve(stop)

print('s =', s)