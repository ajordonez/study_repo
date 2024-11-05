#******************************************************************************
# parking.py
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

#Gather the inputs first

preferred_spot_1 = int(input('Car 1 preferred spot: '))
preferred_spot_2 = int(input('Car 2 preferred spot: '))

#There is only a conflict if both cars want the same spot so we will do that if statement first
if preferred_spot_1 == preferred_spot_2:
    if preferred_spot_1 == 3:
        print('Car 1 parks in spot 3\nCar 2 cannot park')
    else:
        print(f'Car 1 parks in spot {preferred_spot_1}\nCar 2 parks in spot {preferred_spot_2+1}')
else:
    print(f'Car 1 parks in spot {preferred_spot_1}\nCar 2 parks in spot {preferred_spot_2}')
    