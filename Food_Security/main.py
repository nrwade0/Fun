#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 4 19:25:22 2019

@author: nick
"""

from xlwt import Workbook 


print('')
print('')
print(' ---------------------------------------------------------------------- ')
print('|                                                                      |')
print('|                   EXPANDED FOOD SECURITY SCREENER                    |')
print('|                                                                      |')
print(' ---------------------------------------------------------------------- ')
print('')

# Print some instructions for user


def questionnaire():
    
    answers = ['NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA']
    
    print('')
    # ----------------------- Initial Inquiry
    print(' -------------------------- INTIAL INQUIRY ------------------------- ')
    print("If you had groceries available, would you be able to use them to prepare hot meals? \n  1. YES \n  2. NO")
    answers[0] = input("Answer: ")
    print("")
    
    
    if(answers[0] == '2'):
        print("")
    # ----------------------- Follow-up Inquiry
        print(' ------------------------- FOLLOW-UP INQUIRY ----------------------- ')
        print("Do you have reliable help with meal preparation? \n 1. YES \n 2. NO")
        answers[1] = input("Answer: ")
        print("")
        if(answers[1] == '2' or answers[1] == 'no' or answers[1] == 'NO'):
            print("STOPPED -- Client is LEVEL A priority.")
            return answers


    print("")
    # ----------------------- Question 1
    print(' --------------------------- QUESTION 1 ---------------------------- ')
    print("During the last month, how often was this statement true: The food that we bought just didn't last, and we didn't have money to get more. \n 1. OFTEN \n 2. SOMETIMES \n 3. NEVER",)
    answers[2] = input("Answer: ")
    print("")
    
     
    print("")
    # ----------------------- Question 2
    print(' ---------------------------- QUESTION 2 --------------------------- ')
    print("During the last month, how often was this statement true: We couldn't afford to eat balanced meals. \n 1. OFTEN \n 2. SOMETIMES \n 3. NEVER")
    answers[3] = input("Answer: ")
    print("")
    
    
        
    print("")
    # ----------------------- Question 3
    print(' ---------------------------- QUESTION 3 --------------------------- ')
    print("During the last month, did you or other adults in your \n household ever cut the size of your meals because there wasn't enough money for food? \n 1. YES \n 2. NO")
    answers[4] = input("Answer: ")
    print("")
    
    
    print("")
    # ----------------------- Question 4
    print(' ---------------------------- QUESTION 4 --------------------------- ')
    print("During the last month, did you or other adults in your household ever skip meals because there wasn't enough money for food? \n 1. YES \n 2. NO")
    answers[5] = input("Answer: ")
    print("")
    
    
    print("")
    # ----------------------- Question 5
    print(' ---------------------------- QUESTION 5 --------------------------- ')
    print("During the last month, did you ever eat less than you felt because there wasn't enough money for food? \n 1. YES \n 2. NO")
    answers[6] = input("Answer: ")
    print("")
    
    
    print("")
    # ----------------------- Question 6
    print(' ---------------------------- QUESTION 6 --------------------------- ')
    print("During the last month, were you ever hungry but didn't eat because you couldn't afford enough food? \n 1. YES \n 2. NO")
    answers[7] = input("Answer: ")
    print("")
    
    
    print("")
    # ----------------------- Final Inquiry
    print(' --------------------------- FINAL INQUIRY ------------------------- ')
    print("Are you able to get groceries into your home when you need them? \n 1. YES \n 2. NO")
    answers[8] = input("Answer: ")
    print("")
    
    
    return answers




def calculate_points(ans):
    
    points = 0
    priority = ''
    
    if(ans[1] == '2' or ans[1] == 'no' or ans[1] == 'NO'):
        ans.append('NA')
        ans.append('A')
        return ans
    
    if(ans[2] == '1' or ans[2] == '2' or ans[2] == 'often' or ans[2] == 'OFTEN' or ans[2] == 'sometimes' or ans[2] == 'SOMETIMES'):
        points = points + 1
    
    if(ans[3] == '1' or ans[3] == '2' or ans[3] == 'often' or ans[3] == 'OFTEN' or ans[3] == 'sometimes' or ans[3] == 'SOMETIMES'):
        points = points + 1
    
    if(ans[4] == '1' or ans[4] == 'yes' or ans[4] == 'YES'):
        points = points + 1
    
    if(ans[5] == '1' or ans[5] == 'yes' or ans[5] == 'YES'):
        points = points + 1
    
    if(ans[6] == '1' or ans[6] == 'yes' or ans[6] == 'YES'):
        points = points + 1
    
    if(ans[7] == '1' or ans[7] == 'yes' or ans[7] == 'YES'):
        points = points + 1
    
    if(ans[8] == '1' or ans[8] == 'yes' or ans[8] == 'YES'):
        if(points >= 0 and points <= 1):
            print("Applicant is LEVEL E priority.")
            priority = 'E'
        if(points >= 2 and points <= 6):
            print("Applicant is LEVEL C priority.")
            priority = 'C'
    elif(ans[8] == '2' or ans[8] == 'no' or ans[8] == 'NO'):
        if(points >= 0 and points <= 1):
            print("Applicant is LEVEL D priority.")
            priority = 'D'
        if(points >= 2 and points <= 6):
            print("Applicant is LEVEL B priority.")
            priority = 'B'
    
    ans.append(points)
    ans.append(priority)
    return ans
    



def rewrite_data(d):
    
    new_d = []
     
    # initial question
    if(d[0] == '1' or d[0] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # follow-up
    if(d[1] == '1' or d[1] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # 1a
    if(d[2] == '1' or d[2] == 'OFTEN'):
        new_d.append('often')
    elif(d[2] == '2' or d[2] == 'SOMETIMES'):
        new_d.append('sometimes')
    else:
        new_d.append('never')
    
    # 1b
    if(d[3] == '1' or d[3] == 'OFTEN'):
        new_d.append('often')
    elif(d[3] == '2' or d[3] == 'SOMETIMES'):
        new_d.append('sometimes')
    else:
        new_d.append('never')
    
    # 1c
    if(d[4] == '1' or d[4] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # 1d
    if(d[5] == '1' or d[5] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # 1e
    if(d[6] == '1' or d[6] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # 1f
    if(d[7] == '1' or d[7] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    # final inquiry
    if(d[4] == '1' or d[8] == 'YES'):
        new_d.append('yes')
    else:
        new_d.append('no')
    
    print("Rewriting data...")
    print("")




def write_to_excel(data):
      
    wb = Workbook() 
    sheet1 = wb.add_sheet('data') 
    
    header = ['intial question', 'follow-up', '1A', '1B', '1C', '1D', '1E', '1F', 'question 2', 'points', 'priority level']
    
    if(current_row == 0):
        for i in range(len(header)):
            sheet1.write(0, i, header[i])
    
    for i in range(len(data)):
        sheet1.write(1, i, data[i])
      
    wb.save('data.xls')
    print("Saved into 'data.xls'")
    print("")




another_client = True
current_row = 0


while(another_client):
    
    answers = questionnaire()
    data = calculate_points(answers)
    final_data = rewrite_data(data)
    
    current_row = current_row + 1
    
    print("Do you want to add another client? (y/n)")
    more = input("Answer: ")
    print("")
    print("")
    print("")
    
    if(more == 'n' or more == 'no'):
        another_client = False
        write_to_excel(data)
        print("Saved information in 'data.xls'")
        print("")
















