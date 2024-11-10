#Question 1 
dice_set = c(1,2,2,2,3,4,4,4,5,6,6,6)
set.seed(124)
unfair_dice = sample(dice_set,size = 1000, replace = TRUE)
table(unfair_dice)

#Question 2

set.seed(124)
x = 1:100
y = function(x) {norm_sim = rnorm(200, mean = x, sd = x) 
  data.frame(mean = mean(norm_sim), standard_deviation = sd(norm_sim))}
norm_finish = t(sapply(x,y)); head(norm_finish)

#Question 3
#1.
solution_1 = dbinom(8,500,0.02); solution_1

#2.
solution_2 = pbinom(9,500,0.02,FALSE); solution_2

#Question 4
#1.
library(ggplot2)
barplot(table(diamonds$cut),xlab = 'Cut Grade', ylab = 'Frequency')
#Ideal has the most diamonds

#2. 
hist(diamonds$price, xlab = '$Price')
#The distribution is highly skewed to the right, most of the data is below $5,000

#3. 
diamonds %>% group_by(cut) %>% 
  summarize(median = median(price), standard_deviation = sd(price),maximum = max(price),average = mean(price))
#It looks like the highest average is premium, the highest priced diamond is of cut premium, and the most variation is also premium

#4. 
boxplot(diamonds$price ~ diamonds$color, xlab = 'Color', ylab = 'Price')
#It looks like J and I have the highest median and looks like the highest average. Almost all colors have similar maximums and minimums.

