####法律状态分为两部分搞，1部分是共有的4条记录，另一部分是申请号+授权公告号,做一次LEFT_JOIN
####申请号不是唯一的，不能这样做。

#rm(data_ch)
library(data.table)
con <- file("FLZT_2008-2016_1.txt", "r")
data_ch <- readLines(con,n=-1,encoding = "UTF-8")
close(con)
head(data_ch)


data_get<-grep("<申请号>=.*",data_ch)
SQH <- data_ch[data_get]
SQH2 <- gsub("<.*?>=","",SQH)

data_get<-grep("<法律状态公告日>=.*",data_ch)
FLZTGGR <- data_ch[data_get]
FLZTGGR2 <- gsub("<.*?>=","",FLZTGGR)


data_get<-grep("<法律状态>=.*",data_ch)
FLZT <- data_ch[data_get]
FLZT2 <- gsub("<.*?>=","",FLZT)



data_get<-grep("<法律状态信息>=.*",data_ch)
FLZTXX <- data_ch[data_get]
FLZTXX2 <- gsub("<.*?>=","",FLZTXX)





excel_data1 <- data.table("申请号"=SQH2,"法律状态公告日"=FLZTGGR2,"法律状态"=FLZT2,"法律状态信息"=FLZTXX2)
#View(excel_data)
write.csv(excel_data,"FLZT_2008-2016_1_part1.csv")

data_get<-grep("<授权公告号>=.*",data_ch)
SQGGH <- data_ch[data_get]
SQGGH2 <- gsub("<.*?>=","",SQGGH)

excel_data2 <- data.table("申请号"=SQH2,"授权公告号"=SQGGH2)
write.csv(excel_data,"FLZT_2008-2016_1_part2.csv")


