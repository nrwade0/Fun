# -*- coding: utf-8 -*-
"""
Created on Tue Mar 19 13:52:15 2019

@author: nwade1
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import sys



"""
1342-0  is Pride & Prejudice                  by Jane Austen.
84-0    is Frankenstein                       by Mary Shelley.
11-0    is Alice's Adventure in Wonderland    by Lewis Carroll.
2701-0  is Moby Dick                          by Herman Melville.
76-0    is The Adventures of Huckleberry Finn by Mark Twain.
pg1661  is The Adventures of Sherlock Holmes  by Sir Athur Conan Doyle.
120-0   is Treasure Island                    by Robert Louis Stevenson.
36-0    is War of the Worlds                  by H.G. Wells.
pg61    is The Communist Manifesto            by Karl Marx & Friedrich Engels.
pg4363  is Beyond Good & Evil                 by Friedrich Nietzsche.
pg5200  is Metamorphosis                      by Franz Kafka.
pg1260  is Jane Eyre                          by Charlotte Bronte.
pg23    is Life of Frederick Douglass         by Frederick Douglass.
pg1250  is Anthem                             by Ayn Rand.
pg1497  is The Republic                       by Plato.
"""

f1 = open('1342-0.txt', encoding = "utf8")
f2 = open('84-0.txt', encoding = "utf8")
f3 = open('11-0.txt', encoding = "utf8")
f4 = open('2701-0.txt', encoding = "utf8")
f5 = open('76-0.txt', encoding = "utf8")
f6 = open('pg1661.txt', encoding = "utf8")
f7 = open('120-0.txt', encoding = "utf8")
f8 = open('36-0.txt', encoding = "utf8")
f9 = open('pg61.txt', encoding = "utf8")
f10 = open('pg4363.txt', encoding = "utf8")
f11 = open('pg5200.txt', encoding = "utf8")
f12 = open('pg1260.txt', encoding = "utf8")
f13 = open('pg23.txt', encoding = "utf8")
f14 = open('pg1250.txt', encoding = "utf8")
f15 = open('pg1497.txt', encoding = "utf8")

# Store these files to be looped and read
files = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15]

# Create variables for bookkeeping
lettercount = np.zeros(26)
wordcount = 0

# First for loop is for each txt file (each book)
for f in files:
    
    # Second for loop for each word in that book
    # lowercase and split at spaces
    for word in f.read().lower().split():
        
        # word count is added, actually is unnecessary...
        # More for fun
        wordcount = wordcount + 1
        
        # Third for loop follows each letter in each word
        for letter in word:
            
            # letter converted to ASCII val then zeroed out to an index
            # i.e. 'a' = 97 ascii so 'a' is now index 0
            index = ord(letter) - 97
            
            # if ASCII val was not a lowercase character...
            if index > 25 or index < 0:
                break
            
            # otherwise add it to the letter count
            lettercount[index] += 1


# Print no. of words and no. of each letter
print("Gutenberg wordcount = ", wordcount)
#print(lettercount)

# Fix up plotted axes and convert lettercount to percentages
x = np.arange(26)
y = lettercount / sum(lettercount)

# Labels used on x-axis of plot
labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
          'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

# Print the percentages of each letter
#for i in range(len(lettercount)):
#    print("%s = %.2f" %(labels[i], y[i]))

"""
# Final plot gives bar plot of letter frequencies
plt.figure(1)
plt.title("Letter Frequencies")
plt.bar(x, y*100, align = 'center', alpha = 0.5)
plt.xticks(x, labels)
plt.ylim(0, 15)
plt.ylabel("Percentage of use")
plt.show()
"""


""" 
-------------------   Cipher solving -------------------------------------
"""


# Take the statistics on the ciphered text
ciph_data = open('ciphered1.txt', encoding = "utf8")

ciph_lettercount = np.zeros(26)
ciph_wordcount = 0

for word in ciph_data.read().lower().split():
    ciph_wordcount = ciph_wordcount + 1
    for letter in word:
        index = ord(letter) - 97
        if index > 25 or index < 0:
            break
        ciph_lettercount[index] += 1

ciph_prob = ciph_lettercount / sum(ciph_lettercount)
print("Ciphered wordcount = ", ciph_wordcount)


plt.figure(2)
plt.title("Cipher letter freq")
plt.bar(x, ciph_prob*100, align = 'center', alpha = 0.5)
plt.xticks(x, labels)
plt.ylim(0, 15)
plt.ylabel("Percentage of use")
plt.show()

#creat one dataframe that holds all stats and chars
gutenberg_df = pd.DataFrame({'stats': y, 'char': labels})
ciph_df = pd.DataFrame({'stats': ciph_prob, 'char': labels})

g_df = gutenberg_df.sort_values(by=['stats'], ascending=False)
c_df = ciph_df.sort_values(by=['stats'], ascending=False)

g_df.reset_index(drop=True, inplace=True)
c_df.reset_index(drop=True, inplace=True)

df = g_df.join(c_df, rsuffix="_c")

# Show dataframe with stats
#print(df)

# drop stats and keep keys
df.drop(['stats', 'stats_c'], axis=1, inplace=True)


# first n chars match up?
# No. of hints given
n = 1
hints = 2
n = n + hints

#g_sigma = g_df.iloc[0:sigma, 0:2]
#c_sigma = c_df.iloc[0:sigma, 0:2]

#same_char = pd.DataFrame(sigma, 2)

# some np arrays to give keys
key = np.empty([1, 2], dtype=str)
#hint = np.empty([2, 2], dtype=str)

#hint[0,0] = "H" # crypted W equals read H
#hint[0,1] = "W"
#key[0,0] = hint[0,0]
#key[0,1] = hint[0,1]

#hint[1,0] = "M" # crypted M equals read I
#hint[1,1] = "I"
#key[1,0] = hint[1,0]
#key[1,1] = hint[1,1]

key[0,0] = df.iloc[0, 0]
key[0,1] = df.iloc[0, 1]

#for i in range(3):
#    print(g_df.iloc[i,1], " =? ", hint[0,0])
#    if g_df.iloc[i,1] == hint[0,0]: # If this value is already guessed
#        print("found it at", i)
#        sigma = i - 1
#        break
#        
#    same_char_list[i+2,0] = g_df.iloc[i, 1]
#    same_char_list[i+2,1] = c_df.iloc[i, 1]
        
# import ciphered data
ciph_data = open('ciphered1.txt', encoding = "utf8")

#debug_f = open("debug_ciph.txt", 'w')
#f_solved = open("solved.txt", 'w')


#debug_f = open("debug_ciph.txt", 'w')
#f_solved = open("solved.txt", 'w')

# Import information on words
with open("freq_doubles.txt", 'r') as f:
    double_words = f.read().upper().split('; ')
    
with open("freq_singles.txt", 'r') as f:
    single_words = f.read().upper().split('; ')
    
with open("freq_two_letter_words.txt", 'r') as f:
    twolet_words = f.read().upper().split('; ')
    
with open("freq_three_letter_words.txt", 'r') as f:
    threelet_words = f.read().upper().split('; ')
    
with open("freq_four_letter_words.txt", 'r') as f:
    fourlet_words = f.read().upper().split('; ')


# DEFINE FUNCTIONS FOR ENCRYPTING/DECRYPTING
# Receives a char and encodes it based on currently known keys
def encrypt(ch):
    for index in range(len(key)):
        if key[index,0] == ch:
            return key[index,1]
        
    return '-'

# Receives a value and decodes it based on currently known keys
def decrypt(ch):
    for index in range(len(key)):
        if key[index,1] == ch:
            return key[index,0]
        
    return '-'


#write = sys.stdout.write

#def new_file():
#    f_solved = open("solved.txt", 'w')
#    return f_solved


#f = new_file()
f = open("solved_f.txt", 'w')
done = False


# WHILE LOOP CREATES A MASTER KEY LIST
# While the the total key list is not finished
#while done == False:
        
for word in ciph_data.read().upper().split(' '): # For each word split by a space

    # Check each letter in the word
    temp_str = ""
    for letter in word:
        
        known = False # Letter is assumed to be unknown
        
        # Remove any punctuation
        if ord(letter) < 65 or ord(letter) > 90: # has punctuation in it
#            if ord(letter) == 39: # do something special with apostrophes
#                continue
            continue # skip this char
        else:
            temp_str = temp_str + letter
        
        
        # Read and check the single words
        if len(temp_str) == 1:
            print(temp_str, "is a single word")
            
            for letter in word:
                for i in range(len(key)):
                    if decrypt(letter) == '-':
                        known = False
                    else:
                        known = True
                        
        # Read and check the double words
        if len(temp_str) == 2:
            print(temp_str, "is a double word")
        
        # Read and check the triple words
        if len(temp_str) == 3:
            print(temp_str, "is a triple word")
        
        # Read and check the quadruple words
        if len(temp_str) == 4:
            print(temp_str, "is a quadruple word")
    
    
    print(temp_str, " ")
    
    
    
    
    

# Read and check the double letters
        
        

        
        
    
        
#    if len(key) == 26:
#       done = True
#    break
   
f.close()
#debug_f.close()






