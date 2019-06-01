library(ISLR)
library(MASS)
library(glmnet)
library(ROSE)
library(class)
Auto2 <- Auto[,1:6]
View(Auto2)
attach(Auto2)
mpg01 <- c()
for (i in 1:length(Auto2$mpg)) 
{
  if(Auto2$mpg[i]>=median(Auto2$mpg))
    Auto2$mpg01[i] <- 1
  else
    Auto2$mpg01[i] <- 0
  
}

par(mfrow=c(2,2))
for (j in 2:6)
{
  plot(Auto2[,j],Auto2$mpg01,xlab = colnames(Auto2)[j],ylab = "mpg01")
  boxplot(Auto2[,j],Auto2$mpg01,xlab = colnames(Auto2)[j],ylab = "mpg01")
}




glm_fit <-  glm(mpg01~displacement+horsepower+weight+acceleration,data=train_set,family = binomial)
glm_probs <- predict(glm_fit,test_set,type = "response")
glm_pred <- rep(0,196)
glm_pred[glm_probs>=.5] <- 1
print(paste0("logistic test error:",mean(glm_pred!=test_set$mpg01)))

lda_fit <- lda(mpg01~displacement+horsepower+weight+acceleration,data=train_set)
lda_fit
lda_pred <- predict(lda_fit,test_set)
lda_mpg01 <- lda_pred$class
print(paste0("lda test error:",mean(test_set$mpg01!=lda_mpg01)))

qda_fit <- qda(mpg01~displacement+horsepower+weight+acceleration,data=train_set)
qda_fit
qda_pred <- predict(qda_fit,test_set)
qda_mpg01 <- qda_pred$class
print(paste0("qda test error:",mean(test_set$mpg01!=qda_mpg01)))

x_train <- train_set[,3:6]
x_test <- test_set[,3:6]

for (k in 1:10) 
{
  knn_pred <- knn(x_train,x_test,train_set$mpg01,k=k)
  mean(knn_pred!=test_set$mpg01)
  print(paste0("k=",k,"  knn test error:",mean(test_set$mpg01!=knn_pred)))
  
}


