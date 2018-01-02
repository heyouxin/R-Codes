rm(list = ls())
library("quantmod")
library("zoo")
#hs <- read.zoo("./data/hs300_dir.csv",sep=",",header=T,format = "%Y-%m-%d")
hs <- read.zoo("./data/HS300.csv",sep=",",header=T,format = "%Y-%m-%d")
hsp <- hs$cp

#对zoo数据的滚动处理rollapply
mv10<- rollapply(hsp,10,mean,align = c("right"))
mv20<- rollapply(hsp,20,mean,align = c("right"))
vol10<- rollapply(hsp,10,sd,align = c("right"))
vol20<- rollapply(hsp,20,sd,align = c("right"))
#相对强弱指数	RSI
rsi5<- RSI(hsp,5,"SMA")
rsi14<- RSI(hsp,14,"SMA")

macd1<- MACD(hsp,12,26,9,"SMA")
macd2<- MACD(hsp,7,20,5,"SMA")
bbands<- BBands(as.matrix(hsp),20,"SMA",2)


# create variable direction with either Up direction or Down direction
direction<- NULL
direction[hsp> Lag(hsp,1)] <- 1
direction[hsp< Lag(hsp,1)] <- 0
#head(Lag(hsp,1))
# direction[((hsp-Lag(hsp,1))/Lag(hsp,1))>=0.01] <- 2
# direction[((hsp-Lag(hsp,1))/Lag(hsp,1))<=-0.01] <- -2
# direction[((hsp- Lag(hsp,1))/Lag(hsp,1))> -0.01 & ((hsp- Lag(hsp,1))/Lag(hsp,1))<0] <- -1
# direction[((hsp- Lag(hsp,1))/Lag(hsp,1))< 0.01 & ((hsp- Lag(hsp,1))/Lag(hsp,1))>=0] <- 1


# bind all columns consisting of price and indicator
hsp <- 
  cbind(hsp,mv10,mv20,vol10,vol20,rsi5,rsi14,macd1,macd2,bbands,direction)

#View(hsp)
dm <- dim(hsp)

colnames(hsp)[dm[2]] <- "Direction"
colnames(hsp)[dm[2]]


hsp <- read.zoo("./data/hsp_lag.csv",sep=",",header=T,format = "%Y-%m-%d")

View(hsp)
# in sample data and the second part is out of sample data

insams<- "2007-01-01"
insame<- "2016-12-31"
osams<- "2017-01-01"
osame<- "2017-12-31"
inrow <- which(index(hsp) >= insams & index(hsp) <= insame)
outrow <- which(index(hsp) >= osams & index(hsp) <= osame)

inhsp <- hsp[inrow,]
outhsp <- hsp[outrow,]

# standardizing the dataset
inme <- apply(inhsp,2,mean)
instd <- apply(inhsp,2,sd)

inidn <- matrix(1,dim(inhsp)[1],dim(inhsp)[2])
norm_inhsp <- (inhsp-t(inme*t(inidn))) / t(instd*t(inidn))

dm <- dim(inhsp)
norm_inhsp[,dm[2]] <- direction[inrow]

# build a logistic regression model to predict market direction

logistreg <- paste("Direction ~ .",sep="")
model <- glm(logistreg,family="binomial",norm_inhsp)

summary(model)
pred <- predict(model,norm_inhsp)
prob <- 1 / (1+exp(-(pred)))
par(mfrow=c(2,1))
plot(pred,type="l")
plot(prob,type="l")

pred_direction<- NULL
pred_direction[prob> 0.5] <- 1
pred_direction[prob<= 0.5] <- 0

# # confusionMatrix gives a matrix as an output.
# 
library(caret)
result_com<- confusionMatrix(pred_direction,norm_inhsp$Direction)
result_com

outidn<- matrix(1,dim(outhsp)[1],dim(outhsp)[2])
norm_outhsp<- (outhsp - t(inme*t(outidn))) / t(instd*t(outidn))
norm_outhsp[,dm[2]] <- direction[outrow]

outpred<- predict(model,norm_outhsp)
outprob<- 1 / (1+exp(-(outpred)))

outpred_direction<- NULL
outpred_direction[outprob> 0.5] <- 1
outpred_direction[outprob<= 0.5] <- 0
outresult_com<- confusionMatrix(outpred_direction,norm_outhsp$Direction)
outresult_com

#View(hsp)
#library(xlsx)
#write.csv(hsp,"./data/hsp.csv",row.names = F)

# Performance
simreturn <- Delt(hs$cp)
signal <- ifelse(outpred_direction ==1,1,ifelse(outpred_direction==-1,-1,0))


simreturn <- simreturn[outrow]
cost <- 0
strategy_return <- simreturn*Lag(signal)-cost
library(PerformanceAnalytics)
cumm_return<- Return.cumulative(strategy_return)
annual_return <- Return.annualized(strategy_return)
charts.PerformanceSummary(strategy_return)
