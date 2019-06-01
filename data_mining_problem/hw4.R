library(leaps)
library(glmnet)
X <- rnorm(100)
e <- rnorm(100)
Y <- 1+X+X^2+X^3+e
gene_data <- data.frame(Y,X)

fit <- regsubsets(Y~1+poly(X,10),data = gene_data,nvmax = 10)
reg_summ <- summary(fit)

plot(reg_summ$adjr2,xlab = "number of variables",ylab="Adjusted RSq",type="l")
points(which.max(reg_summ$adjr2),reg_summ$adjr2[which.max(reg_summ$adjr2)],col="red",cex=2,pch=20)

plot(reg_summ$cp,xlab = "number of variables",ylab="Cp",type="l")
points(which.min(reg_summ$cp),reg_summ$cp[which.min(reg_summ$cp)],col="blue",cex=2,pch=20)

plot(reg_summ$bic,xlab = "number of variables",ylab="BIC",type="l")
points(which.min(reg_summ$bic),reg_summ$bic[which.min(reg_summ$bic)],col="green",cex=2,pch=20)

reg_fwd <- regsubsets(Y~1+poly(X,10),data=gene_data,nvmax = 10,method = "forward")
fwd_summ <- summary(reg_fwd)

plot(fwd_summ$adjr2,xlab = "number of variables",ylab="Adjusted RSq",type="l")
points(which.max(fwd_summ$adjr2),fwd_summ$adjr2[which.max(fwd_summ$adjr2)],col="red",cex=2,pch=20)

plot(fwd_summ$cp,xlab = "number of variables",ylab="Cp",type="l")
points(which.min(fwd_summ$cp),fwd_summ$cp[which.min(fwd_summ$cp)],col="blue",cex=2,pch=20)

plot(fwd_summ$bic,xlab = "number of variables",ylab="BIC",type="l")
points(which.min(fwd_summ$bic),fwd_summ$bic[which.min(fwd_summ$bic)],col="green",cex=2,pch=20)

reg_bwd <- regsubsets(Y~1+poly(X,10),data=gene_data,nvmax = 10,method = "backward")
bwd_summ <- summary(reg_bwd)

plot(bwd_summ$adjr2,xlab = "number of variables",ylab="Adjusted RSq",type="l")
points(which.max(bwd_summ$adjr2),bwd_summ$adjr2[which.max(bwd_summ$adjr2)],col="red",cex=2,pch=20)

plot(bwd_summ$cp,xlab = "number of variables",ylab="Cp",type="l")
points(which.min(bwd_summ$cp),bwd_summ$cp[which.min(bwd_summ$cp)],col="blue",cex=2,pch=20)

plot(bwd_summ$bic,xlab = "number of variables",ylab="BIC",type="l")
points(which.min(bwd_summ$bic),bwd_summ$bic[which.min(bwd_summ$bic)],col="green",cex=2,pch=20)

# train <- sample(100,50)
# lasso_mod <- glmnet(as.matrix(1+poly(gene_data$X[train],10)),gene_data$Y[train],alpha=1,lambda = grid)
# plot(lasso_mod)
