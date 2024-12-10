data(iris)
cor(iris[,1:4])

plot(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris)

boxplot(Sepal.Length ~ Species, data = iris)

is.factor(iris$Species)
model = lm(Sepal.Length ~ Petal.Length + Petal.Width + Species, data = iris)

summary(model)

confint(model)

#Make a temp data frame to input into the predict function
df.temp = data.frame(Petal.Length = 5, Petal.Width = 1, Species = "versicolor")

predict(model, newdata = x.new, interval = "confidence")
#We use confidence bc we are testing for the average mean for these conditions

#LOGISTICAL REGRESSION

#first we will clean the data for "heart" in the "kmed" package
heart = heart %>% rename(max_hr = thalach, heart_disease = class)

heart$sex = factor(heart$sex, levels = c(FALSE, TRUE), labels = c("female","male"))

heart$heart_disease[heart$heart_disease != 0] = 1
heart$heart_disease = factor(heart$heart_disease, levels = c(0,1), labels = c("no disease", "disease"))

head(heart)

mod1 = glm(heart_disease ~ age, data = heart, family = "binomial")
summary(mod1)

confint(mod1, parm = "age")

age.new = seq(min(heart$age), max(heart$age))
x.new = data.frame(age = age.new)
prob = predict(mod1, newdata = x.new, type = "response")
plot(age.new, prob, type = "l", xlab = "Age", ylab = "Probability")
abline(0.5, 0, col='red')

#the little dot here means that R will use all the variables as predictors
mod2 = glm(heart_disease ~ ., data = heart, family = "binomial")

summary(mod2)$coef

exp(mod2$coef["sexmale"]); exp(mod2$coef["max_hr"])

