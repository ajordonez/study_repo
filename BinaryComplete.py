import math
import random
#This program will be converting any binary number to base 10

#Gets inputs
binarystr = input('Enter your binary number here: ')

def binary_to_base10(binarystr):
    length = int(len(binarystr))
    base_10 = 0
    power_of = length-1
    invalid = False

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
            power_of = -1
            print('Invalid binary number')
            invalid = True

            
    #Print out the base 10 number
    if invalid == False:
        return base_10

x = binary_to_base10(binarystr)
print(f'Your base 10 number is: {x}')
