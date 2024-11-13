diff = mice2$before - mice2$after
shapiro.test(diff)
qqnorm(diff)
qqline(diff)

v_shaped = mtcars$mpg[mtcars$vs == 0]
straight = mtcars$mpg[mtcars$vs == 1]
diff = v_shaped - straight
shapiro.test(diff); qqnorm(diff); qqline(diff)
t.test(v_shaped, straight ,var.equal = TRUE, conf.level = .99)

library(palmerpenguins)
library(tidyverse)
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

set.seed(3)
x = rnorm(50)
e = rnorm(50)
y = 5-2*x + e; y
plot(x,y)
cor(x,y)

df = data.frame(x,y)
mod = lm(y ~ x, data = df) ; mod
mod.true = 5 -2*x
df.new = data.frame(x = c(1,2,3,4,5))
predict(mod, newdata = df.new,interval = 'prediction',level = 0.97)

abline(mod) ##add fitted line to the plot
lines(x,mod.true,col = "red") ##add true line to plot


#makes a model called mod
mod = lm(qsec ~ hp, data = mtcars); mod
plot(qsec ~ hp, data = mtcars)
abline(mod)

e = resid(mod)
yhat = fitted(mod)
plot(yhat, e , xlab = "Fitted Values", ylab = "Residual")
abline(0,0)

plot(mod)
summary(mod)$coef
confint(mod)

#Question: how much time does it take cars
#that have 270 hp to travel a quarter miles on average?
#Use an appropriate interval estimate with 95% level
mod = lm(qsec ~ hp, data = mtcars)
df_car = data.frame(hp = 270)
predict(mod, newdata = df_car, interval = "confidence", level = 0.95)
