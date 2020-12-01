# -*- coding: utf-8 -*-
"""
tools.py
"""

import numpy as np
import random
import pyautogui
import time


class tools:
    
    #### ==== ---- PROPERTIES ---- ==== ####
    # MAIN WOODCUTTING WILLOWS; TOP AND BOTTOM TREE BELOW PORT SARIM
    top_willow_x = 1358
    top_willow_y = 320
    bot_willow_x = 1480
    bot_willow_y = 630
    
    
    # MAIN WOODCUTTING WILLOWS; TOP AND BOTTOM TREE BELOW PORT SARIM
    top_iron_x = 1482
    top_iron_y = 525
    bot_iron_x = 1403
    bot_iron_y = 613
    
    # CALIBRATION IMAGE DIMENSIONS
    width = 100
    height = 100


    #### ==== ---- CONSTRUCTOR ---- ==== ####
    def __init__(self):
        # find the handle for the window we want to capture
        #self.hwnd = win32gui.FindWindow(None, window_name)
        #if not self.hwnd:
        #    raise Exception('Window not found: {}'.format(window_name))
        print("initilaized")
    
    
    #### ==== ---- LOGOUT PROCEDURE ---- ==== ####
    # LOGOUT A CHARACTER FROM OSRS
    # INPUT: Class properties
    # OUTPUT: No RETURN
    def logout(self):
        print("===== LOGGING OUT =====")
        
        # Build randomness to click points and timing
        x_R = random.randint(10, 15)/10
        y_R = random.randint(10, 15)/10
        t_R = random.randint(1, 5)/10
        
        # Click X on the top right
        pyautogui.moveTo(1900+x_R, 60+y_R, duration=0.15+t_R)
        pyautogui.click()
    
        # Click LOGOUT on panel
        pyautogui.moveTo(1790+x_R, 885+y_R, duration=0.50+t_R)
        pyautogui.click()
    
        # Close out window
        pyautogui.moveTo(1890+x_R, 20+y_R, duration=0.50+t_R)
        pyautogui.click()
        
        
    
    
    #### ==== ---- CALIBRATE WOODCUTTING BOT ---- ==== ####
    # TAKES 4 PICTURES OF TWO WILLOWS (ALIVE/DEAD OF EACH)
    # INPUT: Class properties
    def calibrate_wc_bot(self):
        # Countdown 3 seconds for calibration
        print(" Calibrating... ", end="")
        for i in range(1,4):
            print(i, end="...  ")
            time.sleep(1)
        print("")
        
        # FOR each tree (used for file name looping)
        for i in range(1,3):
            
            file_name = "woodcutting\\willow_" + str(i) + "_alive.png"
             
            # Snap and save a picture of the first tree
            if(i == 1):
                img = pyautogui.screenshot(region=(self.top_willow_x, 
                                                   self.top_willow_y, 
                                                   self.width, self.height))
                img.save(file_name)
            else:
                img = pyautogui.screenshot(region=(self.bot_willow_x, 
                                                   self.bot_willow_y, 
                                                   self.width, self.height))
                img.save(file_name)
            print("   Screenshot of " + file_name + " saved!")
            
            # Start axing first tree (from screenshot above)
            loc = pyautogui.locateCenterOnScreen(file_name, grayscale=True, confidence=0.95)
            pyautogui.moveTo(loc, duration=0.5)
            pyautogui.click()
            
            # While tree 1 exists, cut it down, running same checks for 
            #  stoppage as before. Then snap a picture.
            while loc is not None:
                # Check if tree 1 still exists and store in 'loc'
                loc = pyautogui.locateOnScreen(file_name, grayscale=True, confidence=0.95)
                
                # CHECK IF INVENTORY IS FULL
                check_inv = pyautogui.locateOnScreen('woodcutting\\full_inventory.png')
                if(check_inv is not None):
                    print("  Inventory is full! Dropping...")
                    tools().drop_inventory()
                    pyautogui.moveTo(loc, duration=0.25)
                    pyautogui.click()
                
                # CHECK IF WE JUST LEVELED UP (nice)
                level_up = pyautogui.locateOnScreen('woodcutting\\level_up.png')
                if(level_up is not None):
                    print("  Leveled up!")
                    pyautogui.moveTo(loc, duration=0.25)
                    pyautogui.click()
                    
            
            # Snap and save a picture of the first tree
            file_name = "woodcutting\\willow_" + str(i) + "_dead.png"
            if(i == 1):
                img = pyautogui.screenshot(region=(self.top_willow_x, 
                                                   self.top_willow_y, 
                                                   self.width, self.height))
                img.save(file_name)
            else:
                img = pyautogui.screenshot(region=(self.bot_willow_x, 
                                                   self.bot_willow_y, 
                                                   self.width, self.height))
                img.save(file_name)

            print("  Chopped willow " + str(i) + "!")
            print("   Screenshot of " + file_name + " saved!")
        print("===== WOODCUTTING BOT IS FULLY CALIBRATED =====")
    
    
    
    
    #### ==== ---- CALIBRATE MINING BOT ---- ==== ####
    # TAKES 4 PICTURES OF TWO IRON ORE VEINS (ALIVE/DEAD OF EACH)
    # INPUT: Class properties
    # OUTPUT: No RETURN
    def calibrate_mine_bot(self):
        # Countdown 3 seconds for calibration
        print(" Calibrating... ", end="")
        for i in range(1,4):
            print(i, end="...  ")
            time.sleep(1)
        print("")
        
        # Change image dimensions for the smaller rocks
        self.height = 50
        self.width = 50
        
        # FOR each vein (used for file name looping)
        for i in range(1,3):
            
            # Build file name
            file_name = "mining\\iron_" + str(i) + "_alive.png"
             
            # Snap and save a picture of the first vein
            if(i == 1):
                img = pyautogui.screenshot(region=(self.top_iron_x, 
                                                   self.top_iron_y, 
                                                   self.width, self.height))
                img.save(file_name)
            else:
                img = pyautogui.screenshot(region=(self.bot_iron_x, 
                                                   self.bot_iron_y, 
                                                   self.width, self.height))
                img.save(file_name)
            print("   Screenshot of " + file_name + " saved!")
            
            # Start mining first vein (from screenshot above)
            loc = pyautogui.locateCenterOnScreen(file_name, grayscale=False, confidence=0.95)
            pyautogui.moveTo(loc, duration=0.5)
            pyautogui.click()
            
            # wait two seconds
            time.sleep(2)
            
            
            # Take depleted vein picture
            file_name = "mining\\iron_" + str(i) + "_depleted.png"
            if(i == 1):
                img = pyautogui.screenshot(region=(self.top_iron_x, 
                                                   self.top_iron_y, 
                                                   self.width, self.height))
                img.save(file_name)
            else:
                img = pyautogui.screenshot(region=(self.bot_iron_x, 
                                                   self.bot_iron_y, 
                                                   self.width, self.height))
                img.save(file_name)

            print("  Mined iron ore vein " + str(i) + "!")
            print("   Screenshot of " + file_name + " saved!")
        print("===== MINING BOT IS FULLY CALIBRATED =====")




    #### ==== ---- DROP INVENTORY ---- ==== ####
    # SHIFT-CLICK ON EACH ITEM IN THE INVENTORY
    # INPUT: Class properties
    # OUTPUT: No RETURN
    def drop_inventory(self):
        print("===== DROPPING INVENTORY =====")
        
        # Put window in focus to shift drop
        pyautogui.moveTo(1208,23, duration=0.5)
        pyautogui.click()
        
        # Random time between clicking
        t_r = random.randint(10,25)/100
        
        # Hold down shift
        pyautogui.keyDown('shift')
        time.sleep(t_r)
        
        # Starting inventory coordinates
        start_x = 1710
        start_y = 633
        
        # Click on each item in the inventory, with randomness sprinkled
        #  in with the two variables N1 and N2
        for rows in range(0,7):
            for cols in range(0,4):
                N1 = random.randint(-14, 14)
                N2 = random.randint(-14, 14)
    
                pyautogui.moveTo(start_x+N1+cols*54, start_y+N2+rows*45, duration=t_r)
                pyautogui.click()
    
        time.sleep(t_r)
        pyautogui.keyUp('shift')
    
        print("   Inventory Cleared!")
            
    
    
    
    #### ==== ---- ORIENT CAMERA ---- ==== ####
    # ORIENT CAMERA DUE NORTH AND LOOKING DOWN FROM ABOVE
    # INPUT: Class properties
    # OUTPUT: No RETURN
    def orient_camera(self):
        print("===== ORIENTING CAMERA =====")
        
        # gives compass coordinates
        compass_x = 1713 + random.randint(10, 15)/10
        compass_y = 71 + random.randint(10, 15)/10
        t_r = random.randint(5, 15)/10
        
        # Click on compass to face direct NORTH
        pyautogui.moveTo(compass_x, compass_y, duration=t_r)
        pyautogui.click()
    
        # Use arrow keys to face directly DOWN
        pyautogui.keyDown('up')
        time.sleep(t_r + 1)
        pyautogui.keyUp('up')
        
        print("  Camera has been oriented.")

