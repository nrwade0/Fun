"""
https://towardsdatascience.com/heres-how-you-can-access-your-entire-imessage-history-on-your-mac-f8878276c6e9

FUTURE WORK: analyze text information, most used words, etc.
             do something with the timestamp, most common time to text
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
#messages = pd.read_sql_query("SELECT * FROM message limit 10", conn)
b_messages  = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 1", conn)
s_messages  = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 7", conn)
c_messages  = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 3", conn)
m_messages  = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 9", conn)
d_messages  = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 11", conn)
ch_messages = pd.read_sql_query("SELECT text, date, is_emote, is_from_me, cache_has_attachments FROM message WHERE handle_id = 10", conn)

handles = pd.read_sql_query("SELECT * FROM handle", conn)


# ---- 
# lists of character data for plotting
brooke = [b_messages.loc[:,"is_from_me"].mean(),
          b_messages.loc[:,"cache_has_attachments"].mean(),
          b_messages.loc[:,"is_emote"].mean(),
          len(b_messages)/len(s_messages)]

sean   = [s_messages.loc[:,"is_from_me"].mean(),
          s_messages.loc[:,"cache_has_attachments"].mean(),
          s_messages.loc[:,"is_emote"].mean(),
          len(s_messages)/len(s_messages)]

chris  = [c_messages.loc[:,"is_from_me"].mean(),
          c_messages.loc[:,"cache_has_attachments"].mean(),
          c_messages.loc[:,"is_emote"].mean(),
          len(c_messages)/len(s_messages)]

mom    = [m_messages.loc[:,"is_from_me"].mean(),
          m_messages.loc[:,"cache_has_attachments"].mean(),
          m_messages.loc[:,"is_emote"].mean(),
          len(m_messages)/len(s_messages)]

dan    = [d_messages.loc[:,"is_from_me"].mean(),
          d_messages.loc[:,"cache_has_attachments"].mean(),
          d_messages.loc[:,"is_emote"].mean(),
          len(d_messages)/len(s_messages)]

chunk  = [ch_messages.loc[:,"is_from_me"].mean(),
          ch_messages.loc[:,"cache_has_attachments"].mean(),
          ch_messages.loc[:,"is_emote"].mean(),
          len(ch_messages)/len(s_messages)]


index = ['from_me', 'has_attachments', 'is_emote', 'regu_number_of_texts']

df = pd.DataFrame({'brooke':brooke,
                   'sean':sean,
                   'dad':chris,
                   'mom':mom,
                   'dan':dan,
                   'chunk':chunk}, index = index)
ax = df.plot.bar(rot=0)


# messages = pd.read_sql_query("select *, datetime(message.date/1000000000 + strftime("%s", "2001-01-01") ,"unixepoch","localtime") as date_uct from message", conn)
