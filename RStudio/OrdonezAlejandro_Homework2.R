#Alejandro Ordonez Homework 2

#Question 1
#1
data('mtcars')
sub1 <- select(mtcars, mpg, cyl, hp, wt, am); str(sub1)

sub1 <- mtcars[,c(1:2,4,6,9)]; head(sub1)

#2 
sub2 <- filter(mtcars,mpg>=25,cyl==4,hp>100)

sub2 <- mtcars %>% 
  filter(mpg>=25,cyl ==4, hp>100)

#3
sub3 <- mtcars %>% 
  select(hp,wt,am) %>% 
  filter(am == 1,hp>180)

sub3 <- mtcars[,c(4,6,9)] %>% 
  filter(am == 1, hp> 180)

#4
#Highest fuel efficiency
max <- which.max(mtcars$mpg); mtcars[max,]

ord <- order(mtcars$mpg,decreasing =TRUE); mtcars[ord[1],]

#Lightest car
min <- which.min(mtcars$wt); mtcars[min,]

ord <- order(mtcars$wt,decreasing =FALSE); mtcars[ord[1],]

#5
ordering <-order(c(mtcars$hp,mtcars$mpg),decreasing = TRUE)
mtcars[ordering[1:5],c(1,4)]

#Question 2
dat.wide = read.table(header=TRUE, text='
Student Sex Math Literature PE 
A M 99 45 56
B F 73 83 55
C M 44 96 NA
D F NA 80 88
E F 85 74 96
')

#1
dat.comp <- na.omit(dat.wide);dat.comp
  
dat.comp <- dat.wide[complete.cases(dat.wide),];dat.comp

#2
dat.wide %>% rowwise %>% 
  mutate(AVG = (Math+Literature+PE)/3)
#Student E has the highest average

#3
grade.lst <- list(c(99,73,44,85),c(45,83,96,80,74),c(56,55,88,96))
lapply(grade.lst[1],mean);lapply(grade.lst[2],mean);lapply(grade.lst[3],mean)
#The subject with the lowest grade is PE with an average of 73.75

#4
dat.long <- dat.wide %>% 
  gather(Subject,Grade, Math, Literature, PE); dat.long



