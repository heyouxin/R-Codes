library(InformationValue)
library(plyr)
library(smbinning)
data <- read.csv("test_data.csv")
data <- data[,-1]
##R包里 负例是0，正例是1  ！！！
data$isdefault <- 1
data[data$default==1,'isdefault'] <- 0
IV(X=as.factor(data[,"industry_name"]),Y=as.factor(data[,"isdefault"]))
WOETable(X=as.factor(data[,"industry_name"]),Y=as.factor(data[,"isdefault"]))
