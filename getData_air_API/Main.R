###rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)
 remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                       , browserName = "chrome"
 )

remDr$open()
remDr$navigate("http://datacenter.mep.gov.cn:8099/ths-report/report!list.action?xmlname=1463473852790")
data_all<-data.frame()
library(splitstackshape)


for (i in 1:5)
{
  webElem_data <- remDr$findElements(using = 'css selector', "#tablehtml")
  data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
  data_get2<-strsplit(data_get,"\n")
  data_get3<-as.data.frame(data_get2)
  col_name<-names(data_get3)
  data_get3<-cSplit(data_get3,col_name," ")
  data_get3<-data_get3[-1,]
  names(data_get3)<-c("城市","日期","污染指数","首要污染物","空气质量级别","空气状况")
  data_all<-rbind(data_all,data_get3)
  webElem <- remDr$findElement(using = 'css selector', "a:nth-child(13)")  
  webElem$clickElement()

}


for (j in 6:12697)
{
  webElem_data <- remDr$findElements(using = 'css selector', "#tablehtml")
  data_get <- unlist(lapply(webElem_data, function(x){x$getElementText()}))
  data_get2<-strsplit(data_get,"\n")
  data_get3<-as.data.frame(data_get2)
  col_name<-names(data_get3)
  data_get3<-cSplit(data_get3,col_name," ")
  data_get3<-data_get3[-1,]
  names(data_get3)<-c("城市","日期","污染指数","首要污染物","空气质量级别","空气状况")
  data_all<-rbind(data_all,data_get3)
  webElem <- remDr$findElement(using = 'css selector', "a:nth-child(14)")  
  webElem$clickElement()
  
}

write.csv(data_all,"air_API.csv")






