library(ggplot2)
fit2<- lm(weight~height+I(height^2),data = women)
summary(fit2)
plot(fit2)
qplot(fit2)

states<-as.data.frame(state.x77[,c("")])
#相关系
cor(states)

library(car)

#hp:wt 交互项
fit<-lm(mpg~hp+wt+hp:wt,data=mtcars)
plot(fit)