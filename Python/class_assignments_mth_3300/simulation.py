#******************************************************************************
# simulation.py
#******************************************************************************
# Name: Alejandro Ordonez
#******************************************************************************
# Collaborators/outside sources used 
#(IMPORTANT! Write "NONE" if none were used):
#NONE
#
#
# Reminder: you are to write your own code.
#******************************************************************************
# Overall notes (not to replace inline comments):
#
#
import random

num_of_plays = 10 ** 6

earnings_over_all_plays = 0
num_successes = 0 
x = int(input()) 
# in one play, to keep the amount earned, we must get > x dollars
##################### DO NOT MODIFY ANY CODE ABOVE #######################################
##################### YOUR CODE SHOULD BE BELOW THIS LINE ################################
for i in range(num_of_plays):
    temp_earn = 0
    for j in range(1,5):
        roll = random.randrange(1,7)
        if roll >=1 and roll <=3:
            temp_earn += 1
        elif roll == 4:
            temp_earn += 5
        elif roll == 5:
            temp_earn += 10
        elif roll ==6:
            temp_earn += 50
    if temp_earn > x:
        earnings_over_all_plays += temp_earn
        num_successes += 1
    else:
        earnings_over_all_plays += -100



##################### YOUR CODE SHOULD BE ABOVE THIS LINE ################################
##################### DO NOT MODIFY ANY CODE BELOW #######################################
print(f'{num_successes/num_of_plays:.1f}') # estimate of the probability of winning > x in a play of the game
print(f'{earnings_over_all_plays/num_of_plays:.0f}') # estimate of the expected value of the amount won in a single play