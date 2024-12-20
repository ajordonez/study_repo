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

mod1 <- glm(FATALITY ~ VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS+PERSON_AGE, data = motor_data, family = "binomial")
summary(mod1)

#Multicollinearity is not an issue as we can see from the VIF 

install.packages("car")
library(car)
vif(mod1)

null_mod1 <- glm(FATALITY ~ 1, data = motor_data, family = "binomial")
anova(null_mod1, mod1, test = "Chisq")

#Above shows the way we can check to see if the logistic regression model is significant, we can
#use a Chi-Square test to test expected observations (null) and our model to see if p>0.05.
#We find out it is indeed below 0.05, meaning the model is signficant


#Making a logistic regression analysis for if there is an injury or fatality for the driver of the motorcycle

mod2 <- glm(INJURY_OR_FATALITY ~ BOROUGH+VEHICLE_TYPE+PERSON_SEX+DRIVER_LICENSE_STATUS+PERSON_AGE, data = motor_data, family = "binomial")
summary(mod2)

#Interesting how the results for the INJURY_OR_FATALITY is different than that of just Fatalities, Manhattan seems to be a significant factor


null_mod2 <- glm(INJURY_OR_FATALITY ~ 1, data = motor_data, family = "binomial")
anova(null_mod2, mod2, test = "Chisq")



#We will make a graphic that shows the injuries and fatalities per 100,000 residents
#per Borough. We have to make a separate data frame and then mutate onto motor_data
#to do that 
borough_pop <- data.frame(
  BOROUGH = c("BRONX", "BROOKLYN", "MANHATTAN", "QUEENS", "STATEN ISLAND"),
  POPULATION = c(1379946, 2590516, 1596273, 2278029, 491133)
)

borough_pop$BOROUGH <- as.factor(borough_pop$BOROUGH)
motor_data <- merge(motor_data, borough_pop, by = "BOROUGH")

injury_or_fatality_summary <- motor_data %>%
  group_by(BOROUGH) %>% summarise(INJURY_OR_FATALITY_COUNT = sum(INJURY_OR_FATALITY),
                                  POPULATION = first(POPULATION)) %>%
  mutate(RATE_PER_100K = (INJURY_OR_FATALITY_COUNT / POPULATION) * 100000)

ggplot(injury_or_fatality_summary, aes(x = BOROUGH, y = RATE_PER_100K, fill = BOROUGH)) +
  geom_bar(stat = "identity") + labs(title = "Injuries or Fatalities per 100,000 Residents by Borough",
                                     x = "Borough", y = "Rate per 100,000 Residents") + theme_minimal() + theme(legend.position = "none")



#We will make now a graph that shows the relationship between age and the likelihood of
#a injury or fatality occurring. We would need to first do something very similar to what we did
#for the borough graph, adding a new column to motor_data.
age_summary <- motor_data %>%
  group_by(PERSON_AGE) %>%  
  summarise(TOTAL_CASES = n(), INJURY_OR_FATALITY_COUNT = sum(INJURY_OR_FATALITY)) %>%
  mutate(PROBABILITY_PER_AGE = INJURY_OR_FATALITY_COUNT / TOTAL_CASES)  

ggplot(age_summary, aes(x = PERSON_AGE, y = PROBABILITY_PER_AGE)) +
  geom_point(color = "red", size = 2) +  
  labs(title = "Likelihood of Injury or Fatality by Age", x = "Age", y = "Likelihood of Injury or Fatality") + theme_minimal()
