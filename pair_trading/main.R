library(xlsx)
library(xts)
library(urca)
hs300_weights <- read.xlsx("./files/hs300_weights_2016.xls",1,encoding = "UTF-8")
#View(hs300_weights)
bank_pos<-grep(".*银行",hs300_weights$成分股名称_CompoStkNm)
stock_bank <- hs300_weights[bank_pos,]

stock_price <- read.xlsx("./files/QTTN_2016__C30BBEF8B0F_(2).xls",1,encoding = "UTF-8")
stock_price_1 <- stock_price[stock_price$日期_Date<"2017-01-01",]

#在2016年中，找出相关系数最高的两个股票  华夏银行 中信银行 0.89
result <- tapply(stock_price_1$收盘价.元._ClPr, list(stock_price_1$日期_Date, stock_price_1$最新股票名称_LStkNm), FUN=sum)
#View(result)
cor_table <- cor(result)
#which.max(na.omit(cor_table[cor_table<1]))
#View(cor_table)


result <- as.data.frame(result)
result <- as.xts(result)
#View(result)

result[,c(6,20)]
# library(PairTrading)
# .libPaths("C:/Program Files/R/R-3.3.3/library")
# .libPaths()
?PairTrading

#留下华夏银行、中信银行的时间序列
stock_price <- tapply(stock_price$收盘价.元._ClPr, list(stock_price$日期_Date, stock_price$最新股票名称_LStkNm), FUN=sum)
stock_price <- as.data.frame(stock_price)
stock_price <- as.xts(stock_price)
stock_price_HX_ZX <- stock_price[,c(6,20)]
View(stock_price_HX_ZX)

#形成期协整检验
formStart <- "2016-01-01"
formEnd <- "2016-12-31"
formPeriod <- paste(formStart,"::",formEnd,sep="")
stock_price_HX_ZX[formPeriod]

stock_price_HX <- stock_price_HX_ZX[formPeriod,1]
stock_price_ZX <- stock_price_HX_ZX[formPeriod,2]



log_HX <- log(stock_price_HX)
#summary(ur.df(log_HX))
log_ZX <- log(stock_price_ZX)

plot(log_HX,ylim=c(1,3),type="l",main="对数价格时序图")
points(log_ZX,col="red",pch=20)
legend("topright",legend = c("华厦银行","中信银行"),col = c("red","black"),pch=c(20,NA_integer_),lty=c(0,1))

plot.zoo(merge(log_HX,log_ZX),ylim=c(1,3),col = c("black","blue"),main="对数价格时序图")
class(log_HX)
reg <- lm(log_HX~log_ZX)
summary(reg)
alpha <- coef(reg)[1]
beta <- coef(reg)[2]
spreadf <- log_HX-beta*log_ZX-alpha
UnitRootf <- ur.df(spreadf,type="none")
summary(UnitRootf)
mu <- mean(spreadf)
sd <- sd(spreadf)

tradeStart <- "2017-01-01"
tradeEnd <- "2017-06-30"
tradePeriod <- paste(tradeStart,"::",tradeEnd,sep="")
price_HX_trade <- stock_price_HX_ZX[tradePeriod,1]
price_ZX_trade <- stock_price_HX_ZX[tradePeriod,2]

CoSpreadT <- log(price_HX_trade)-beta*log(price_ZX_trade)-alpha
names(CoSpreadT) <- "CoSpreadT"
summary(CoSpreadT)
CoSpreadT <- as.zoo(CoSpreadT)

plot(1:10,family="STKaiti",main="中文") 
#绘制价差区间图
#library(ggplot2)
plot(CoSpreadT,ylim=c(-0.20,0.20),main="交易期价差序列（协整配对)")
abline(h=mu,col="black",lwd=1)
abline(h=c(mu+0.2*sd,mu-0.2*sd),col="blue",lty=6,lwd=2)
abline(h=c(mu+1*sd,mu-1*sd),col="green",lty=2,lwd=2.5)
abline(h=c(mu+2*sd,mu-2*sd),col="red",lty=3,lwd=3)

#构造价差区间
level <- c(mu-2*sd,mu-1*sd,mu-0.2*sd,mu+0.2*sd,mu+1*sd,mu+2*sd)
interval <- function(x,level)
{
  prcLevel <- cut(x,breaks=c(-Inf,level,Inf))
  prcLevel <- as.numeric(prcLevel)-4
}
prcLevel <- interval(CoSpreadT,level)

