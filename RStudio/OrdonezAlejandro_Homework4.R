#Question 1:

# Consider mtcars dataset built in R. The data comprise fuel consumption and 10 aspects of automobile design
# and performance for 32 automobiles (1973–74 models). Is there any relationship between the number of
# forward gears (gear) and the number of cylinders (cyl)? If so, describe that relationship. Make a mosaic plot
# to answer the question. (Note that you may need to convert gear and cyl to factors using as.factor().)

gear_f = as.factor(mtcars$gear)
cyl_f = as.factor(mtcars$cyl)
cor(mtcars$gear, mtcars$cyl)
#The correlation coefficient is -0.4926, not a strong correlation between the two factors. 

mosaicplot(cyl_f~gear_f, main = "Forward Gears to Number of Cylinder", xlab = "Number of Cylinders", ylab = "Number of Forward Gears")

#Question 2:

# Consider react dataset built in ISwR package. The react is a numeric vector of the diﬀerences between two
# nurses’ determinations of 334 tuberculin reaction sizes.
# 1. Build a 99% confidence interval for the mean diﬀerence between the two nurses’ reaction sizes. Interpret
# the resulting interval.
# 2. Conduct an appropriate test to see if the mean diﬀerence is negative or not. Provide a complete
# explanation

data("react", package = "ISwR")

#1. 

t.test(react, conf.level = 0.99)

#Confidence interval is -1.0626 to -0.5302

#2. 

t.test(react, mu = 0, alternative = "less")

#When we conducted our t.test, we found that the p-value is near 0 and much less than our alpha value
#and therefore we reject the null hypothesis stating that the true mean is 0. 


# Question 3:

# Consider midwest dataset built in ggplot2 package. The midwest data frame contains demographic
# information of Midwest counties from 2000 US census. Conduct an appropriate test to see if there is
# a significant diﬀerence in the average percent of adult poverty (percadultpoverty) between Illinois (IL) and
# Wisconsin (WI). Clearly state the reasons for your choice of the test and your conclusions. Don’t forget to
# check any assumptions needed for the test.


il = midwest$percadultpoverty[midwest$state == "IL"]
wi = midwest$percadultpoverty[midwest$state == "WI"]

qqnorm(il)
qqline(il)

qqnorm(wi)
qqline(wi)
#After checking the qq graphs, it seems after theoretical quantiles 1-2, the data becomes less normal. 
#We will attempt to proceed

var.test(il,wi)
#Their variances are the same, they are not independent of each other

t.test(il,wi, var.equal = TRUE, mu = 0, alternative = "two.sided")
#The p-value is 0.2134, we fail to reject the null hypothesis, it seems that the true difference in means
#could be equal to 0

# Question 4:
# Consider intake dataset built in ISwR package. The intake data frame has 11 rows and 2 columns, which
# contain paired values of energy intake for 11 women. Conduct an appropriate test to see if there is a significant
# diﬀerence between pre-menstrual intake (pre) and post-menstrual intake (post). Clearly state the reasons
# for your choice of the test and your conclusions. Don’t forget to check any assumptions needed for the test.

data("intake", package = "ISwR")

diff = intake$pre - intake$post

qqnorm(diff)
qqline(diff)
#The QQ tests show that the data seems to be normally distributed


var.test(intake$pre,intake$post)
#var.equal = TRUE

t.test(intake$pre,intake$post, var.equal = TRUE)
#By default the alpha value is 0.05, seeing how our p-value is 0.0163, we reject the null hypothesis
#The true difference in means could not be 0.


# Question 5:

# ABC company manufactures tablets. For quality control, two sets of tablets were tested. In the first group,
# 32 out of 700 were found to contain some sort of defect. In the second group, 30 out of 400 were found to
# contain some sort of defect.
# 1. Which group has a smaller defective rate from a statistical perspective? Conduct an appropriate test
# with 5% significance level to answer the question. Provide a complete explanation.
# 2. Build a 90% confidence interval for the diﬀerence in defective rate between the two groups. Interpret
# the resulting interval.

#1. 

defect = c(32, 30)
population = c(700,400)

prop.test(defect, population, correct = FALSE)
#After doing the proportion test, we get a p-value of 0.0427 rejecting the null hypothesis that there is
#no difference between the two samples. Therefore, the first group has the smaller defective rate at 4.57%

#2. 

prop.test(defect, population, conf.level = .9, correct = FALSE)
#Using the same function but modified so that the conf.level is 90%, we get that the 
#true difference in defective rate lies between -0.0545 and -0.0040. 




