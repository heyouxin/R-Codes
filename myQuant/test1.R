
library(e1071)
library(xlsx)

## 读文件，确定自变量和因变量
View(dataTrain)
dataTrain2 <- read.zoo("./data/HS300_3.csv",sep=",",header=T,format = "%Y-%m-%d")
dataTrain <- na.omit(dataTrain2)
# fit <- lm(p_change~open+high+close+low+volume+ma5+ma10+ma20+v_ma5+v_ma10+v_ma20,data=dataTrain)
# summary(fit)
# dataTrain[dataTrain$p_change>=1,]$token <- 2
# dataTrain[dataTrain$p_change<1 & dataTrain$p_change>0,]$token <- 1
# dataTrain[dataTrain$p_change>-1 & dataTrain$p_change<=0,]$token <- -1
# dataTrain[dataTrain$p_change<=-1,]$token <- -2
#write.csv(dataTrain,"HS300_3.csv")
#dataTrain <- dataTrain[,-c(2,7,8)]
dataTrain <- dataTrain[,-c(6)]
#View(dataTrain)
#nrow(dataTrain)
dataTrain <- dataTrain[,-1]
x <- dataTrain[,-c(13,14)]
y <- dataTrain[,13]
View(y)

## 计算SVM在2种分类机，4种核函数下模型的错误次数

type <- c("C-classification","nu-classification")
kernel <- c("linear","polynomial","radial","sigmoid")
accuracy <- matrix(0,2,4)
for (i in 1:2)
{
  for ( j in 1:4) 
  {
    model <- svm(x,y,type=type[i],kernel = kernel[j])
    pred_temp <- predict(model,x)
    accuracy[i,j] <- sum(pred_temp!=as.vector(y))
  }
}
dimnames(accuracy) <- list(type,kernel)
accuracy

train_start<- "2015-07-31"
train_end<- "2017-01-31"
test_start<- "2017-01-01"
test_end<- "2017-12-31"
inrow <- which(index(dataTrain) >= train_start & index(dataTrain) <= train_end)
outrow <- which(index(dataTrain) >= test_start & index(dataTrain) <= test_end)


## 由以上结果可知，使用SVM进行实验，type="C-classification",kernel = "radial"的模型最优。
## 实验1用训练数据的前2666条作为训练集，后200条作为测试集，看看预测结果

#model1 <- svm(x[201:2699,],y[201:2699],type="C-classification",kernel = "polynomial")
model1 <- svm(x[inrow,],y[inrow],type="nu-classification",kernel = "radial")

pred1 <- predict(model1,x[outrow,])
#pred1[190:200]

#y[190:200]
table(pred1,y[outrow])

head(pred1)


## 实验3使用全部训练样本展示预测结果，并与真实情况的比较。
model_fitted <- svm(x,y,type="nu-classification",kernel = "radial")
summary(model_fitted)
pred <- predict(model_fitted,x)

table(pred,y)

simreturn <- x$p_change



signal <- ifelse( pred1[outrow]==1 | pred1[outrow]==2,1,ifelse(pred1[outrow]==-2 ,-1,0))
simreturn <- simreturn[outrow]
cost <- 0
strategy_return <- simreturn*Lag(signal)-cost
library(PerformanceAnalytics)
cumm_return<- Return.cumulative(strategy_return)
annual_return <- Return.annualized(strategy_return)
charts.PerformanceSummary(strategy_return)



