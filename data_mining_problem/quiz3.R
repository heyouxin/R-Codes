library(ISLR)
fuc_plot <- function(color="black",type='b',isplot=FALSE)
{
  rows <- nrow (Auto)    
  indexes <- sample (rows, 196, replace =FALSE)   
  Auto2 <- Auto [indexes, ]    
  mpg <- Auto2$mpg
  horsepower <-  Auto2$horsepower
  data <- data.frame(mpg,horsepower,horsepower^2,horsepower^3,horsepower^4,horsepower^5,horsepower^6,horsepower^7,horsepower^8,horsepower^9,horsepower^10)
  #View(data)
  formu <- "mpg~horsepower"
  MSE <- c()
  for (i in 1:10) 
  {
    if (i==1)
    {
      formu <- paste0(formu)
      
    }
    else
      formu <- paste0(formu,"+","horsepower.",i)
    fit <- lm(formu,data=data)
    MSE <- c(MSE,sum(residuals(fit)^2)/fit$df.residual)

    #print(summary(lm(formu,data=data)))
    
  }
  if(isplot==TRUE)
  { 
    plot(1:10,MSE,type = type,col=color,xlab = "ploy_num")
  }
  else
    lines(MSE,col=color)
 
}
fuc_plot(isplot = TRUE)
colors=c("green","red","blue","yellow")
for (i in 1:length(colors)) 
{
  if(i==1)
    fuc_plot(isplot = TRUE,type='l',color = colors[i])
  else
    fuc_plot(isplot = FALSE,type='l',color = colors[i])
}


