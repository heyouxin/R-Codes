rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)

options(stringsAsFactors=F)

remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)

remDr$open()
remDr$navigate("http://k.tanjiaoyi.com/#")
#Sys.sleep(10)

df_total <- data.frame()
for (i in 1:515)
{
  df1 <- data.frame()
  webElem_data <- remDr$findElements(using = 'css selector', ".datagrid-btable")
  data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
  data_get2<-strsplit(data_get,"\n")
  #data_get3<-as.data.frame(data_get2[[1]])
  for (j in 1:20) 
  {
    df1 <- rbind(df1,as.vector(data_get2[[1]][((j-1)*10+1):(j*10)]))
    
  }
  names(df1)<-c("交易所","交易类型","交易日期","开盘价(元)","最高价(元)","最低价(元)","成交价(元)","收盘价(元)","交易额(元)","交易量(吨)")
  df_total <- rbind(df_total,df1)
  # col_name<-names(data_get3)
  # data_get3<-cSplit(data_get3,col_name," ")
  # data_get3<-data_get3[-1,]
  # names(data_get3)<-c("城市","日期","污染指数","首要污染物","空气质量级别","空气状况")
  # data_all<-rbind(data_all,data_get3)
  webElem <- remDr$findElement(using = 'css selector', "#gridDiv > div > div > div.datagrid-pager.pagination > table > tbody > tr > td:nth-child(10) > a > span")  
  webElem$clickElement()
  Sys.sleep(1)
  
}

write.csv(df_total,"data.csv")
