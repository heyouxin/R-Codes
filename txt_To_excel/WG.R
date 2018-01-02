#rm(data_ch)

library(data.table)
con <- file("WG2011-2016_2.txt", "r")
data_ch <- readLines(con,n=-1,encoding = "UTF-8")
close(con)
head(data_ch)



####查找满足条件的行
data_get<-grep("<公开（公告）号>=.*",data_ch)
GKH <- data_ch[data_get]

####删除<  >=之间的所有字符
GKH2 <- gsub("<.*?>=","",GKH)





data_get<-grep("<公开（公告）日>=.*",data_ch)
GKR <- data_ch[data_get]
GKR2 <- gsub("<.*?>=","",GKR)

data_get<-grep("<申请号>=.*",data_ch)
SQH <- data_ch[data_get]
SQH2 <- gsub("<.*?>=","",SQH)

data_get<-grep("<申请日>=.*",data_ch)
SQR <- data_ch[data_get]
SQR2 <- gsub("<.*?>=","",SQR)


data_get<-grep("<专利号>=.*",data_ch)
ZLH <- data_ch[data_get]
ZLH2 <- gsub("<.*?>=","",ZLH)



#####-------
data_get<-grep("<名称>=.*",data_ch)
MC <- data_ch[data_get]
MC2 <- gsub("<.*?>=","",MC)


data_get<-grep("<主分类号>=.*",data_ch)
ZFLH <- data_ch[data_get]
ZFLH2 <- gsub("<.*?>=","",ZFLH)


data_get<-grep("<分类号>=.*",data_ch)
FLH <- data_ch[data_get]
FLH2 <- gsub("<.*?>=","",FLH)


data_get<-grep("<申请（专利权）人>=.*",data_ch)
SQZLR <- data_ch[data_get]
SQZLR2 <- gsub("<.*?>=","",SQZLR)


data_get<-grep("<发明（设计）人>=.*",data_ch)
FMR <- data_ch[data_get]
FMR2 <- gsub("<.*?>=","",FMR)

data_get<-grep("<摘要>=.*",data_ch)
ZY <- data_ch[data_get]
ZY2 <- gsub("<.*?>=","",ZY)

 
data_get<-grep("<国省代码>=.*",data_ch)
GSDM <- data_ch[data_get]
GSDM2 <- gsub("<.*?>=","",GSDM)
# 

data_get<-grep("<地址>=.*",data_ch)
DZ <- data_ch[data_get]
DZ2 <- gsub("<.*?>=","",DZ)
# 
data_get<-grep("<专利代理机构>=.*",data_ch)
ZLDLJG <- data_ch[data_get]
ZLDLJG2 <- gsub("<.*?>=","",ZLDLJG)
# 
data_get<-grep("<代理人>=.*",data_ch)
DLR <- data_ch[data_get]
DLR2 <- gsub("<.*?>=","",DLR)
# 
data_get<-grep("<发布路径>=.*",data_ch)
FBLJ <- data_ch[data_get]
FBLJ2 <- gsub("<.*?>=","",FBLJ)
# 
data_get<-grep("<页数>=.*",data_ch)
YS <- data_ch[data_get]
YS2 <- gsub("<.*?>=","",YS)
# 
data_get<-grep("<申请国代码>=.*",data_ch)
SQGDM <- data_ch[data_get]
SQGDM2 <- gsub("<.*?>=","",SQGDM)
# 
data_get<-grep("<专利类型>=.*",data_ch)
ZLLX <- data_ch[data_get]
ZLLX2 <- gsub("<.*?>=","",ZLLX)
# 
data_get<-grep("<申请来源>=.*",data_ch)
SQLY <- data_ch[data_get]
SQLY2 <- gsub("<.*?>=","",SQLY)
# 







excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"专利号"=ZLH2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"国省代码"=GSDM2,"地址"=DZ2,"专利代理机构"=ZLDLJG2,"代理人"=DLR2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
#View(excel_data)
write.csv(excel_data,"WG2011-2016_2.csv")