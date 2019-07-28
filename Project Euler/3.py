#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Project Euler 3
Largest prime factor

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
"""

# Sieve implementation
def sieve(target, n):
    prime = [True for i in range(n+1)]       # array of potential primes, [2 ... n]
      
    p = 2
    while(p * p <= n):                       # condition to check up to sqrt(n)
        
        if (prime[p] == True):               # check if next number is prime
               
            for i in range(p * 2, n + 1, p): # scratch out multiples
                prime[i] = False
        p += 1
    
    # show prime numbers 
    for p in range(2, n): 
        if(prime[p] and target % p == 0): 
            print('prime factor =', p)
            target = target/p


target = 600851475143
stop = 10000
sieve(target, stop)