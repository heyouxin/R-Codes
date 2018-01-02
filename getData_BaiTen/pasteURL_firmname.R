##firmname  URL 拼接， 存在数据框   直接操作EXCEL 不如转成CSV方便 各种问题
##读取excel的两种方式
##rm(list=ls())
library(openxlsx)
#library(readxl)
#library(openxlsx)  需要注意的是encoding='UTF-8' 否则会乱码
#library(xlsx)这个包的rJava需要64位JAVA支持
#library(xlsx)
first_url <- "http://so.baiten.cn/results?q=pd%253A%2528%255B2011%2520to%25202015%255D%2529%2520and%2520"
third_url <- "&type=14&s=0&law=2&v=l&page="
df <- read.xlsx("./files/firmname.xlsx",1,encoding='UTF-8')
#df <- read_excel("./files/firmname.xlsx",1,encoding='UTF-8')

firmname <- df$firmname
url <- paste0(first_url,"pa:(",firmname,")",third_url)
df_url_name <- data.frame(url,firmname)
write.xlsx(df_url_name,file="./files/url_firmname2.xlsx")

