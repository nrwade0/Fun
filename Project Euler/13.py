# -*- coding: utf-8 -*-
"""
Project Euler problem 25

Work out the first ten digits of the sum of the one-hundred 50-digit numbers 
 found in the accompanying text file PE13_data.txt.

"""

# open text file containing values
f = open('PE13_data.txt', 'r') 

# intialize list to hold values
lines = []

# read, parse and sum the values.
for i in range(100):
    lines.append(f.readline().strip('\n')) # append each num to list and remove new line cmds
    lines[i] = int(lines[i]) # parse

# sum
print('sum = ', sum(lines))
