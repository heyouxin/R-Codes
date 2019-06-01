rm(list =ls() )
source("strategy_function.R")
library(WindR)
w.start()
#w.stop()
A_stock <- read.table("A_stock.txt",stringsAsFactors =  F)
A_stock <- as.character(A_stock)

stockID <- getBasicFinance(A_stock)

date_from <- "2017-12-01"
date_to <- "2018-01-02"
w_wset_data<-w.wset('tradesuspend','startdate=2017-12-01;enddate=2018-01-02')
stock_stop <- w_wset_data$Data[,'wind_code']
##去除停牌的股票
stockID <- setdiff(stockID,stock_stop)
stockID <- unique(stockID)

#length(stockID)
MACD_data <- data.frame()
DEA_data <- data.frame()
price_close <- data.frame()
for (i in 1:5) 
{
  HQ_temp <- getHQ(stockID[((i-1)*50+1):(i*50)],date_from,date_to)
  MACD_temp <- HQ_temp[[1]]
  DEA_temp <- HQ_temp[[2]]
  price_temp <- HQ_temp[[3]]
  if(i==1)
  {
    MACD_data <- MACD_temp
    DEA_data <- DEA_temp
    price_close <- price_temp
  }
  MACD_data <- cbind(MACD_data,MACD_temp)
  DEA_data <- cbind(DEA_data,DEA_temp)
  price_close <- cbind(price_close,price_temp)
  
}


HQ_temp <- getHQ(stockID[251:length(stockID)],date_from,date_to)
MACD_temp <- HQ_temp[[1]]
DEA_temp <- HQ_temp[[2]]
price_temp <- HQ_temp[[3]]

MACD_data <- cbind(MACD_data,MACD_temp)
DEA_data <- cbind(DEA_data,DEA_temp)
price_close <- cbind(price_close,price_temp)
  



stock_DEA <- upByDEA(DEA_data,price_close)




##找出需要卖出的股票

stock_long <- stock_DEA
MinHQ <- getMinHQ(stock_long)

MinHQ_2 <- unstack(MinHQ,close~windcode)
stock_short <- downByMinHQ(MinHQ_2)


