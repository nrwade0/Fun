#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
create config files
"""

import string

# values to specify
function_name = "byte"
val = "a"

start_ch = 17
stop_ch = 35

no_bytes = [2,3,4]
interps = ['2c', 'u', 'ieee32']
EUCs = ['0,1/10,0', '0,2**-30,0', '0,1,0']

total_len_grp = 9


sub_group_ids = [ ch for ch in string.ascii_lowercase[:len(no_bytes)] ] # a,b,c, ...
end_string = f"{val} = {function_name} (\n"

for ch in range(start_ch, stop_ch, total_len_grp): # for each group
    for i, (len_i, interp_i, EUC_i) in enumerate(zip(no_bytes, interps, EUCs)): # for each parameter in the group
        
        # calculate start/stop channels
        channel_start = ch 
        channel_end = ch + len_i - 1
        
        # create parameter name
        param_name = f"param_{i}{sub_group_ids[i]}_{channel_start}_{channel_end}"
        ch += len_i
        
        # create decom
        channels = '+'.join(str(chs) for chs in range(channel_start, channel_end))
        line = f"\t{param_name} = [{channels}];{interp_i};EUC[{EUC_i}]  #\n"
        
        end_string += line
end_string += '\t)'
print(end_string)