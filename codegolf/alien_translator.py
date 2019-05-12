"""
https://codegolf.stackexchange.com/questions/93473/english-to-alien-translator

English to Alien translator
 Vowel  |   With
--------+--------
   a    |   obo
   e    |   unu
   i    |   ini
   o    |   api
   u    |   iki
   
Example:
    Input: Australia
    Output: Oboikistroboliniobo

"""

s = 'Australia'
new_s = ''

vowels = ['a', 'e', 'i', 'o', 'u']
translation = ['obo', 'unu', 'ini', 'api', 'iki']

upper_vowels = ['A', 'E', 'I', 'O', 'U']
upper_translation = ['Obo', 'Unu', 'Ini', 'Api', 'Iki']

for ch in s:
    for i in range(5):
        if(ch == vowels[i]): # lower case translation
            new_s = new_s + translation[i]
            break
        elif(ch == upper_vowels[i]): # upper case translation
            new_s = new_s + upper_translation[i]
            break
        elif(i == 4): # consonant translation
            new_s = new_s + ch
print(s, '->', new_s)