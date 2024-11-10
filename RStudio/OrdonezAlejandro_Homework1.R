#Question 1
temp = 28
a1 = ((temp*9)/5)+32;a1

#Question 2
x = seq(100,150,2);x
a2 = sum(101:149);a2
b2= mean(100:120);b2

#Question 3
var1 = FALSE
var2 = pi
var3 = -2
a3 = (log(var2,10)+(var2)**3)/exp(var3);a3
b3 = (var1+var2+var3)**(1/3);b3

#Question 4
kb = c(7.6, 15.4, 19.9, 22.5, 28.5, 25.2, 30.0, 24.0, 27.6, 35.4, 31.6, 28.3, 26.8, 27.0, 25.3, 27.9, 27.3, 13.8, 22.3, 17.6)
a4 = length(kb[kb<=30])-length(kb[kb>=25]);a4

#Question 5
m1 = matrix(1:20,5,4,FALSE)
dimnames(m1) = list(c('row1','row2','row3','row4','row5'),c('co1','col2','col3','col4'))
m1

#Question 6
macros = matrix(c(50,8,20,60,30,40,40,30,40),3,3,TRUE)
dimnames(macros) = list(c('breakfast','lunch','dinner'),c('carbs','fat','protein'))
macros

#Q6 P1
p1 = colSums(macros, FALSE, 1);p1

#Q6 P2
calories = matrix(c(4,9,4,4,9,4,4,9,4),3,3,TRUE)
p2 = rowSums(macros*calories,FALSE,1);p2
p3 = sum(p2);p3

#Q6 P3
p4 = (colSums(macros*calories,FALSE,1))/p3;p4
#He is close to his goal but is eating too much fat. He needs to eat less fat and more protein and he will reach his goal. 

