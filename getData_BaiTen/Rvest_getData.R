###rm(list=ls())
openHtml <- function(url)
{
  url2 <- GET(url, add_headers('user-agent' = 'r'))
  web <- read_html(url2,encoding="UTF-8")
  totalCount <- web %>%   
    html_nodes("#sop-totalCount") %>%
    html_text()
  if(round(as.numeric(totalCount)/10)==as.numeric(totalCount)/10)
  {
    i_page <- as.numeric(totalCount)/10
  }
  else
  {
    i_page <- round(as.numeric(totalCount)/10)+1
  }
  #错误用法用作测试翻页 第二个URL 刚好10条
  #i_page <- round(as.numeric(totalCount)/10)+1
  i_page 
  SQH <- web %>%   
    html_nodes("td:nth-child(2) > a:nth-child(1)") %>%
    html_text()
  SQH
  SXRQ <-web %>%   
    #html_nodes("td:nth-child(6) > span:nth-child(2)") %>%
    #主分类号用作测试 
    html_nodes("td:nth-child(5) > a:nth-child(1)")%>%
    html_text()
  SXRQ
  data_get <- data.frame(SQH,SXRQ)
  if(i_page>1)
  {
    for (i in 2:i_page)
    {
      link_url <- paste0(url,i)
      link_url2 <- GET(link_url, add_headers('user-agent' = 'r'))
      web2 <- read_html(link_url2)
      SQH2 <- web2 %>%   
        html_nodes("td:nth-child(2) > a:nth-child(1)") %>%
        html_text()
      SQH2
      SXRQ2 <-web2 %>%   
        #html_nodes("td:nth-child(6) > span:nth-child(2)") %>%
        #主分号类用作测试
        html_nodes("td:nth-child(5) > a:nth-child(1)")%>%
        html_text()
      SXRQ2
      data_get <- rbind(data_get,data.frame(SQH,SQH2))
    }
  }
  
  return (data_get)
  
}


library(httr)
library(rvest)
url_data <- read.table("url.csv",header = T)
site <- as.character(url_data$url)
#class(site)
#length(site)
data <- data.frame()
for(i in 1:2)
{
  #data <- openHtml(site[i])
  data <- rbind(data,openHtml(site[i]))
 
}
write.csv(data,file = "firms.csv")



