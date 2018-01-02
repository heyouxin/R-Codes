##reference:
##20140507-国泰君安-数量化专题之四十二：寻找牛、熊股基本特征_基于财务、估值角度”
##按财务指标择股
getBasicFinance <- function(A_stock)
{
 
  ##2017年第一、二季度ROE均位于前50%  
  roe_2017_1 <- w.wsd(A_stock,"roe","2017-01-01","2017-3-31","Period=Q")$Data
  roe_2017_1 <- na.omit(roe_2017_1)
  roe_2017_1_50 <- roe_2017_1[roe_2017_1$ROE>quantile(na.omit(roe_2017_1$ROE),0.5),]
  
  roe_2017_2 <- w.wsd(A_stock,"roe","2017-04-01","2017-6-30","Period=Q")$Data
  roe_2017_2 <- na.omit(roe_2017_2)
  roe_2017_2_50 <- roe_2017_2[roe_2017_2$ROE>quantile(na.omit(roe_2017_2$ROE),0.5),]
  
  roe_50 <- merge(roe_2017_1_50,roe_2017_2_50,by="CODE")
 
  
  ##2017年第一、二季度pe均位于后50%且PE大于0 
  pe_2017_1 <- w.wsd(A_stock,"pe_ttm","2017-01-01","2017-3-31","Period=Q")$Data
  pe_2017_1 <- na.omit(pe_2017_1)
  pe_2017_1_50 <- pe_2017_1[(pe_2017_1$PE_TTM<quantile(pe_2017_1$PE_TTM,0.5))&(pe_2017_1$PE_TTM>0),]
  
  
  pe_2017_2 <- w.wsd(A_stock,"pe_ttm","2017-04-01","2017-6-30","Period=Q")$Data
  pe_2017_2 <- na.omit(pe_2017_2)
  pe_2017_2_50 <- pe_2017_2[(pe_2017_2$PE_TTM<quantile(pe_2017_2$PE_TTM,0.5))&(pe_2017_2$PE_TTM>0),]
  
  pe_50 <- merge(pe_2017_1_50,pe_2017_2_50,by="CODE")
  
  roe_pe <- merge(roe_50,pe_50,by="CODE")
  
  ##2017年第一、二季度净利润增长率均位于前50%  
  yoyprofit_2017_1 <- w.wsd(A_stock,"yoyprofit","2017-01-01","2017-3-31","Period=Q")$Data
  yoyprofit_2017_1 <- na.omit(yoyprofit_2017_1)
  yoyprofit_2017_1_50 <- yoyprofit_2017_1[yoyprofit_2017_1$YOYPROFIT>quantile(yoyprofit_2017_1$YOYPROFIT,0.5),]

  yoyprofit_2017_2 <- w.wsd(A_stock,"yoyprofit","2017-04-01","2017-6-30","Period=Q")$Data
  yoyprofit_2017_2 <- na.omit(yoyprofit_2017_2)
  yoyprofit_2017_2_50 <- yoyprofit_2017_2[yoyprofit_2017_2$YOYPROFIT>quantile(yoyprofit_2017_2$YOYPROFIT,0.5),]
  
  yoyprofit_50 <- merge(yoyprofit_2017_1_50,yoyprofit_2017_2_50,by="CODE")
  #View(yoyprofit_75) 
  roe_pe_yoyprofit <- merge(roe_pe,yoyprofit_50,by="CODE")
  #View(roe_pe)
  stockID <- roe_pe_yoyprofit[,1]  
  
  return (stockID)
  
  
}



##获得MACD,MDA,price的数据
getHQ <- function(stockID,date_from,date_to)
{
  w_wsd_data<-w.wsd(stockID,"MACD",date_from,date_to,"MACD_L=26;MACD_S=12;MACD_N=9;MACD_IO=3")
  MACD_data <- as.data.frame(w_wsd_data$Data)
  w_wsd_data<-w.wsd(stockID,"MACD",date_from,date_to,"MACD_L=26;MACD_S=12;MACD_N=9;MACD_IO=2;PriceAdj=F")
  DEA_data <- as.data.frame(w_wsd_data$Data)
  w_wsd_data<-w.wsd(stockID,"close",date_from,date_to,"PriceAdj=F")
  close_price <- as.data.frame(w_wsd_data$Data)
  HQ <- list(MACD_data,DEA_data,close_price)
  return (HQ)
}

