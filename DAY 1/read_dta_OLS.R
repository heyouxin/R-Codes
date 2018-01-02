library(foreign)
mydataframe<-read.dta("attend.dta")
fit<-lm(attend~termGPA+priGPA,data=mydataframe)
summary(fit)
plot(mydataframe$attend,mydataframe$termGPA)

library(foreign)
mydataframe<-read.dta("attend.dta")
fit<-lm(attend~termGPA,data=mydataframe)
summary(fit)
plot(mydataframe$attend,mydataframe$termGPA)
abline(fit)

####
car_data <-read.csv("data.csv")
View(car_data)
index <- scale(car_data)
View(index)
mean_index <- apply(index,1,mean)
View(mean_index)

abline(mydataframe$attend,mydataframe$termGPA)
#plot(mydataframe$attend,)
#plot(mydataframe$attend,fit$)
#abline(fit)
#view(fit)
iris
lm(Sepal.Length~Sepal.Width+Petal.Width,data=iris)

#Data Analysis Using R: Exercise3  缺失数据用NA
Student<-c("John Davis","Angela Williams","Bullwinkle Moose","David Jones","Janice Markhammer","cheryl Cushing","Reuven Ytarhak","Greg Knox","Joel England","Mary Rayburn")
Math<-c(502,600,412,358,495,512,410,625,573,522)
Science<-c(95,99,80,82,75,85,80,95,89,86)
English<-c(25,22,18,15,20,28,15,30,27,18)
dataframe1<-data.frame(Student,Math,Science,English,stringsAsFactors = FALSE)
View(dataframe1)
options(digits = 3)
z <- scale(dataframe1[,2:4])
View(z)
total_score <- apply(z,1,mean)
#多加一个变量，同加一列
#dataframe1$total_score <- total_score
#cbind 多加一列 bind dataframe1+total_score rbind 多加一行
dataframe1 <- cbind(dataframe1,total_score)
y <- quantile(dataframe1$total_score,c(.8,.6,.4,.2))
dataframe1$grade[total_score >=y[1]] <-"A"
dataframe1$grade[total_score <y[1] & total_score>=y[2]] <-"B"
dataframe1$grade[total_score <y[2] & total_score>=y[3]] <-"C"
dataframe1$grade[total_score <y[3] & total_score>=y[4]] <-"D"
dataframe1$grade[total_score <y[4]] <-"E"
View(dataframe1)
#拆分姓名
name<-strsplit(dataframe1$Student," ")
firstname<-sapply(name, "[",1)
lastname<-sapply(name, "[",2)
#删除1，2，3列后拼接
dataframe1<-cbind(firstname,lastname,dataframe1[-c(1)])
dataframe1<-dataframe1[order(lastname,firstname),]




#dataframe2<-dataframe1[order(dataframe1$Student),]
#View(dataframe2)
#随机抽样
mysample<-dataframe2[sample(1:nrow(dataframe2),3,replace=FALSE),]
View(mysample)
#输出EXCEL row.names=T  the left order row      
#write.csv(dataframe1,"sample2.csv", row.names=F)

#import EXCEL
library(gdata)
mydataframe2<-read.xls("test1.xls",sheet=1)
View(mydataframe2)



library(RODBC)
channel<-odbcConnectExcel2007("test1.xlsx")
dataframe2<-sqlFetch(channel,"sample")
odbcClose(channel)
View(dataframe2)

library(xlsx)
workbook<-"test1.xlsx"
mydataframe2<-read.xlsx(workbook,1)

pdf("3.pdf")
attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title(main = "main title")
detach(mtcars)
dev.off()



pdf("4.pdf")
attach(mtcars)
#plot(wt,mpg)
fit<-lm(mpg~wt)
summary(fit)
#title(main = "main title")
detach(mtcars)
dev.off()


attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title(main = "main title")
detach(mtcars)

attach(mtcars)
mtcars
apply(mtcars, 1, mean)

mydata <- matrix(rnorm(12),nrow=3)
View(mydata)

plot(x^2,1,2)
 
#math function graph
func<-function(x) -exp(x)+exp(-x)
plot(func,0,10,main="aaa",sub="bbb")

title(main="111")
choose(25,4)/choose(30,4)
