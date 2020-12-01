"""
woodcutting_bot 1.0

PREAMBLE imports all the modules used.
INPUT gets user parameters, orientation, and calibration.
FIND and CUT destroys both pairs of trees per 'N_run'

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
N_max = int(input("How many times would you like to cut both trees? "))

# tools object instantiation called 't'
t = tools()


##### ===== ORIENT THE CAMERA & CALIBRATE THE BOT USING TOOLS ===== #####
if(calibrate == "y"):
    t.orient_camera()
    t.calibrate_wc_bot()


##### ===== ----- FIND AND CUT TREES ----- ===== #####
for N_run in range(1, N_max):
    print("=====", N_run, "/", N_max, " =====")
    
    # FOR each tree (2 in main spot)
    for i in range(1,3):
        
        # Wait for next tree to respawn if first was chopped down too quickly
        time.sleep(2)
        
        # Build randomness into the system (changes depend on location of clicks)
        if(i % 2 == 1): # odd (first tree)
            x_R = random.randint(-10, 10)
            y_R = random.randint(3, 28)
        else: # even (second tree)
            x_R = random.randint(-30, 5)
            y_R = random.randint(-50, 0)
        t_R = random.randint(-5, 5)/10
        
        # Create (alive and dead) file_name for current willow
        file_name_alive = "woodcutting\\willow_" + str(i) + "_alive.png"
        file_name_dead = "woodcutting\\willow_" + str(i) + "_dead.png"

        
        # Find the tree, add randomness, throw error if not found
        loc_x, loc_y = pyautogui.locateCenterOnScreen(file_name_alive, grayscale=True, confidence=0.80)
        loc_x += x_R
        loc_y += y_R
        if(loc_x is None):
            print("   ERROR - Could not locate willow tree.")
            print("   The bot needs calibrated first!")
            break
        pyautogui.moveTo(loc_x, loc_y, duration=0.5+t_R)
        pyautogui.click()
        
        # While willow is alive, cut it down. Stops and restarts when character
        # has full inventory or levels up
        r = None
        while r is None:
            r = pyautogui.locateOnScreen(file_name_dead, grayscale=True, confidence=0.9)
            
            # FULL INVENTORY CHECK
            check_inv = pyautogui.locateOnScreen('woodcutting\\full_inventory.png', grayscale=True, confidence=0.95)
            if(check_inv is not None):
                print("  Inventory is full! Dropping...")
                t.drop_inventory()
                pyautogui.moveTo(loc_x, loc_y, duration=0.25+t_R)
                pyautogui.click()
            
            # LEVEL UP CHECK
            level_up = pyautogui.locateOnScreen('woodcutting\\level_up.png', grayscale=True, confidence=0.95)
            if(level_up is not None):
                print("  Leveled up! Restarting...")
                pyautogui.moveTo(loc_x, loc_y, duration=0.25+t_R)
                pyautogui.click()

# Type in-game when done.
t.drop_inventory()
pyautogui.write('Whew!', interval=0.50)
pyautogui.press('enter')
#t.logout()