import numpy
def fib_seq(n: int) -> list:
    fib = [0,1]
    i = 1
    while fib[i]+fib[i-1] <= n:
        fib.append(fib[i]+fib[i-1])
        i += 1

    return(fib)

x = int(input('Enter number for fibonnaci sequence to go up to: '))
print(fib_seq(x))