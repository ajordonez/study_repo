#This is the data accumulation for the motorcycle data, first we will get
#tidyverse and read the CSV file as "motor_data"
library(tidyverse)

motor_data <- read_csv("/Users/alexordonez/Documents/StudyRepo/Motorcycle_Accident/Motorcycle_Accident_Data.csv")

#We will now convert the following fields into factors for easier analysis

motor_data$BOROUGH <- as.factor(motor_data$BOROUGH)
motor_data$BOROUGH <- relevel(factor(motor_data$BOROUGH), ref = "STATEN ISLAND")

motor_data$VEHICLE_TYPE <- as.factor(motor_data$VEHICLE_TYPE)
motor_data$VEHICLE_MAKE <- as.factor(motor_data$VEHICLE_MAKE)
motor_data$PERSON_INJURY <- as.factor(motor_data$PERSON_INJURY)
motor_data$PERSON_SEX <- as.factor(motor_data$PERSON_SEX)
motor_data$DRIVER_LICENSE_STATUS <- factor(motor_data$DRIVER_LICENSE_STATUS, 
                                           levels = c("Unlicensed", "Permit", "Licensed"), 
                                           ordered = TRUE)
#Make sure that for drivers license status it is ordered
levels(motor_data$DRIVER_LICENSE_STATUS)

#Makes a seperate field so that we can check if the collision cause any injuries or fatalities
motor_data <- motor_data %>%
  mutate(INJURY_OR_FATALITY = ifelse(PERSON_INJURY %in% c("Injured", "Killed"), TRUE, FALSE))
motor_data <- motor_data %>%
  mutate(FATALITY = ifelse(PERSON_INJURY %in% "Killed", TRUE, FALSE))


#Making a logistic regression analysis for if there is a Driver fatality or not

mod1 <- glm(FATALITY ~ BOROUGH+VEHICLE_MAKE+VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS, data = motor_data, family = "binomial")
summary(mod1)


#Multicollinearity is not an issue as we can see from the VIF 

install.packages("car")
library(car)
vif(mod1)

#Lets try the mod1 again with only the significant or close to significant factors p < 0.1
mod1 <- glm(FATALITY ~ VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS, data = motor_data, family = "binomial")
summary(mod1)

null_mod1 <- glm(FATALITY ~ 1, data = motor_data, family = "binomial")
anova(null_mod1, mod1, test = "Chisq")

#Above shows the way we can check to see if the logistic regression model is significant, we can
#use a Chi-Square test to test expected observations (null) and our model to see if p>0.05.
#We find out it is indeed below 0.05, meaning the model is signficant


#Making a logistic regression analysis for if there is an injury or fatality for the driver of the motorcycle

mod2 <- glm(INJURY_OR_FATALITY ~ BOROUGH+VEHICLE_MAKE+VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS, data = motor_data, family = "binomial")
summary(mod2)

#Interesting how the results for the INJURY_OR_FATALITY is different than that of just Fatalities, Manhattan seems to be a significant factor


mod2 <- glm(INJURY_OR_FATALITY ~ BOROUGH+VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS, data = motor_data, family = "binomial")
summary(mod2)

null_mod2 <- glm(INJURY_OR_FATALITY ~ 1, data = motor_data, family = "binomial")
anova(null_mod2, mod2, test = "Chisq")














