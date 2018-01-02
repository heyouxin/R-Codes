library(ggplot2)
norm_distribution<-function(num)
{
  rnorm(num,0,1)
}

chisq_distribution<-function(num)
{
  rchisq(num,12)
}

inverse_chisq_distribution<-function(num)
{
  1/(rchisq(num,12))
}

cauchy_distribution<-function(num)
{
  rcauchy(num)
}

x_bar_plot<-function(func)
{
  n<-seq(100,1000,100)
  set.seed(123)
  x<-sapply(n, func)
  x_bar<-sapply(x, mean)
  print(paste0("x_bar=",mean(x_bar)))
  q<-qplot(n,x_bar)
  q+scale_x_continuous(breaks = n)
}

x_bar_plot(norm_distribution)
mean(x_bar)
x_bar_plot(chisq_distribution)
x_bar_plot(inverse_chisq_distribution)
x_bar_plot(cauchy_distribution)
####conclusion:
#1.the bigger n is ,the closer x_bar moves to 0.00;  x_bar distributes N(0,1) mean(x_bar)=0
#2.mean(x_bar)=12
#3.mean(x_bar)=0.1
#4.mean(x_bar)
####


1/12

n<-seq(100,1000,100)
set.seed(123)
x<-sapply(n, function (y) {rnorm(y,0,1)})
x_bar<-sapply(x, mean)
q<-qplot(n,x_bar)
q+scale_x_continuous(breaks = seq(100,1000,100))

s<-function(y)
{
  mean(y)
}
s(1:10)
