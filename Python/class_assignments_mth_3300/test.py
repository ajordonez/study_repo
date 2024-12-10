n = int(input("Enter int odd number:"))
half = (n//2) +1

for i in range(1,n+1):
    for j in range(1,n+1):
        if i == 1 and j <= half:
            print("*",end = "")
        elif i == n and j >= half:
            print("*",end = "")
        elif j == 1 or j == half or j == n:
            print("*",end = "")
        else: 
            print(" ", end = "")
    print()