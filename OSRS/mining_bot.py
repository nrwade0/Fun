"""
mining_bot 1.0

PREAMBLE imports all the modules used.
INPUT gets user parameters, orientation, and calibration.
FIND and MINES both pairs of IRON ORE per 'N_run'

"""

##### ===== ----- PREAMBLE ----- ===== #####
# Import tools.py class to use for calibration and other helpful modules
# numpy for array manipulation, random for randomness is clicking, pyautogui 
# for clicking and moving the cursor, and time for waiting
from tools import tools
import numpy as np
import random
import pyautogui
import time


##### ===== ----- GET BOT PARAMETERS ----- ===== #####
calibrate = input("Do you want to calibrate the bot? [y/n] ")
N_max = int(input("How many times would you like to mine the ore vein? "))

# tools object instantiation called 't'
t = tools()


##### ===== ORIENT THE CAMERA & CALIBRATE THE BOT USING TOOLS ===== #####
if(calibrate == "y"):
    t.calibrate_mine_bot()
    t.orient_camera()


##### ===== ----- FIND AND CUT TREES ----- ===== #####
for N_run in range(1, N_max):
    print("=====", N_run, "/", N_max, " =====")
    
    # FOR each tree (2 in main spot)
    for i in range(1,3):
        
        # Wait for next tree to respawn if first was chopped down too quickly
        #time.sleep(2)
        
        # Build randomness into the system (changes depend on location of clicks)
        if(i % 2 == 1): # odd (first tree)
            x_R = random.randint(-5, 5)
            y_R = random.randint(-5, 5)
        else: # even (second tree)
            x_R = random.randint(-5, 5)
            y_R = random.randint(-5, 5)
        t_R = random.randint(-5, 5)/10
        
        # Create (alive and dead) file_name for current willow
        file_name_alive = "mining\\iron_" + str(i) + "_alive.png"
        file_name_depleted = "mining\\iron_" + str(i) + "_depleted.png"

        
        # Find the tree, add randomness, throw error if not found
        loc_x, loc_y = pyautogui.locateCenterOnScreen(file_name_alive, grayscale=True, confidence=0.85)
        loc_x += x_R
        loc_y += y_R
        if(loc_x is None):
            print("   ERROR - Could not locate iron vein.")
            print("   The bot needs calibrated first!")
            break
        pyautogui.moveTo(loc_x, loc_y, duration=0.5+t_R)
        pyautogui.click()
        
        # While willow is alive, cut it down. Stops and restarts when character
        # has full inventory or levels up
        r = None
        while r is None:
            r = pyautogui.locateOnScreen(file_name_depleted, grayscale=True, confidence=0.9)
            time.sleep(1)

        
        # DROP RECENTLY PICKED UP
        # Random time between clicking
        t_R = random.randint(12,20)/100
        
        # Hold down shift
        pyautogui.keyDown('shift')
        time.sleep(t_R)
        
        # Starting inventory coordinates        
        X = 1710 + random.randint(-14, 14)
        Y = 633 + random.randint(-14, 14)
    
        pyautogui.moveTo(X, Y, duration=t_R)
        pyautogui.click()
    
        time.sleep(t_R)
        pyautogui.keyUp('shift')
        
# Type in-game when done.
#t.drop_inventory()
pyautogui.write('Whew!', interval=0.50)
pyautogui.press('enter')
#t.logout()