#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 16 18:16:39 2024

@author: alexordonez
"""

a = input("Enter calculator input: ")

x= float(a.split()[0])

operation = a.split()[1]

y = float(a.split()[2])

if operation == '+':

    print(f'{x + y:.2f}')

elif operation == '-':

    print(f'{x - y:.2f}')
    
elif operation == '*' or 'x':
    
    print(f'{x * y:.2f}')  
    
elif operation == "/":
    
    print(f'{x / y:.2f}')  

else:
    print('Invalid operation or syntax')