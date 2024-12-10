#SCRIPT TO FUNCTION:

pay = 40
hours = c(7,8,3,4,6)
price = sum(pay*hours)
print(price)

#How to make a function:

get_price = function(hours){
  pay = 40
  price = sum(pay*hours)
  return(price)
}

input = c(4,6,7,4,3,5,6)
get_price(input)

get_price2 = function(hours){
  dailyprice = hours*40
  price = sum(dailyprice) 
  return(list(daily.price=dailyprice, total.price=price)) 
}

input = c(4,6,7,4,3,5,6)
get_price2(input)

get_price3 = function(hours, pay){
  dailyprice = hours * pay
  price = sum(dailyprice)
  return(list(total.price = price, daily.price = dailyprice))
  
}


input_h = c(4,5,6,7,8)
input_p = c(50)
get_price3(input_h, input_p)


#How to do if else statements in R:

get_sqrt = function(x) {
  if (x>= 0) {
    print(sqrt(x))
  } else {
    print("Negative Number")
  }
}
input = -100
get_sqrt(input)


#For else if do this:

get_sqrt = function(x) {
  if (all(x> 0)) {
    print(sqrt(x))
  } else if (any(x<0)){
    print("Negative Number")
  } else {
    print("No Zeros")
  }
}



getPrice = function(hours, pay, client){ 
  dailyprice = hours*pay 
  if(client=="public"){ 
    tot.dailyprice = dailyprice*1.06 
  } else if(client=='private'){ 
    tot.dailyprice = dailyprice*1.12 
  } else{
    tot.dailyprice = dailyprice 
  } 
  price = sum(tot.dailyprice); return(price) 
}

#For Loops in R:

x = 3
for(i in 2:1000){ 
  x[i] = x[i-1] + (i-1)
}
print(x)


words = c("hi", "there")
for(i in words) {
  info = c(i,nchar(i))
  print(info)
}


hours = c(7, 9, 3, 10, 6)
dailyprice = 70*hours ## without discount nday = length(hours)
nday = length(hours)
for(i in 1:nday){ 
  if (hours[i] > 8){ ## find discounted days dailyprice[i] = dailyprice[i]*0.9 
    dailyprice[i] = dailyprice[i]*0.9
    } } 
sum(dailyprice)






