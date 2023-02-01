#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
from scipy.spatial.transform import Rotation as R


def new_quaternion(u,v,w):
    """
    returns random quaternion, scalar LAST
    """
    return np.array([ np.sqrt(1-u)*np.sin(2*np.pi*v),
                      np.sqrt(1-u)*np.cos(2*np.pi*v),
                      np.sqrt(u)*np.sin(2*np.pi*w),
                      np.sqrt(u)*np.cos(2*np.pi*w)   ])

def normalize(a):
    """
    normalize a vector
    """
    return a / np.sqrt(np.sum(a**2))

def RSS(q):
    return np.sqrt(np.sum(q**2))



if __name__=="__main__":
    STS = R.from_quat(np.array([0.233186, 0.448435, 0.807183, 0.304936]))
    Body = R.from_quat(np.array([0, 0, 0, 1]))
    
    T = np.dot(STS.as_matrix(), Body.as_matrix())
    #print(T)
    
    STS = R.from_quat(np.array(new_quaternion(0.4, 0.4, 0.26)))
    Body = R.from_matrix(np.dot(STS.as_matrix(), T))
    print(f"Randomized quat:\n {STS.as_quat()}")
    
    print(f"Body transformation quat:\n {Body.as_quat()}")
