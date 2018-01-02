rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)
library(openxlsx)
library(splitstackshape)
city_id<-read.xlsx("city_id.xlsx")
url1<-"http://tianqi.2345.com/wea_history/"
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)
remDr$open()
##data_total所有城市的数据
data_total<-data.frame()

for (i in 23:23) 
{
  city<-city_id[i,1]
  id<-city_id[i,2]
  url<-paste0(url1,id,".htm")
  
  remDr$navigate(url)
  webElem <- remDr$findElement(using = 'css selector', ".prev")
  #webElem_RQ <- remDr$findElements(using = 'css selector', "td:nth-child(1)")
  #webElem_ZGQW <- remDr$findElements(using = 'css selector', "td:nth-child(2)")
  
    ##data_all每一个城市的所有数据
  data_all<-data.frame()
  data_pageAll<-data.frame()

  for (j in 1:10)
  {
    webElem_RQ <- remDr$findElement(using = 'css selector', "td:nth-child(1)")
    webElem_ZGQW <- remDr$findElement(using = 'css selector', "td:nth-child(2)")
    webElem_RQ2 <- remDr$findElements(using = 'css selector', "td:nth-child(1)")
    webElem_ZGQW2 <- remDr$findElements(using = 'css selector', "td:nth-child(2)")
    
    while(!as.logical(webElem_RQ$isElementDisplayed()))
    {
      Sys.sleep(1)
      webElem_RQ <- remDr$findElement(using = 'css selector', "td:nth-child(1)")
      webElem_ZGQW <- remDr$findElement(using = 'css selector', "td:nth-child(2)")
      webElem_RQ2 <- remDr$findElements(using = 'css selector', "td:nth-child(1)")
      webElem_ZGQW2 <- remDr$findElements(using = 'css selector', "td:nth-child(2)")
      
    }
    #Sys.sleep(1)
    #webElem_data <- NULL
    #webElem<- NULL
 
    #RQ <- unlist(webElem_RQ$getElementText())
    RQ <- unlist(lapply(webElem_RQ2, function(x){x$getElementText()}))
    
   #weather_tab > table:nth-child(1) > tbody:nth-child(3) > tr:nth-child(1) > td:nth-child(2)
    ZGQW<- unlist(lapply(webElem_ZGQW2, function(x){x$getElementText()}))
    
    data_page1<-data.frame(RQ,ZGQW)
    data_pageAll<-rbind(data_pageAll,data_page1)
    webElem$clickElement()
  } 
  
}
data_pageAll



    names(data_get3)<-c("日期","最高气温","最低气温","天气","风向风力","空气质量指数")
    data_get3<-cbind(data_get3,"城市"=city)
    data_all<-rbind(data_all,data_get3)
    #webElem <- remDr$findElement(using = 'css selector', ".prev")
    
    webElem$clickElement()
    
    #计算太快会连续点两次next page
    #Sys.sleep(2)
    
    
  }
  
  Sys.sleep(1)
  webElem_data <- remDr$findElements(using = 'css selector', "#weather_tab")
  data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
  data_get2<-strsplit(data_get,"\n")
  data_get3<-as.data.frame(data_get2)
  col_name<-names(data_get3)
  data_get3<-cSplit(data_get3,col_name," ")
  data_get3<-data_get3[-1,]
  #names(data_get3)<-c("日期","最高气温","最低气温","天气","风向风力","空气质量指数")
  data_get3<-cbind(data_get3,"城市"=city)
  data_all<-rbind(data_all,data_get3)
  data_total<-rbind(data_total,data_all)
  data_total2<-unique(data_total)
  
}
data_get
data_get2
data_get3
View(data_get3)
#as.Date("2017-02-18")-as.Date("2011-01-01")

#write.csv(data_total2,"weather_city_1_2.csv")
向 微风
分散性雷阵雨 夜间: 多云转晴
#city_id[23,2]
