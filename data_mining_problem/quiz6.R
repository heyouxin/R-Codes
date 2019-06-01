library(MASS)
library(glmnet)
mean <- rep(0,100)
sigma <- matrix(nrow=100,ncol=100)
for (i in 1:100) 
{
  for (j in 1:100) 
  {
    sigma[i,j] <- 0.5^abs(i-j)
    
    
  }
  
}
#View(sigma)
X <- mvrnorm(100,mean,sigma)
e <- rnorm(100)
beta1 <- rep(1,5)
beta2 <- rep(0.5,5)
beta3 <- rep(0,90)
beta <- c(beta1,beta2,beta3)
Y <- X%*%beta+e
MSE_ridge <- c()
MSE_lasso <- c()
#grid=10^seq(10,-2,length=100)

sim <- function(n=100,p=100,r=0.5)
{
  
  scad <- cv.ncreg(X,Y,penalty="SCAD")
  
}
  
  





for (n in 1:100) {
  train <- sample(100,50,replace = F)
  ridge_mod <- glmnet(X[train,],Y[train],alpha=0)
  cv_out <- cv.glmnet(X[train,],Y[train],alpha=0)
  bestlam <- cv_out$lambda.min
  ridge_pred <- predict(ridge_mod,s=bestlam,newx=X[-train,])
  MSE_ridge <- c(MSE_ridge,mean((ridge_pred-Y[-train])^2))
  
  lasso_mod <- glmnet(X[train,],Y[train],alpha=1) 
  cv_out <- cv.glmnet(X[train,],Y[train],alpha=1)
  bestlam <- cv_out$lambda.min
  lasso_pred <- predict(lasso_mod,s=bestlam,newx = X[-train,])
  MSE_lasso <- c(MSE_lasso,mean((lasso_pred-Y[-train])^2))
  
}
mean(MSE_ridge)
mean(MSE_lasso)


