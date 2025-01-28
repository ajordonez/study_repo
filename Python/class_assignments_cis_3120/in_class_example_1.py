#In class example

#Creating a dictionary to store outputs of the function
dic = {}

#The function that has the equation
def y(x):
    try:
        return (4 * (x ** 3) - 12 * (x ** 2) - (9 * x) + 27)/((5 * (x ** 2) + 2) ** 0.5 + 3 * abs(x - 2.5))
    except ZeroDivisionError:
        return "Undefined"

#Run this loop for all values -3 to 3 with 0.5 increments (Note: the range is -6,7 because range does not take floats)
for i in range(-6,7):
    temp = y(i/2)
    dic[i/2] = temp
print(dic)
