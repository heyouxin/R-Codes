#1.
set.seed(123)
x <- rnorm(100,2,2)
e <- rnorm(100,0,1)
y <- 2+3*x+e
y_ <- 2+3*x
library(ggplot2)
plot1 <- plot(x,y)
reg <- lm(y~x)
reg$coefficients
summary(reg)
abline(lm(y~x), lwd=4, col="red")
abline(lm(y_~x),lwd=4,col="blue")


#2.
cof_1 <- c()
cof_2 <- c()
for (i in 1:1000) 
{
  x <- rnorm(100,2,2)
  e <- rnorm(100,0,1)
  y <- 2+3*x+e
  reg <- lm(y~x)
  
  cof_1 <- c(cof_1,reg$coefficients[1])
  cof_2 <- c(cof_2,reg$coefficients[2])
  
  
  
}
boxplot(cof_1)
boxplot(cof_2)
mean(cof_1)
mean(cof_2)
median(cof_1)
median(cof_2)