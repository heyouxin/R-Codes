####################################
# project name: Baiten_getData by RSelenium
# author: hyx
# date:2016.12.1-2016.12.3
# key words: web scrapy js R  rvest RSelenium
# version: v1.0.0
# ####################################
# Questions&next version:
# ####Q1: R里的初始化  data_get <- data.frame() ？？
# ####Q2: R里的多线程  R里不能做多线程，只有并行计算，只能用多进程代替，开多个RStudio
# ####Q3：RSelenium包里navigate函数访问网页timeout 原代码获得？重写？chapter1
# ####Q4: R里的断点、调试？
# ####Q5: firefox(version 36?) browse how to do it? firefox version problem 
# ####并行计算机library(parallel)
# ####源代码 remoteDriver.R errorHandler.R  queryRD =    
# ####引入tryCatch()
# ####remoteDriver
######################################
  


###rm(list=ls())
###ctrl+shift+c段落注释


library(httr)
library(rvest)
library(RSelenium)
 
#读取第二次以后的所有页面及分页
openHtml <- function(url,firmname)
# openHtml <- function(x)
{
  # url_data <- read.csv("url_firmname.csv",header = T)
  # #View(url_data)
  # site <- as.character(url_data$url)
  # name <- url_data$firmname
  
  
  #data_get初始化
  data_get <- data.frame()
  remDr$navigate(url)
  # firmname <- name[x]
  # remDr$navigate(site[x])
  #totalCount
  #class(totalCount)
  webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
  totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
  while(is.null(totalCount))
  {
    webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
    totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
    #remDr$refresh()
    webElem4 <- remDr$findElement(using = 'css selector', "#srl-sb-submit")
    webElem4$clickElement()
    webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
    totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
    
  }
  #totalCount
  #class(totalCount)


  if(round(as.numeric(totalCount)/10)==as.numeric(totalCount)/10)
  {
    i_page <- as.numeric(totalCount)/10
  }
  else
  {
    i_page <- round(as.numeric(totalCount)/10)+1
  }
  webElem_SQH <- remDr$findElements(using = 'css selector', "td:nth-child(2) > a:nth-child(1)")
  SQH <- unlist(lapply(webElem_SQH, function(x){x$getElementText()}))
  webElem_SXRQ <- remDr$findElements(using = 'css selector', "td:nth-child(6) > span:nth-child(2)")
  SXRQ <- unlist(lapply(webElem_SXRQ, function(x){x$getElementText()}))
  data_get <- rbind(data_get,data.frame(SQH,SXRQ,firmname))
  ##!!!!!! the page more than 1 exist the bug
  ##BUG may be in here  next page can be like this  
  if(i_page>1)
  {
    for (i in 2:i_page)
    {

      link_url <- paste0(url,i)
####navigate()这个函数没法处理timeout
      ##??navigate
      remDr$navigate(link_url)
      webElem_SQH2 <- remDr$findElements(using = 'css selector', "td:nth-child(2) > a:nth-child(1)")
      SQH <- unlist(lapply(webElem_SQH2, function(x){x$getElementText()}))
      webElem_SXRQ2 <- remDr$findElements(using = 'css selector', "td:nth-child(6) > span:nth-child(2)")
      SXRQ <- unlist(lapply(webElem_SXRQ2, function(x){x$getElementText()}))
      data_get <- rbind(data_get,data.frame(SQH,SXRQ,firmname))
    }
    
  }
  
  return (data_get)
  
  
}

##自动启动服务，会有BUG，尽量用外部命运符启动  auto start server
#startServer()
#selServ$stop()
#rm(totalCount)
#rm(url_data)

#library(RSelenium)
url_data <- data.frame()
#url_data <- read.table("url.csv",header = T)
url_data <- read.csv("./files/url_firmname.csv",header = T)
#View(url_data)
site <- as.character(url_data$url)
name <- url_data$firmname
#head(name)
# RSelenium::startServer() if required
#require(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)
##??remDr <- remoteDriver$new()??##
remDr$open()

#Encoding(site[1]) <- "bytes"

####第一次访问只执行操作，不读取数据,用了保存cookie

remDr$navigate(site[1])

####这里不需要获得页数，用作测试。
#webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
#totalCount <- lapply(webElem_totalcount, function(x){x$getElementText()})
#class(totalCount)
#totalCount
#totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
#class(webElem_totalcount$getElementText())
 


#### first html click action
webElem <- remDr$findElement(using = 'css selector', "#srl-m-vc > div.slTabBox > table > tbody > tr.lm-l-list > th.w120.tc > span")
webElem$clickElement()
webElem2 <- remDr$findElement(using = 'css selector', "body > div.field-Dialog > div > div.fl.w162.unInitFieldBox > ul > li:nth-child(7) > span")
webElem2$clickElement()
webElem3 <- remDr$findElement(using = 'css selector', "body > div.field-Dialog > span.field-save")
webElem3$clickElement()

#webElem_SQH <- remDr$findElements(using = 'css selector', "td:nth-child(2) > a:nth-child(1)")
#SQH <- unlist(lapply(webElem_SQH, function(x){x$getElementText()}))
#webElem_SXRQ <- remDr$findElements(using = 'css selector', "td:nth-child(6) > span:nth-child(2)")
#SXRQ <- unlist(lapply(webElem_SXRQ, function(x){x$getElementText()}))
#data_get <- data.frame(SQH,SXRQ)

#####初始化
data <- data.frame()
#class(site)
#length(site)

for(i in 1:4)
#for(i in 5:6)
{
  #data <- openHtml(site[i])
  data <- rbind(data,openHtml(site[i],name[i]))

}
# library(parallel)
# x <- 1:4
# cl <- makeCluster(4) # 初始化四核心集群
# results <- parLapply(cl,x,openHtml) # lapply的并行版本
# data <- do.call('rbind',results) # 整合结果
# stopCluster(cl) # 关闭集群


write.csv(data,file = "./files/SQH_SXRQ_GSM.csv")
data