set.seed(33)
x1 = rnorm(50)
x2 = rnorm(50)
e = rnorm(50, sd =2)
y = 30 + 5*x1 + 7*x2 + e

plot(x1, y); plot(x2,y)
cor(x1,y); cor(x2,y)

mod = lm()
y_hat = fitted(mod)
plot(y_hat, df$y, xlab = "Fitted y", ylab = "True y")

cor(mtcars$mpg, mtcars$hp)
cor(mtcars$mpg, mtcars$wt)

model = lm(mpg ~ hp + wt, data = mtcars)
y_hat = fitted(model)
plot(model)

qqplot(model)
qqline(model)

#MLR

model = lm(mpg ~ hp + wt, data = mtcars)
plot(model)
summary(model)
confint(model)

model = lm(mpg ~ hp + wt, data = mtcars)
df.car = data.frame(hp = 270, wt = 4)
predict(model, newdata = df.car, interval = "prediction", level = 0.95)
