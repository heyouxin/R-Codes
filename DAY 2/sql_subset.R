#使用SQL语句
library(sqldf)
attach(mtcars)
newdf<-sqldf("select * from mtcars where carb=1 order by mpg",row.names=T)
View(newdf)
detach(mtcars)


View(mtcars)
mtcars

#使用subset筛选子集
attach(mtcars)
newdata <- subset(mtcars,mpg<20)
detach(mtcars)
View(newdata)


for(i in 1:10)
  print("hello")

i<-10
while (i>0) {
  print("hello world !")
  i<-i*3-4
  break
  

}


#graph
barplot(anscombe$x1)
m1<-matrix(anscombe)
barplot(m1)

library(vcd)
Arthritis
counts<-table(Arthritis$Improved)
barplot(counts,xlab = "Improved",ylab = "Frequency")

summary(mtcars)
sapply(mtcars$mpg, mean)


vars<-c("mpg","hp","wt")
head(mtcars[vars])
mtcars[vars]
aggregate(mtcars[vars],by=list(am=mtcars$am),mean)


women
fit<-lm(weight~height,data=women)
#summary(fit)
#data<-data.frame(fit$fitted.values,fit$residuals)
#View(data)
#plot(women$height,women$weight)
library(ggplot2)
qplot(women$height,women$weight)
abline(fit)
fit$fitted.values
fit$residuals

fit2<-lm(weight~height+I(height^2),data = women)
plot(women$height,women$weight)
lines(women$height,fitted(fit2))
#两种取拟合值的方法 相当于stata里的predict u    predict e,residual
fitted(fit2)
fit2$fitted.values
#newdata<-data.frame(10,100)
#predict(fit2,newdata,interval = "confidence")



#cor()取相关系数
state.x77
options(digits = 2)
cor(state.x77)

library(foreign)
mydataframe<-read.dta("attend.dta")
cor(mydataframe$attend,mydataframe$termGPA)


fit<-lm(mpg~hp+wt+hp:wt,data = mtcars)
summary(fit)



#sqldf update   delete  数据增删改查全部转到SQLDF上
library(sqldf)
data_cars<-data.frame(mtcars)
sql1<-sqldf(c("update data_cars set am='1' where am='0'","delete from data_cars  where vs='0'","select * from data_cars"),row.names=T)
#sql2<-sqldf("select * from data_cars",row.names=T)
View(sql1)

library(sqldf)
data_cars<-data.frame(mtcars)
sql1<-sqldf(c("delete from data_cars  where am='0'","select * from data_cars"),row.names=T)
#sql2<-sqldf("select * from data_cars",row.names=T)
View(sql1)




#按条件筛选 删除
library(dplyr)
data_cars<-data.frame(mtcars)
data_cars2<-filter(data_cars,am!='1')
View(data_cars2)





