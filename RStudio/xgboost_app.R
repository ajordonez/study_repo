###
# This program will use the model made in the xgb_model.rds file and create 
# a lorenzo and gains curve graphic for the data 
###

# Load the libraries
library(xgboost)
library(statmod)
library(tidyverse)
library(shiny)
library(ggplot2)
library(shinythemes)
library(caret)

# Recalling the model from xgboost_practice_model.R
model <- readRDS("xgb_model.rds")

# Recalling the test data from xgboost_practice_model.R
test_data <- read.csv("test_data.csv")

# Creating a function that makes the lorenzo curve
calculateLorenzCurve <- function(predictions, actuals) {
  data <- data.frame(predictions = predictions, actuals = actuals)
  data <- data[order(data$predictions), ]
  data$cum_actuals <- cumsum(data$actuals)
  data$cum_population <- seq_along(data$actuals) / length(data$actuals)
  data$cum_actuals <- data$cum_actuals / sum(data$actuals)
  return(data)
}

# Creating a function to calculate Gini coefficient
calculateGini <- function(predictions, actuals) {
  data <- data.frame(actuals = actuals, predictions = predictions)
  data <- data[order(data$predictions), ]
  data$cum_actuals <- cumsum(data$actuals) / sum(data$actuals)
  data$cum_population <- seq_along(data$actuals) / length(data$actuals)
  B <- sum(data$cum_actuals) / length(data$cum_actuals)
  gini <- 1 - 2 * B
  return(gini)
}


# Create the ui 
ui <- fluidPage(theme = shinytheme("yeti"),
                navbarPage(theme = "yeti", 
                           "XGBoost for Claims Fraud",
                           # Create the first panel for gains curve
                           tabPanel(
                             "Gains Curve",
                             
                             mainPanel(
                               plotOutput("gainCurve"),
                             )
                           ),
                           # Second panel for Lorenz Curve
                           tabPanel("Lorenz Curve",
                                    
                                    sidebarPanel(
                                      h4("Inputs for different models coming soon!")
                                    ),
                                    mainPanel(plotOutput("lorenzCurve")
                                    )
                           ),
                           # Third panel for model summary
                           tabPanel("Model Summary",
                                    verbatimTextOutput("modelSummary")
                                    
                           )
                )
)

# Start the server function
server <- function(input, output) {
  # Create the simple model summary
  output$modelSummary <- renderPrint({
    print(model)
  })
  
  
  # Generate gain curve plot
  output$gainCurve <- renderPlot({
    # Use the model to check each feature's importance and give them each a percentage gain for the chart
    gain_data <- xgb.importance(model = model)
    gain_data <- gain_data[order(-gain_data$Gain), ]
    gain_data$cumulative_gain <- cumsum(gain_data$Gain)
    gain_data$percentage_gain <- (gain_data$Gain / sum(gain_data$Gain)) * 100
    
    # Graph the gains curve
    ggplot(gain_data, aes(x = reorder(Feature, -Gain), y = cumulative_gain)) +
      geom_line() +
      geom_point() +
      theme_minimal() +
      labs(title = "Cumulative Gain Curve", x = "Feature", y = "Cumulative Gain") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_text(aes(label = paste0(round(percentage_gain, 2), "%")), vjust = -0.5, size = 3.5)
  })
  
  
  # Generate the lorenz curve
  output$lorenzCurve <- renderPlot({
    # Convert the test data into a xgb friendly format and use it to give us predictions to check against the actual fraud
    xgb_test <- xgb.DMatrix(data = as.matrix(test_data %>% select(-fraud_reported)))
    predictions <- predict(model, newdata = xgb_test)
    actuals <- test_data$fraud_reported
    lorenz_data <- calculateLorenzCurve(predictions, actuals)
    gini_coefficient <- calculateGini(predictions, actuals)
    
    # Plot the lorenz curve
    ggplot(lorenz_data, aes(x = cum_population, y = cum_actuals)) +
      geom_line() +
      geom_abline(intercept = 0, slope = 1, linetype = "dotted", color = "blue") +
      theme_minimal() +
      labs(title = "Lorenz Curve for Fraud Detection", x = "Cumulative Share of Population", y = "Cumulative Share of Fraud") +
      annotate("text", x = 0.55, y = 0.2, label = paste("Gini Coefficient:", round(gini_coefficient, 5)), size = 5) # Gen Ai Assisted
    
  })
  
}

# Run app
shinyApp(ui = ui, server = server)

