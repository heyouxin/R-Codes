dataTrain <- read.table("./竞赛实验数据2017/kddtrain2017.txt")
head(dataTrain)
y=as.character(dataTrain[,101])
typeof(y)

View(dataTrain)
library(e1071)
model1=svm(dataTrain[,-101],dataTrain[,101],type="one-classification")
model2=svm(dataTrain[,-101],dataTrain[,101],type="C-classification",kernel = "polynomial")

model1 <- svm(x[1:6000,],y[1:6000],type="C-classification",kernel = "polynomial")
pred1 <- predict(model1,x[6001:6270,])
table(pred1,y[6001:6270])

a <- c(0,1,0)
b <- c(1,0,0)
table(a,b)

table(pred,y)

summary(model1)

nrow(dataTrain)

pred1=predict(model1,dataTrain[,-101])
pred2=predict(model2,dataTrain[,-101])


head(pred)

table(pred2,y)


