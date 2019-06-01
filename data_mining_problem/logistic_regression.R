data <- read.csv("C:/Users/heyouxin/Documents/PythonCodes/credit_rating/test-2.csv")
View(data)
data2 <- data[,-c(1,length(data))]
View(data2)
#logit_fit <- glm(data2$default~.)
logistreg <- paste0("default ~.",sep="")


do.call(data.frame,lapply(data2, function(x) replace(x, is.infinite(x),NA)))

data2[which(is.nan(data2))] = NA
data2[which(data2==Inf),] = NA
is.nan(data2)

is.infinite(data2)
model <- glm(logistreg,data=data2)
summary(model)

pred <- predict(model,data2)
prob <- 1 / (1+exp(-(pred)))
par(mfrow=c(2,1))
plot(pred,type="l")
plot(prob,type="l")

pred_default<- NULL
pred_default[prob> 0.5] <- 1
pred_default[prob<= 0.5] <- 0

library(caret)
result_com<- confusionMatrix(pred_default,data2$default)
result_com
