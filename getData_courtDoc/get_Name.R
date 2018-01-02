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
openHtml <- function(url)
  
{
  data_get <- data.frame()
  remDr$navigate(url)
  # firmname <- name[x]
  # remDr$navigate(site[x])
  #totalCount
  #class(totalCount)
  # webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
  # totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
  
  #  webElem_title <- remDr$findElements(using = 'css selector', "div:nth-child(1) > a:nth-child(3)")
  #title <- unlist(lapply(webElem_title, function(x){x$getElementText()}))
  
  # webElem_URR <- remDr$
  webElems_title <- remDr$findElements(using = 'css selector', "div.wstitle")
  resHeaders <- unlist(lapply(webElems_title, function(x){x$getElementText()}))
  #doc_url <- unlist(lapply(webElems, function(x){x$getElementAttribute("href")}))
  print(resHeaders)
  #webElems <- remDr$findElements(value = "//tbody//tr//td//div//a")  
  webElems_url <- remDr$findElements(using = 'css selector', "td:nth-child(1) > div:nth-child(1) > a:nth-child(3)")
  doc_url <- unlist(lapply(webElems_url, function(x){x$getElementAttribute("href")}))
  print(doc_url)
  remDr$navigate(doc_url[1])
  webElems_no <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'（201')]")
  doc_no <- unlist(lapply(webElems_no, function(x){x$getElementText()}))
  print(doc_no)
  return (data_get)
  
  
}





site <- "http://wenshu.court.gov.cn/content/content?DocID=2c3a31eb-2bc1-407d-a969-ca65e945b342"
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)
remDr$open()
#tryCatch(remDr$navigate(site))
remDr$navigate(site)
data_get <- data.frame()
##审判长 审判员 代理审判员  书记员 书记员（兼） 人民陪审员 代理书记员
webElems_no <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'（201')]")
no <- unlist(lapply(webElems_no, function(x){x$getElementText()}))
# webElems_SPZ <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'审　判　长')]")
# SPZ <- unlist(lapply(webElems_SPZ, function(x){x$getElementText()}))
# webElems_SPY <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'审　判　员')]")
# SPY <- unlist(lapply(webElems_SPY, function(x){x$getElementText()}))
webElems_DLSPY <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'代理审判员')]")
DLSPY <- unlist(lapply(webElems_DLSPY, function(x){x$getElementText()}))
webElems_SJY <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'书　记　员')]")
SJY <- unlist(lapply(webElems_SJY, function(x){x$getElementText()}))
webElems_RMPSY <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'书　记　员')]")
RMPSY <- unlist(lapply(webElems_RMPSY, function(x){x$getElementText()}))
webElems_DLSJY <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'代理书记员')]")
DLSJY <- unlist(lapply(webElems_DLSJY, function(x){x$getElementText()}))
webElems_SJYJ <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'书记员（兼')]")
SJYJ <- unlist(lapply(webElems_SJYJ, function(x){x$getElementText()}))
# 
# webElems_S_P_Z <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'审    判　  长')]")
# S_P_Z <- unlist(lapply(webElems_S_P_Z, function(x){x$getElementText()}))
# webElems_S_P_Y <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'审  　判  　员')]")
# S_P_Y <- unlist(lapply(webElems_S_P_Y, function(x){x$getElementText()}))

webElems_S_P <- remDr$findElements(using = 'xpath',"//*[starts-with(text(),'审　')]")
S_P <- unlist(lapply(webElems_S_P, function(x){x$getElementText()}))
#

DLSPY<-paste(DLSPY,collapse = " ")
# SPZ<-paste(SPZ,collapse = " ")
# SPY<-paste(SPY,collapse = " ")
S_P <-paste(S_P,collapse = " ")
SJY<-paste(SJY,collapse = " ")
RMPSY<-paste(RMPSY,collapse = " ")
SJYJ<-paste(SJYJ,collapse = " ")
DLSJY<-paste(DLSJY,collapse = " ")
# S_P_Z<-paste(S_P_Z,collapse = " ")
# D_P_Y<-paste(D_P_Y,collapse = " ")
# if(is.null(SPY))
# {
#   SPY <- NA
# }
# if(is.null(SPZ))
# {
#   SPZ <- NA
# }
# if(is.null(DLSPY))
# {
#   DLSPY <- NA
# }
# if(is.null(SJY))
# {
#   SJY <- NA
# }
# if(is.null(RMPSY))
# {
#   RMSPY <- NA
# }
# if(is.null(DLSJY))
# {
#   DLSJY <- NA
# }
# if(is.null(SJYJ))
# {
#   SJYJ <- NA
# }
SPZ
SPY
DLSPY
SJY
RMPSY
DLSJY
SJYJ


#data_get  <- data.frame(SPZ,SPY,DLSPY,SJY,RMPSY,DLSJY,SJYJ)
data_get  <- data.frame(S_P,DLSPY,SJY,RMPSY,DLSJY,SJYJ)

data_get
View(data_get)
