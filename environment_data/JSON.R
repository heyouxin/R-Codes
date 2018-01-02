library(rvest)
library(rjson)
#library(RCurl)

#url="http://tianqi.2345.com/t/wea_history/js/201612/60001_201612.js"
web<-read_html("http://tianqi.2345.com/t/wea_history/js/201612/60001_201612.js",encoding = "gb2312")
#data2<-getURL(url)
#data2


data <-web %>%   
  html_nodes (web,css="body")%>%
  html_text()
data




class(data)
parser <- newJSONParser()
parser$addData( data )
parser$getObject()
isValidJSON(data) 
json_data <- fromJSON(file="fin0.json")
json_data
getwd()
