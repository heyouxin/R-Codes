rm(list=ls())
library(sqldf)
library(xlsx)
filename<-"7月销售总表 - 副本.xls"
XSZB<-read.xlsx(filename,sheetName = 1,encoding = "UTF-8")


getwd()


head(XSZB)
attach(XSZB)
sql1<-sqldf("select 商品全名,规格,sum(销售数量)  from XSZB group by 商品全名,规格")
View(sql1)

#write.csv(sql1,"销售总表-12月_2.csv",row.names = F)

names(sql1)<-c("商品全名","规格","销售总量")
write.xlsx(sql1,"7月销售总表.xlsx",row.names = F)

