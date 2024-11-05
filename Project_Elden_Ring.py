'''
This program will gather stats, talismans, and weapon data in order to
tell you your dps and damage per hit. It will also tell you which bosses your 
build will be good against

'''

import math
import random
import matplotlib.pyplot as plt
import pandas as pd
from pathlib import Path

#Gathering the dataframe for the weapons

directory = Path("/Users/alexordonez/Downloads")
file_path = directory / 'elden_ring_weapon.csv'
data = pd.read_csv(file_path)

class Input_Class:
    def __init__(self):
        print('This program will gather your stats from Elden Ring and will give you your damage given certain conditions')
        self.strength = int(input('Enter your strength stat: '))
        self.dexterity = int(input('Enter your dexterity stat: '))
        self.intelligence = int(input('Enter your intelligence stat: '))
        self.faith = int(input('Enter your faith stat: '))
        self.arcane = int(input('Enter your arcane stat: '))
        self.weapon_choice = input('What weapon are you using? (Write out the full name with capitalization, Ex: Bloodhound\'s Fang): ')

#Creates a smaller dataframe, depending on parameters row and column
def condensed_data(dataframe, row=None, column=None):
    if row is None:
        data_subset = dataframe.iloc[:, :column]  
    elif column is None:
        data_subset = dataframe.iloc[:row, :]
    else:
        data_subset = dataframe.iloc[:row, :column]  
    return data_subset

#This will be the dataframe to compare attack speed to
melee_attack_speed_list = {'Type': ['Axe','Claw','Colossal Sword','Colossal Weapon','Curved Greatsword','Curved Sword','Dagger','Fist','Flail',
                                    'Great Spear','Greataxe','Greatsword','Halberd','Hammer','Heavy Thrusting Sword','Katana','Reaper','Spear',
                                    'Straight Sword','Thrusting Sword','Twinblade','Warhammer','Whip'],
                                    'Hits_Per_Minute': [85,95,37,36,52,84,108,88,65,45,48,54,52,62,71,74,57,62,72,85,70,46,54]}
melee_speed = pd.DataFrame(melee_attack_speed_list)


#Displays a table for the given parameters
def table_display(df):
    fig, ax = plt.subplots()
    
    #Hides the axes
    ax.axis('off')
    ax.axis('tight')
    
    table = ax.table(cellText=df.values, colLabels=df.columns, cellLoc='center', loc='center')
    
    #Set table properties
    table.auto_set_font_size(False)
    table.set_fontsize(12)
    table.scale(1.2,1.2) #Adjusting the table size
 
    plt.show()
    
#Displays the top 5 of a given table
def top_five(unsorted,column):
    df = unsorted.sort_values(column,ascending = False)
    df = df.head()
    fig, ax = plt.subplots()
    
    #Hides the axes
    ax.axis('off')
    ax.axis('tight')
    
    
    table = ax.table(cellText=df.values, colLabels=df.columns, cellLoc='center', loc='center')
    
    #Set table properties
    table.auto_set_font_size(False)
    table.set_fontsize(12)
    table.scale(1.2,1.2) #Adjusting the table size
    
    plt.show()
    
#Getting the variables out of inputs

inputs = Input_Class()

strength = inputs.strength
dexterity = inputs.dexterity
intelligence = inputs.intelligence
faith = inputs.faith
arcane = inputs.arcane
weapon_choice = inputs.weapon_choice


#Calculates the weapon scaling of the weapon based on the user's 
def weapon_scaling(df, user_str, user_dex, user_int, user_fai, user_arc, user_weapon):
    weapon_str = df.loc[user_weapon,'Str']
    print(weapon_str)


#weapon_scaling(data,strength,dexterity, intelligence,faith,arcane,weapon_choice)


top_five(melee_speed, "Hits_Per_Minute")


