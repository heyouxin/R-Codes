library(e1071)
library(xlsx)

dataTrain <- read.table("./竞赛实验数据2017/kddtrain2017.txt")
x <- dataTrain[,-101]
y <- dataTrain[,101]
wts <- as.vector(cor(x,y)/sum(cor(x,y)))
name_wts <- as.vector(paste0("V",1:100))

names(wts) <- name_wts
#nrow(dataTrain)
#summary(dataTrain)
type=c("C-classification","nu-classification")
kernel=c("linear","polynomial","radial","sigmoid")
accuracy=matrix(0,2,4)
for (i in 1:2)
{
  for ( j in 1:4) 
  {
    model <- svm(x,y,type=type[i],kernel = kernel[j])
    pred_temp=predict(model,x)
    accuracy[i,j]=sum(pred_temp!=y)
  }
}
dimnames(accuracy)=list(type,kernel)
accuracy
model_fitted <- svm(x[1:5000,],y[1:5000],type="C-classification",kernel = "polynomial")

model_fitted <- svm(x,y,class.weights = wts)


pred <- predict(model_fitted,x)
table(pred,y)
dataTest <- read.table("./竞赛实验数据2017/kddtest2017.txt")
pred_test=predict(model_fitted,dataTest)
write.xlsx(pred_test,"predict_result.xlsx",col.names = F,row.names = F)