#构造交易信号函数
TradeSig <- function(prcLevel)
{
  n <- length(prcLevel)
  signal <- rep(0,n)
  for(i in(2:n))
  {
    
    
    if(prcLevel[i-1]==1 & prcLevel[i]==2)
      signal[i] <- -2
    
    if(prcLevel[i-1]==1 & prcLevel[i]==0)
      signal[i] <- 2
    

    #开仓信号  A多   B空
    if(prcLevel[i-1]==-1 & prcLevel[i]==-2)
      signal[i] <- 1
    
    #平仓信号
    if(prcLevel[i-1]==-1 & prcLevel[i]==0)
      signal[i] <- -1

    
    #止损信号
    if(prcLevel[i-1]==2 & prcLevel[i]==3)
      signal[i] <- 3
        
    if(prcLevel[i-1]>=-2 & prcLevel[i]==-3)
      signal[i] <- -3
    
    
    
    
  }
  return (signal)
}


signal <- TradeSig(prcLevel)
position <- c()
position[1] <- signal[1]
ns <- length(signal)
for (i in 2:ns) 
{
  position[i] <- position[i-1]
  
  if(signal[i]==1)
    position[i]=1
  
  
  if(signal[i]==-1)
    position[i]=-1
  
  
  if(signal[i]==-1 & position[i-1]==0)
    position[i]=0
  
  
  if(position[i-1]==1 & signal[i]==-1)
    position[i]=0
  
  if(position[i-1]==-1 & signal[i]==2)
    position[i]=0
  
  if(signal[i]==3)
    position[i]=0
  
  if(signal[i]==-3)
    position[i]=0
  
}



position <- c()
position[1] <- 0
ns <- length(prcLevel)
for (i in 2:ns) 
{
  position[i] <- position[i-1]
  
  #正向开仓
  if(position[i]==0 & prcLevel[i]<=-2)
    position[i]=1
  
  #反向开仓
  if(position[i]==0 & prcLevel[i]>=2)
    position[i]=-1
  
  #平仓信号
  if(position[i]==1 & prcLevel[i]==0)
    position[i]=0
  
  if(position[i]==1 & prcLevel[i]==-3)
    position[i]=0
  
  
  if(position[i]==-1 & prcLevel[i]==0)
    position[i]=0
  
  if(position[i]==-1 & prcLevel[i]==3)
    position[i]=0
  
  
 
  
}


position <- xts(position,order.by = index(CoSpreadT))

#tail(position)


TradeSim <- function(PriceA,PriceB,Position)
{
  

  
  Position2 <- Position
  n <- length(Position)
  PriceA <- as.numeric(PriceA)
  PriceB <- as.numeric(PriceB)
  Position <- as.numeric(Position)
  size <- 100
  #shareA[1] <- 0 
  shareB <- c()
  shareA <- size*Position
  shareB[1] <- (-beta)*shareA[1]*PriceA[1]/PriceB[1]
  cash <- c()
  cash[1] <- 10000
  for (i in 2:n) 
  {
    #shareA[i] <- shareA[i-1]
    shareB[i] <- shareB[i-1]
    cash[i] <- cash[i-1]
    if(Position[i-1]==0 & Position[i]==1)
    {
      
      shareB[i] <- (-beta)*shareA[i]*PriceA[i]/PriceB[i]
      cash[i] <- cash[i-1]-(shareA[i]*PriceA[i]+shareB[i]*PriceB[i])
    }
    if(Position[i-1]==0 & Position[i]==-1)
    {
      
      shareB[i] <- (-beta)*shareA[i]*PriceA[i]/PriceB[i]
      cash[i] <- cash[i-1]-(shareA[i]*PriceA[i]+shareB[i]*PriceB[i])
    }
    
    if(Position[i-1]==1 & Position[i]==0)
    {
      shareB[i] <- 0
      cash[i] <- cash[i-1]+(shareA[i-1]*PriceA[i]+shareB[i-1]*PriceB[i])
    }
    
    if(Position[i-1]==-1 & Position[i]==0)
    {
      shareB[i] <- 0
      cash[i] <- cash[i-1]+(shareA[i-1]*PriceA[i]+shareB[i-1]*PriceB[i])
    }
    

    
  }
  
  cash <- xts(cash,order.by = index(Position2))
  shareA <- xts(shareA,order.by=index(Position2))
  shareB <- xts(shareB,order.by=index(Position2))
  
  #length(asset)
  asset <- cash+shareA*PriceA+shareB*PriceB
  #account <- cbind(Position,shareA)
  #View(account)
  account <- cbind(Position,shareA,shareB,cash,asset)
  colnames(account) <- c("Position","shareA","shareB","cash","asset")
  return(account)
  
}

account <- TradeSim(price_HX_trade,price_ZX_trade,position)
