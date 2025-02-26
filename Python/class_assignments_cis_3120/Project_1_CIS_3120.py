# Project 1 for CIS 3120
# Collaborators: Alejandro Ordonez, Wesley Fann

def introduction():
    print("This program will be taking the averages of 3 integer values and returning the average.")
    print("After returning the average, it will compare each value to the average.")
    print()
master_list = []
def compare_to_avg(a,b,c,avg):
    temp_list = [a,b,c]
    for i in range(3):
        if temp_list[i] == avg:
            print(f"The number {temp_list[i]} is equal to the average")
        if temp_list[i] > avg:
            print(f"The number {temp_list[i]} is greater than the average")
        else: 
            print(f"The number {temp_list[i]} is less than the average")

def find_average(a,b,c):
    return (a+b+c)/3
def main():
    introduction()

    a = int(input("Enter the first integer: "))
    b = int(input("Enter the second integer: "))
    c = int(input("Enter the third integer: "))
    avg = find_average(a,b,c)

    compare_to_avg(a,b,c,avg)





main()