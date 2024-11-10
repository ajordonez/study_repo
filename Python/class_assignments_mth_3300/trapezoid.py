#******************************************************************************
# trapezoid.py
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
from math import *

#DEFINE YOUR FUNCTION f HERE:

integral = 0.0

def f(x) -> float:
    return sqrt(1+(sin(x)**2))

#TEST CODE FOR THE FUNCTION f: (uncomment to test, comment out before submitting to Gradescope)
#print(f(0.2), '(this should equal 1.0195437719875284 if your function works)')
#print(f(-1.4), '(this should equal 1.4039626670016296 if your function works)')


#CODE FOR GETTING THE INPUT:
A = float(input('Enter A: '))
B = float(input('Enter B: '))
N = int(input('Enter N: '))


#N = 10 ** 7

################################################
#INSERT CODE FOR COMPUTING APPROXIMATION OF DEFINITE INTEGRAL USING TRAPEZOIDAL RULE BELOW:   
'''
This is some puedo code just so I can visualize what I am doing
delta x = (B-A) /N

integral = 0
for i in range(A,B+1,delta x):
    x1 = A + i * delta x
    x2 = A + (i+1) * delta x
    integral += (f(x1) + f(x2)) * delta x /2
'''
delta_x = (B-A) / N

for i in range(0,N):
    x1 = A + i * delta_x
    x2 = A + (i+1) * delta_x
    integral += (f(x1) + f(x2)) * delta_x /2

    #print(f'For {N} iterations: {integral:.8f}')



################################################

#CODE FOR PRINTING THE APPROXIMATION TO 8 DECIMAL PLACES
# integral is the variable for the approximation 
print(f'{integral:.8f}')
