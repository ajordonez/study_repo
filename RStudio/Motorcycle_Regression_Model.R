#This is the data accumulation for the motorcycle data, first we will get
#tidyverse and read the CSV file as "motor_data"
library(tidyverse)

motor_data <- read_csv("/Users/alexordonez/Documents/StudyRepo/Motorcycle_Accident/Motorcycle_Accident_Data.csv")

#We will now convert the following fields into factors for easier analysis

motor_data$BOROUGH <- as.factor(motor_data$BOROUGH)
motor_data$VEHICLE_TYPE <- as.factor(motor_data$VEHICLE_TYPE)
motor_data$VEHICLE_MAKE <- as.factor(motor_data$VEHICLE_MAKE)
motor_data$PERSON_INJURY <- as.factor(motor_data$PERSON_INJURY)
motor_data$PERSON_SEX <- as.factor(motor_data$PERSON_SEX)
motor_data$DRIVER_LICENSE_STATUS <- factor(motor_data$DRIVER_LICENSE_STATUS, 
                                           levels = c("Unlicensed", "Permit", "Licensed"), 
                                           ordered = TRUE)
#Make sure that for drivers license status it is ordered
levels(motor_data$DRIVER_LICENSE_STATUS)







