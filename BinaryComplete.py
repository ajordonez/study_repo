import math
import random
#This program will be converting any binary number to base 10

#If this were to be turned into a function, below would be the syntax
def binary_to_base10(binarystr) -> None:
    binarystr = input('Enter your binary number here: ')
    length = int(len(binarystr))
    base_10 = 0
    power_of = length-1

    #This is the beginning of the conversion
    while power_of >=0:
        if binarystr[0] == '1':
            base_10 += 2**power_of
            power_of += -1
            binarystr = binarystr[1:]
            
        elif binarystr[0] == '0':
            power_of += -1
            binarystr = binarystr[1:]
        else:
            print('Invalid binary number')
            power_of = -1
            
    #Print out the base 10 number
    print('Your base 10 number is:',base_10)

