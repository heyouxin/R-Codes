rm(list=ls())
library(leaps)
library(ISLR)
library(pls)
library(glmnet)
#View(Credit)
MSE_ridge <- c()
MSE_lasso <- c()
MSE_pcr <- c()
attach(Credit)
Credit <- Credit[,-1]
rows <- nrow (Credit)  
for (n in 1:100) 
{
  
  x <- model.matrix(Balance~.,Credit)[,-11]
  train <- sample (rows, 200, replace =FALSE)
  ridge_mod <- glmnet(x[train,],Credit[train,11],alpha=0)
  cv_out <- cv.glmnet(x[train,],Credit[train,11],alpha=0)
  bestlam <- cv_out$lambda.min
  ridge_pred <- predict(ridge_mod,s=bestlam,newx=x[-train,])
  MSE_ridge <- c(MSE_ridge,mean((ridge_pred-Credit[-train,11])^2))

  lasso_mod <- glmnet(x[train,],Credit[train,11],alpha=1)
  cv_out <- cv.glmnet(x[train,],Credit[train,11],alpha=1)
  bestlam <- cv_out$lambda.min
  lasso_pred <- predict(lasso_mod,s=bestlam,newx = x[-train,])
  MSE_lasso <- c(MSE_lasso,mean((lasso_pred-Credit[-train,11])^2))

  cv_error <- c()
  for (m in 1:10) {
    pcr_mod<-pcr(Balance~.,m,data=Credit,scale=T,validation="CV")
    pcr_pred <- predict(pcr_mod,newx = Credit[-train,-11])
    cv_error <- c(cv_error,mean((pcr_pred-Credit[-train,11])^2))
    
  }
  MSE_pcr <- c(MSE_pcr,min(cv_error)) 
}
mean(MSE_ridge)
mean(MSE_lasso)
mean(MSE_pcr)