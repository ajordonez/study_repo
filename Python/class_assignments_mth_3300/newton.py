#******************************************************************************
# newton.py
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
import math 
# FIRST, WRITE CODE TO GET INPUT FOR THE COEFFICIENTS BELOW, starting with x^0 
# see the pdf specifications for the exact input prompts and formatting

c0 = float(input("Enter x^0 coefficient: "))
c1 = float(input("Enter x^1 coefficient: "))
c2 = float(input("Enter x^2 coefficient: "))
c3 = float(input("Enter x^3 coefficient: "))
c4 = float(input("Enter x^4 coefficient: "))
c5 = float(input("Enter x^5 coefficient: "))

coefs = [c0,c1,c2,c3,c4,c5]

#******************************************************************************
guess = float(input('Enter guess: ')) # the initial guess for Newton's method
    
# the number of iterations for Newton'n method
n_iterations = int(input('Enter number of iterations of Newton\'s method: '))
#******************************************************************************

# INSERT CODE FOR NEWTON'S METHOD BELOW

#This function will first calculate the derivative and put the coefficents into a list
def derive(list_coef: list):
    dx_list = []
    for i in range(1,len(list_coef)):
        dx_list.append(list_coef[i]*i)
    return dx_list
    
#This function evaluates the equation using a list of coefficents
def evaluate(list_eq: list,x) -> float:
    return sum([list_eq[i]*(x**(i)) for i in range(len(list_eq))])

#This function will calculate the actual newton method
def newton(fx: list,x, n) -> float:
    dx = derive(fx)
    for i in range(n):
        x = x - (evaluate(fx,x)/evaluate(dx,x))
    return x

print(newton(coefs, guess, n_iterations))