##获得30分钟行情的分钟数据
getMinHQ <- function(stock_long,min=30)
{
  #date_from <- paste0(date_from," 09:00:00")
  #date_to <- paste0(date_to," 15:00:00")
  #w_wsi_data<-w.wsi(stock_long,close,date_from,date_to,"BarSize=30;PriceAdj=F")
  w_wsi_data<-w.wsi(stock_long,"close","2017-12-08 09:00:00","2017-12-13 15:00:00","BarSize=30")
  MinHQ_1 <- as.data.frame(w_wsi_data$Data)
 
  w_wsi_data<-w.wsi(stock_long,"close","2017-12-14 09:00:00","2017-12-17 16:32:52","BarSize=30")
  MinHQ_2 <- as.data.frame(w_wsi_data$Data)
  MinHQ <- rbind(MinHQ_1,MinHQ_2)
  return(MinHQ)
 
}

##part1:
##reference：国泰君安数量化专题之二十九：发现价格走势规律之基于MACD分段研究
##基于MACD的DEA指标判断是上涨阶段。需满足以下条件：
##1.当前交易日的DEA>0的点 A
##2.向左遍历得到一个DEA<0的点B
##3.在AB区间内 max_price(B_A)=price(A)
##4.从B点向左遍历，得到一个DEA>0的点C，且max_price(C_B)=price(C)
##5.点B定义为可疑的底部拐点
##6.若点B满足min_price(C_A)=price(B)
##7.点B为底部拐点

##part2:
##reference:国泰君安数量化专题之八十：基于MACD的价格分段研究3.0
##快速突破的情形
upByDEA <- function(DEA_data,price_close)
{
  t <- nrow(DEA_data)
  stock_DEA=c()
  stock_DEA1=c()
  stock_DEA2=c()
  for (c in 2:length(names(DEA_data))) 
  {
    if(DEA_data[t,c]>0)
    {
      for(r in (t-1):2)
      {
        if(DEA_data[r,c]<0 & price_close[t,c]==max(price_close[r:t,c]))
        {
          for (r_L in (r-1):1) 
          {
            if(DEA_data[r_L,c]>0 & price_close[r_L,c]==max(price_close[r_L:r,c]) & price_close[r,c]==min(price_close[r_L:t,c]))
            #if(DEA_data[r_L,c] & price_close[r_L,c]==max(price_close[r_L:r,c]) & price_close[r,c]==min(price_close[r_L:t,c]))
            {
              stock_DEA1 <- c(stock_DEA1,names(DEA_data)[c])
              #r的位置为底部点 返回满足条件的股票代码
              #print(names(DEA_data)[c])
            }
          }
        }
      }
    }
    ##快速突破
    else
    {
      for(r in (t-1):2)
      {
        if(DEA_data[r,c]<0 & price_close[t,c]==max(price_close[r:t,c]))
        {
          for (r_L in (r-1):1) 
          {
            if(DEA_data[r_L,c]>0 & price_close[r_L,c]==max(price_close[r_L:r,c]) & price_close[r,c]==min(price_close[r_L:t,c]) & price_close[t,c]==max(price_close[r_L:t,c]))
            {
              stock_DEA2 <- c(stock_DEA2,names(DEA_data)[c])
            }
          }
        }
      }
    }
     
    
  }
  stock_DEA1 <- unique(stock_DEA1)
  stock_DEA2 <- unique(stock_DEA2)
  stock_DEA <- unique(union(stock_DEA1,stock_DEA2))
  return(stock_DEA)
  #return(list(stock_DEA1,stock_DEA2))
}



##判断下跌的情况
downByDEA <- function(DEA_data,price_close)
{
  t <- nrow(DEA_data)
  stock_DEA=c()
  stock_DEA1=c()
  stock_DEA2=c()
  for (c in 2:length(names(DEA_data))) 
  {
    #c <- 2
    if(DEA_data[t,c]<0)
    {
      for(r in (t-1):2)
      {
        if(DEA_data[r,c]>0 & price_close[t,c]==min(price_close[r:t,c]))
        {
          for (r_L in (r-1):1) 
          {
            if(DEA_data[r_L,c]<0 & price_close[r_L,c]==min(price_close[r_L:r,c]) & price_close[r,c]==max(price_close[r_L:t,c]))
            #if(DEA_data[r_L,c] & price_close[r_L,c]==min(price_close[r_L:r,c]) & price_close[r,c]==max(price_close[r_L:t,c]))
            { 
              stock_DEA1 <- c(stock_DEA1,names(DEA_data)[c])
            }
          }
        }
      }
    }
    
    ##快速突破
    else
    {
      for(r in (t-1):2)
      {
        if(DEA_data[r,c]>0 & price_close[t,c]==min(price_close[r:t,c]))
        {
          for (r_L in (r-1):1) 
          {
            if(DEA_data[r_L,c]<0 & price_close[r_L,c]==min(price_close[r_L:r,c]) & price_close[r,c]==max(price_close[r_L:t,c]) & price_close[t,c]==min(price_close[r_L:t,c]))
            {
              stock_DEA2 <- c(stock_DEA2,names(DEA_data)[c])
            }
          }
        }
      }
    }
  
  }
  stock_DEA1 <- unique(stock_DEA1)
  stock_DEA2 <- unique(stock_DEA2)
  stock_DEA <- unique(union(stock_DEA1,stock_DEA2))
  return(stock_DEA)
  #return(list(stock_DEA1,stock_DEA2))
}



