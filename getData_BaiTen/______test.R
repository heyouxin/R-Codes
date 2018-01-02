devtools::install_github("ropensci/RSelenium")
devtools::install_github("ropensci/RSelenium")
vignette('RSelenium-basics')
library(RSelenium)
RSelenium::startServer()
# RSelenium::startServer() if required
#require(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)
remDr$open()
#remDr$getStatus()
url <- "http://so.baiten.cn/results?q=pd%253A%2528%255B2011%2520to%25202015%255D%2529%2520and%2520pa%253A%2528%25u5965%25u7EF4%25u901A%25u4FE1%25u80A1%25u4EFD%25u6709%25u9650%25u516C%25u53F8%2529&type=14&s=0&law=2&v=l&page="
remDr$navigate("http://so.baiten.cn/results?q=pd%253A%2528%255B2011%2520to%25202015%255D%2529%2520and%2520pa%253A%2528%25u5965%25u7EF4%25u901A%25u4FE1%25u80A1%25u4EFD%25u6709%25u9650%25u516C%25u53F8%2529&type=14&s=0&law=2&v=l&page=")
webElem_totalcount <- remDr$findElements(using = 'css selector', "#sop-totalCount")
totalCount <- unlist(lapply(webElem_totalcount, function(x){x$getElementText()}))
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
webElem <- remDr$findElement(using = 'css selector', "#srl-m-vc > div.slTabBox > table > tbody > tr.lm-l-list > th.w120.tc > span")
webElem$clickElement()
webElem2 <- remDr$findElement(using = 'css selector', "body > div.field-Dialog > div > div.fl.w162.unInitFieldBox > ul > li:nth-child(7) > span")
webElem2$clickElement()
webElem3 <- remDr$findElement(using = 'css selector', "body > div.field-Dialog > span.field-save")
webElem3$clickElement()
webElem_SQH <- remDr$findElements(using = 'css selector', "td:nth-child(2) > a:nth-child(1)")
SQH <- unlist(lapply(webElem_SQH, function(x){x$getElementText()}))
webElem_SXRQ <- remDr$findElements(using = 'css selector', "td:nth-child(6) > span:nth-child(2)")
SXRQ <- unlist(lapply(webElem_SXRQ, function(x){x$getElementText()}))
data_get <- data.frame(SQH,SXRQ)

if(i_page>1)
{
  for (i in 2:i_page)
  {
    link_url <- paste0(url,i)
    remDr$navigate(link_url)
    webElem_SQH <- remDr$findElements(using = 'css selector', "td:nth-child(2) > a:nth-child(1)")
    SQH <- unlist(lapply(webElem_SQH, function(x){x$getElementText()}))
    webElem_SXRQ <- remDr$findElements(using = 'css selector', "td:nth-child(6) > span:nth-child(2)")
    SXRQ <- unlist(lapply(webElem_SXRQ, function(x){x$getElementText()}))
    data_get <- rbind(data_get,data.frame(SQH,SXRQ))
  }

}

return (data_get)


#remDr$navigate("http://www.baidu.com")

#处理翻页
#if(remDr$findElement(using = 'css selector', "#srl-m-vc > div.paging.f14 > div > a:nth-child(5)"))
#{
  
#}
#remDr$navigate("http://www.google.com/ncr")
#webElem <- remDr$findElement(using = 'id', value = "gbqfq")
