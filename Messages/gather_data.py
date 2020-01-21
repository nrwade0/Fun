#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 20 19:21:01 2020

@author: nick
"""

# connection code
import sqlite3
import pandas as pd

# substitute username with your username
conn = sqlite3.connect('chat.db')

cursor = conn.cursor()

cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")

#print(cursor.fetchall())

# get messages and handles
messages = pd.read_sql_query("select * from message limit 10", conn)
handles = pd.read_sql_query("select * from handle", conn)

# and join to the messages, on handle_id
messages.rename(columns={'ROWID' : 'message_id'}, inplace = True)
handles.rename(columns={'id' : 'phone_number', 'ROWID': 'handle_id'},
               inplace = True)

merge_level_1 = temp = pd.merge(messages[['text', 'handle_id', 'date','is_sent',
                                         'message_id']],  handles[['handle_id',
                                                      'phone_number']], on ='handle_id', how='left')

# get the chat to message mapping
chat_message_joins = pd.read_sql_query("select * from chat_message_join", conn)

# and join back to the merge_level_1 table
df_messages = pd.merge(merge_level_1, chat_message_joins[['chat_id', 'message_id']], on = 'message_id', how='left')