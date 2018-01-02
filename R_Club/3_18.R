library(quantmod)
install(gcookbook)
###R 升级
# install.packages("installr"); 
# require(installr) #load / install+load installr
# updateR() 

library(ggplot2)
data("mtcars")
attach(mtcars)
plot(wt,mpg)
#pdf("./file/mypdf.pdf")

#hist(mtcars$mpg,breaks = )
ggplot(mtcars,aes(x=mpg))+geom_histogram(bins = 30)
?ggplot


dose <- c(20,30,40,45,60)
drugA <- c(16,20,27,40,60)
drugB <- c(15,18,25,31,40)
opar <- par(no.readonly = T)

par(lty=2,pch=17)
plot(dose,drugA,type="b")
par(opar)




