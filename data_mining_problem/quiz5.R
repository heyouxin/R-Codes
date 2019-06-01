library(ISLR)
library(leaps)
library(boot)
fit <- regsubsets(Balance~.,Credit[,-1])
result <- summary(fit)
plot(1:length(result$cp),result$cp,type = 'b')
which.min(result$cp)
plot(1:length(result$bic),result$bic,type = 'b')
which.min(result$bic)
plot(1:length(result$adjr2),result$adjr2,type = 'b')
which.max(result$adjr2)

validation <- function()
{
  rows <- nrow (Credit)    
  train <- sample (rows, 200, replace =FALSE)   
  col_name <- colnames(Credit[,-1])[1:10]  
  formu <- "Balance~"
  v.eror <- c()
  for (i in 1:10) 
  {
    if(i==1)
      formu <- paste0(formu,col_name[i])
    else
      formu <- paste0(formu,"+",col_name[i])
    lm.fit <- lm(formu,subset = train)
    v.eror <- c(v.eror,mean((Credit$Balance-predict(lm.fit,Credit))[-train]^2))

    
    
  }
  return(v.eror)
  
}
va_error <- validation()
plot(1:10,va_error,type = 'b',xlab = 'number of predictors')


crossValidation <- function()
{
  rows <- nrow (Credit)    
  indexes <- sample (rows, 200, replace =FALSE)   
  #Credit_train <- Credit [indexes,-1]
  #Credit_test <- Credit [-indexes,-1]
  col_name <- colnames(Credit[,-1])[1:10]  
  formu <- "Balance~"
  #View(data)
  cv.error <- c()
  for (i in 1:10) 
  {
    if(i==1)
      formu <- paste0(formu,col_name[i])
    else
      formu <- paste0(formu,"+",col_name[i])
    glm.fit <- glm(formu,data=Credit[,-1])
    cv.error <- c(cv.error,cv.glm(Credit[,-1],glm.fit,K=10)$delta[1])
    
 
    
  }
  return(cv.error)
  
}
cross_va_error <- crossValidation()
plot(1:10,cross_va_error,type = 'b',xlab = 'number of predictors')


