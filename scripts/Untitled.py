#from pandas_datareader import data
import matplotlib.pyplot as plt
import pandas as pd
import datetime
Current_Date = datetime.date.today()

from random import random
from random import seed
import statistics as stats

#fig, ax = plt.subplots(figsize=(16,9))

seed(random())

def get_rando():
    return 1 if random() > 0.5 else -1

rando_list = [get_rando() for i in range(20)]
print(rando_list)

x = [i for i in range(15)]
print(x)

"""

Finding Consecutive successes

Run_list is consecutive wins

"""


# JUST SOME VARIABLES, can change "trials"

trials = 15
list_of_rand = []
run = 0
run_list = []



# GENERATING LIST OF RANDOM NUMBERS

for i in range(trials):
    #print('{}'.format(i))

    rand = round(random(),3)
    list_of_rand.append(rand)



# printing numbers used other than forst 10
startingpoint = 2

#for i in range(startingpoint, len(list_of_rand)):
    #print(list_of_rand[i])


print(list_of_rand)


base = 1
strike = 0.5
total = 0



# Trouble here
bet = 0
n = 0

for i in range(len(rando_list)):

    if rando_list[i] == 1: # win
        bet = 1*n
        n = 0

    if rando_list[i] == -1: # loss
        n += 1
        bet = -1

    total = total + bet
    print('{} {} {} {}'.format(rando_list[i], bet, n, total))

print('total = {}'.format(total))
