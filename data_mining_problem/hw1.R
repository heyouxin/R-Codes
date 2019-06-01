rm(list=ls())
set.seed(123)
X <- rnorm(100,0,1)
e <- rnorm(100,0,0.5)
length(Y)
Y <- -1+0.5*X+e
fit <- lm(Y~X)
summary(fit)
abline(fit)
plot(X,Y)
predict(fit)
X_2 <- X*X
fit2 <- lm(Y~X+X_2)
summary(fit2)
abline(fit, lwd=2, col="red")
abline(fit2,lwd=2,col="blue")

library(MASS)
par(mfrow=c(4,4))
cof <- c()
for (c in 2:ncol(Boston)) {
  Y <- Boston[,1]
  X <- Boston[,c]
  plot(X,Y,xlab=colnames(Boston)[c],ylab=colnames(Boston)[1])
  abline(lm(Y~X))
  fit_1 <- lm(Y~X)
  cof <- c(cof,fit_1$coefficients[2])
}
reg <- paste0("crim ~.",sep="")
fit <- lm(reg,data=Boston)
abline(fit)
summary(fit)
par(mfrow=c(4,4))
plot(cof,fit$coefficients[-1])

