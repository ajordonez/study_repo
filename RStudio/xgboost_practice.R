### 
# This program will create a xgboost model for some mock P&C insurance data in order to identify fraud in claims
###

# Get out libraries for analysis
library(xgboost)
library(statmod)
library(tidyverse)
library(rsample)
library(caret)

# Data set used: https://www.kaggle.com/datasets/buntyshah/auto-insurance-claims-data

data <- read.csv("/Users/alexordonez/Downloads/insurance_claims.csv")

#Turn all the categorical variables into factors, then numeric for analysis
data <- data %>%
  mutate_if(is.character, as.factor) %>%
  mutate_if(is.factor, as.numeric)
# N is 1 and Y is 2 for fraud analysis
data$fraud_reported <- data$fraud_reported - 1


# Split data
set.seed(133)
split <- initial_split(data, prop = 0.7)
train_data <- training(split)
test_data <- testing(split)

# Create the xgb Dmatrices for the XGboost model
train_matrix <- xgb.DMatrix(data = as.matrix(train_data[, !names(train_data) %in% "fraud_reported"]), 
                            label = train_data$fraud_reported) # Gen Ai assisted
test_matrix <- xgb.DMatrix(data = as.matrix(test_data[, !names(test_data) %in% "fraud_reported"]), 
                           label = test_data$fraud_reported) # Gen Ai assisted

# Parameters for the xgboost model
params <- list(
  objective = "binary:logistic", # What we are trying to do: classify fraud
  eval_metric = "logloss", # loss function
  max_depth = 6, # Depth of each decision tree
  eta = 0.1, # Learning rate
  subsample = 0.7, # Subset of the data
  colsample_bytree = 0.7 # Percent of features used by each decision tree
)

# Create the model itself
xgb_model <- xgb.train(
  params = params, # setting parameters as the ones listed above 
  data = train_matrix, # Using the xgb matrix for the training data
  nrounds = 500, # Number of rounds
  watchlist = list(train = train_matrix, test = test_matrix), # Setting the test and training matrices
  early_stopping_rounds = 20, # stop early to prevent overfitting
  print_every_n = 10 # self explainatory
)

# Save the model into a rds file for the shiny r
#saveRDS(xgb_model, "xgb_model.rds")
#write.csv(test_data, file = "test_data.csv", row.names = FALSE)

