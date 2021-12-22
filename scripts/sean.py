import pandas as pd
import random


# https://stackoverflow.com/questions/46820182/randomly-generate-1-or-1-positive-or-negative-integer
def get_rando():
    rand = random.random()
    if rand > 0.5:
        return 1
    else:
        return -1
    """ equivalent
    return 1 if random.random() > 0.5 else -1
    """

# read from excel sheet
# https://pandas.pydata.org/docs/reference/api/pandas.read_excel.html
df = pd.read_excel("50_50    Increasing Bets.xlsx", sheet_name="Random Data and Bets")
print(df)

# ======
# or create your own
rando_list = [get_rando() for i in range(20)]
df = pd.DataFrame(data=rando_list, columns=["random_vals"])
print(df)

# add other null columns/rows
cols = ["1_prev", "2_prev", "3_prev"]
for col in cols:
    df[col] = [None]*20
print(df)

# access a single value
print(df.random_vals.iloc[9])

for idx in range(0, 19):
    if idx < 4:
        print(df.random_vals.iloc[idx])
