#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 20 19:21:01 2020

https://towardsdatascience.com/heres-how-you-can-access-your-entire-imessage-history-on-your-mac-f8878276c6e9

@author: nick
"""


# import libraries
import sqlite3
import pandas as pd


# establish connection to .db file and point cursor
conn = sqlite3.connect('chat.db')
cursor = conn.cursor()

# get the names of the tables in the database
cursor.execute("SELECT name FROM sqlite_master WHERE type = 'table';")

# get messages and handles
messages = pd.read_sql_query("select * from message limit 10", conn)
handles = pd.read_sql_query("select * from handle", conn)

# and join to the messages, on handle_id
messages.rename(columns={'ROWID' : 'message_id'}, inplace = True)
handles.rename(columns={'id' : 'phone_number', 'ROWID': 'handle_id'},
               inplace = True)

