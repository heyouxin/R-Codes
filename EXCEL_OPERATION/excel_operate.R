#library(openxlsx)
library(sqldf)
library(xlsx)
filename<-"3月.xlsx"
XSZB<-read.xlsx(filename,sheetName = 3,encoding = "UTF-8")



head(XSZB)
attach(XSZB)
sql1<-sqldf("select 单位全名,商品全名,规格,销售单价,产地,基本单位,sum(销售数量) from XSZB group by 单位全名,商品全名,规格,销售单价,产地,基本单位")
View(sql1)

#write.csv(sql1,"销售总表-12月_2.csv",row.names = F)
names(sql1)<-c("单位全名","商品全名","规格","销售单价","产地","基本单位","销售总量")
write.xlsx(sql1,"表2.xlsx",row.names = F)

