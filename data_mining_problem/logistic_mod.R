library(ISLR)
library(glmnet)
Auto2 <- Auto[,1:6]
#View(Auto2)
attach(Auto2)
mpg01 <- c()
for (i in 1:length(Auto2$mpg)) 
{
  if(Auto2$mpg[i]>=median(Auto2$mpg))
    Auto2$mpg01[i] <- 1
  else
    Auto2$mpg01[i] <- 0
  
}

train_set <- Auto2[1:196,]
test_set <- Auto2[197:392,]
glm_fit <-  glm(mpg01~displacement+horsepower+weight+acceleration,data=train_set,family = binomial)
summary(glm_fit)
glm_probs <- predict(glm_fit,test_set,type = "response")
glm_pred <- rep(0,196)
glm_pred[glm_probs>=.5] <- 1
print(paste0("logistic test error:",mean(glm_pred!=test_set$mpg01)))