##用30分钟数据判断上涨的行情受到阻止、突破
##reference:国泰君安数量化专题之八十三:基于MACD价格分段的阻力与支撑研究
##这只是一种下跌的情况。不是充分条件！！！
downByMinHQ <- function(MinHQ)
{
  stock_sell <- c()
  for (n in 2:length(names(MinHQ))) 
  {
    d <- nrow(MinHQ)
    for (c in (d-1):3) 
    {
      if(MinHQ[c,n]==max(MinHQ[c:d,n]) & MinHQ[d,n]==min(MinHQ[c:d,n]))
      { 
        for (b in (c-1):2) 
        {
          if(MinHQ[b,n]==min(MinHQ[b:c,n]) & MinHQ[c,n]==max(MinHQ[b:c,n]) & MinHQ[b,n]>MinHQ[d,n])
          {
            for (a in (b-1):1) 
            {
              if(MinHQ[a,n]==max(MinHQ[1:d,n]) & MinHQ[a,n]>MinHQ[c,n])
              {
                stock_sell <- c(stock_sell,names(MinHQ)[n])
                stock_sell <- unique(stock_sell)
                return(stock_sell)
                
              }
              
            }
            
          }  
          
        }
      } 
    }
    
    
  }
}








####以下代码备用
##用DEA价格分段判断下跌阶段
downByDEA <- function(stockID)
{
  
  
  
  
}





##寻找向上突破均线的股票
getStockByBreakoutMA <- function(stockID,date_from,date_to)
{
  breakoutma_data <- w.wsd(stockID,"breakout_ma",date_from,date_to,"meanLine=60;n=3")$Data[,-1]
  stock_breakoutma <- breakoutma_data[,breakoutma_data[nrow(breakoutma_data),]==TRUE]
  return (names(stock_breakoutma))  
}
  



##按MACD指标择股
getStockByMACD <- function(MACD_data)
{
  ##case1 取最近5个交易日，前4个交易日MACD<0,最后一个交易日MACD>0
  group1 <- MACD_data[(nrow(MACD_data)-4):nrow(MACD_data),-1]
  stock1 <- c()
  for (i in 1:length(names(group1)))
  {
    group_temp <- group1[,names(group1)[i]]
    if(group_temp[1]<0 & group_temp[2]<0 & group_temp[3]<0 & group_temp[4]<0 & group_temp[5]>0)
    {
      stock1 <- c(stock1,names(group1)[i])
    }  
  }
  #View(stock1)
  
  

  ##case2 最近5个交易日MACD均小于0，进入备选股票池
  stock_option <- c()
  for (i in 1:length(names(group1)))
  {
    group_temp <- group1[,names(group1)[i]]
    if(group_temp[1]<0 & group_temp[2]<0 & group_temp[3]<0 & group_temp[4]<0 & group_temp[5]<0)
    {
      stock_option <- c(stock_option,names(group1)[i])
    }  
  }
  #View(stock_option)

  ##case3 最近两个交易日 MACD>0 且 MACD<1
  group2 <- MACD_data[(nrow(MACD_data)-1):nrow(MACD_data),-1]
  stock2 <- c()
  for (i in 1:length(names(group2)))
  {
    group_temp <- group2[,names(group2)[i]]
    if(group_temp[1]>0 & group_temp[2]>0 & group_temp[1]<0.3 & group_temp[2]<0.3)
    {
      stock2 <- c(stock2,names(group2)[i])
    }  
  }
  #View(stock2)
  

  
  stock_portfolio <- union(stock1,stock2)
  return (stock_portfolio) 
   
}



buyTimeByMinMACD <- function(stock_portfolio)
{
  
  
  
}




