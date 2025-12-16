# Ridge regression question

library(ISLR)

library(caret)

library(plotmo)

library(glmnet)

n <- nrow(Credit)

set.seed(50)

split <- sample(n, round(3*n/10))

tr_data <- Credit[-split, ]

te_data <- Credit[split, ]

x_mat_tr <- model.matrix(Balance ~ ., tr_data)[, -1]

x_mat_te <- model.matrix(Balance ~ ., te_data)[, -1]

y_vect_tr <- tr_data$Balance

y_vect_te <- te_data$Balance

cv_ridge <- cv.glmnet(x_mat_tr, y_vect_tr, alpha = 0)

cv_lasso <- cv.glmnet(x_mat_tr, y_vect_tr)

coef(cv_ridge)

coef(cv_lasso)

te_ridge_pred <- predict(cv_ridge, newx = x_mat_te)

te_ridge_error <- mean((te_ridge_pred - y_vect_te)^2)

te_ridge_error

te_lasso_pred <- predict(cv_lasso, newx = x_mat_te)

te_lasso_error <- mean((te_lasso_pred - y_vect_te)^2)

te_lasso_error







# Forward Selection Question

library(MASS)

library(leaps)

data(Boston)

forward <- regsubsets(medv ~ crim + rm + age + dis + tax, 
                      
                      data = Boston, nvmax = 5, method = "forward")

forward_sum <- summary(forward)

best_id <- which.min(forward_sum$bic)

coef(forward, best_id)

print(names(coef(forward, best_id)[-1]))



# Roc question 

set.seed(100)

library(pROC)

library(ISLR)

library(MASS)

library(caret) 

library(r02pro)

data(Default)

n <- nrow(Default)

split <- sample(n, round(3*n/10))

tr_data <- Default[-split, ]

te_data <- Default[split, ]

logi <- glm(default ~ balance + income, data = tr_data, family = "binomial")

lda <- lda(default ~ balance + income, data = tr_data)

pred_logi <- predict(logi, newdata = te_data, type = "response")

pred_lda <- predict(lda, newdata = te_data)$posterior[,2]

roc_logi <- roc(te_data$default, pred_logi)

roc_lda <- roc(te_data$default, pred_lda)

auc_logi <- auc(roc_logi)

auc_lda <- auc(roc_lda)

roc_list <- list(Logistic = roc_logi, LDA = roc_lda)

ggroc(roc_list, size = 1, alpha = 0.5)





# Manual K fold CV question

library(caret)

k_fold <- sample(rep_len(1:5, nrow(Boston)))

for (k in c(5,15)){
  
  k_seq <- numeric(nrow(Boston))
  
  for (fold in 1:5){
    
    tr_data <- Boston[k_fold != fold, ]
    
    te_data <- Boston[k_fold == fold, ]
    
    
    
    knn <- knnreg(medv ~ rm + ptratio, data = tr_data, k = k)
    
    k_seq[k_fold == fold] <- predict(knn, newdata = te_data)
    
    
    
  }
  
  
  
  test_error <- mean((k_seq - Boston$medv)^2)
  
  
  
  print(paste0("MSE with ", k))
  
  print(test_error)
  
}





# Logistic regression question 



set.seed(42)

credit$Balance <- as.factor(credit$Balance)

n <- nrow(credit)

sample_idx <- sample(n, round(n/5))

tr_data <- credit[-sample_idx]

te_data <- credit[sample_idx]

logi <- glm(Balance ~ ., data = tr_data, family = "binomial")

pred_prob <- predict(logi, newdata = te_data, type = "response")

pred_class <- ifelse(pred_prob > 0.3, levels(te_data$Balance)[2],levels(te_data$Balance)[1])

test_error <- mean(pred_class != te_data$Balance)

