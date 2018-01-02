library(caret)
library(e1071)
library(xlsx)
library(PerformanceAnalytics)
library("quantmod")
library("zoo")
## 读文件，确定自变量和因变量
data_sample <- read.zoo("./data/HS300_5.csv",sep=",",header=T,format = "%Y-%m-%d")
#dataTrain <- read.csv("./data/HS300_2.csv")
data_sample <- na.omit(data_sample)
#ret <-Delt(data_sample$close)
#write.csv(data_sample,"./data/HS300_5.csv")
#View(data_sample)
#x <- data_sample[,-c(4:21)]
x <- data_sample[,c(1,3,19,23)]
View(x)
y <- data_sample[,20]
fit <- lm(ret~open+close+high+low+volume+mv10+mv20+vol10+vol20+rsi5+rsi14+macd.macd1+signal.macd1+macd.macd2+signal.macd2+dn+mavg+up+pctB+ret_cur+ret_lag1+ret_lag2,data = data_sample)
summary(fit)



View(x)


insams<- "2005-01-01"
insame<- "2016-12-31"
osams<- "2017-01-01"
osame<- "2017-12-31"
inrow <- which(index(data_sample) >= insams & index(data_sample) <= insame)
outrow <- which(index(data_sample) >= osams & index(data_sample) <= osame)


## 计算SVM在2种分类机，4种核函数下模型的错误次数
type <- c("C-classification","nu-classification")
kernel <- c("linear","polynomial","radial","sigmoid")
accuracy <- matrix(0,2,4)
for (i in 1:2)
{
  for ( j in 1:4) 
  {
    model <- svm(x[inrow,],y[inrow],type=type[i],kernel = kernel[j])
    pred_temp <- predict(model,x[outrow])
    accuracy[i,j] <- sum(pred_temp!=as.vector(y[outrow]))
  }
}
dimnames(accuracy) <- list(type,kernel)
accuracy


## 由以上结果可知，使用SVM进行分类，type="nu-classification",kernel = "radial"的模型最优。
model1 <- svm(x[inrow,],y[inrow],type="C-classification",kernel = "polynomial")
pred1 <- predict(model1,x[outrow,])
#table(pred1,y[outrow])
outresult_out<- confusionMatrix(pred1,y[outrow])
outresult_out



# Performance
signal <- ifelse( pred1==1 | pred1==2,1,ifelse(pred1==-2 ,-1,0))
simreturn <- data_sample$ret[outrow]
cost <- 0
strategy_return <- Lag(simreturn)*Lag(signal)-cost
cumm_return<- Return.cumulative(strategy_return)
annual_return <- Return.annualized(strategy_return)
charts.PerformanceSummary(strategy_return)

