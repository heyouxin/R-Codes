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



###循环次数与年份、月份对照表 j year  month
year_mon<-read.xlsx("j_year_month.xlsx",colNames = F)
#View(year_mon)
#for (i in 308:368)
for (i in 307:307)
{
  city<-city_id[i,1]
  id<-city_id[i,2]
  url<-paste0(url1,id,".htm")
  
  remDr$navigate(url)
  #webElem_data <- remDr$findElements(using = 'css selector', "#weather_tab")
  webElem <- remDr$findElement(using = 'css selector', ".prev")
  webElem2 <- remDr$findElement(using = 'css selector', ".next")
  ##data_all每一个城市的所有数据
  data_all<-data.frame()
  #for (j in 1:73)
  for (j in 1:63)
  {

    
    flag<-T
    #Sys.sleep(0.5)
    webElem_data <- remDr$findElements(using = 'css selector', "#weather_tab")
    #Sys.sleep(0.5)
    #data_get<-unlist(webElem_data$getElementText())
    #data_get<-unlist(webElem_data$getElementText())
    data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
    #webElem_data<-NULL
    data_get2<-strsplit(data_get,"\n")
    
    ####这里可以考虑stringr的包 str_split 
    
    year_get<-substr(data_get2[[1]][2],1,4)
    mon_get<-substr(data_get2[[1]][2],6,7)
    flag<-!((year_get==year_mon[j,1])&&(mon_get==year_mon[j,2]))
    while(flag)
    {
      webElem <- remDr$findElement(using = 'css selector', ".prev")
      webElem2 <- remDr$findElement(using = 'css selector', ".next")
      
      webElem2$clickElement()
      Sys.sleep(3)
      webElem$clickElement()

      webElem_data <- remDr$findElements(using = 'css selector', "#weather_tab")
      #Sys.sleep(0.5)
      #data_get<-unlist(webElem_data$getElementText())
      #data_get<-unlist(webElem_data$getElementText())
      data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
      #webElem_data<-NULL
      data_get2<-strsplit(data_get,"\n")
      year_get<-substr(data_get2[[1]][2],1,4)
      mon_get<-substr(data_get2[[1]][2],6,7)
      flag<-!((year_get==year_mon[j,1])&&(mon_get==year_mon[j,2]))


    }
    
    data_get3<-as.data.frame(data_get2)
    col_name<-names(data_get3)
    data_get3<-cSplit(data_get3,col_name," ")
    data_get3<-data_get3[-1,]
    data_get3<-data_get3[,1:6]
    names(data_get3)<-c("日期","最高气温","最低气温","天气","风向风力","空气质量指数")
    data_get3<-cbind(data_get3,"城市"=city)
    data_all<-rbind(data_all,data_get3)

  
      
    webElem <- remDr$findElement(using = 'css selector', ".prev")
    webElem$clickElement()
    #Sys.sleep(1)
    #计算太快会连续点两次next page
    Sys.sleep(2)

    
  }

  Sys.sleep(1)
  webElem_data <- remDr$findElements(using = 'css selector', "#weather_tab")
  #data_get<-unlist(webElem_data$getElementText())
  data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
  data_get2<-strsplit(data_get,"\n")
  data_get3<-as.data.frame(data_get2)
  col_name<-names(data_get3)
  data_get3<-cSplit(data_get3,col_name," ")
  data_get3<-data_get3[-1,]
  data_get3<-data_get3[,1:6]
  names(data_get3)<-c("日期","最高气温","最低气温","天气","风向风力","空气质量指数")
  data_get3<-cbind(data_get3,"城市"=city)
  data_all<-rbind(data_all,data_get3)
  data_total<-rbind(data_total,data_all)
  
  data_total2<-unique(data_total)
  
}


#as.Date("2017-02-18")-as.Date("2011-01-01")

#write.csv(data_total2,"weather_city_307.csv")

#city_id[308,1]

