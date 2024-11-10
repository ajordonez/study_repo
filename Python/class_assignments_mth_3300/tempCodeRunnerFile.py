#******************************************************************************
# quadratic.py
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

# math is imported and the code to get the three coefficents is provided to start off
import math

# Prompt the user for coefficients a, b, and c
a = float(input("Enter x^2 coefficient: "))
b = float(input("Enter x^1 coefficient: "))
c = float(input("Enter x^0 coefficient: "))
x1 = (-1*b+math.sqrt(b**2-4*a*c))/(2*a)
x2 = (-1*b-math.sqrt(b**2-4*a*c))/(2*a)
if x1 == x2:
    print(f'ONE SOLUTION: x = {x1:.4f}')
else:
    print(f'TWO REAL SOLUTIONS: x = {x1:.4f} and x = {x2:.4f}')
