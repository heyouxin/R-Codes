#library(openxlsx)
library(sqldf)
library(xlsx)
filename<-"3月.xlsx"
XSZB<-read.xlsx(filename,sheetName = 2,encoding = "UTF-8")



head(XSZB)
attach(XSZB)
sql1<-sqldf("select 商品全名,规格,sum(销售数量) from XSZB group by 商品全名,规格")
View(sql1)

#write.csv(sql1,"销售总表-12月_2.csv",row.names = F)
names(sql1)<-c("商品全名","规格","销售总量")
write.xlsx(sql1,"表1.xlsx",row.names = F)

