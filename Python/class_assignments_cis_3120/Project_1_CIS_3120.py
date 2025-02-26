# Project 1 for CIS 3120
# Collaborators: Alejandro Ordonez, Wesley Fann


#This function will be in the main function to first introduce what the program does
def introduction():
    print("This program will be taking the averages of 3 integer values and returning the average.")
    print("After returning the average, it will compare each value to the average.")
    print()


#Master list to store all the values of the 
master_list = []


#This function will be called in the main function to compare the average to the a b and c integer variables
def compare_to_avg(a,b,c,avg):
    temp_list = [a,b,c]
    for i in range(3):
        if temp_list[i] == avg:
            print(f"The number {temp_list[i]} is equal to the average")
        if temp_list[i] > avg:
            print(f"The number {temp_list[i]} is greater than the average")
        else: 
            print(f"The number {temp_list[i]} is less than the average")

#Finds the average of a b and c integer variables in main func
def find_average(a,b,c):
    return (a+b+c)/3

def main():
    introduction()

    a = int(input("Enter the first integer: "))
    b = int(input("Enter the second integer: "))
    c = int(input("Enter the third integer: "))
    avg = find_average(a,b,c)
    print(f"The average of the numbers is {avg:.4f}")
    compare_to_avg(a,b,c,avg)





main()