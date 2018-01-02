####Sample
library(data.table)
# data_zl <- read.table("data_zl.txt")
# head(data_zl)
# data_zl2<-as.data.table(data_zl)
# data_ch<-as.character(data_zl2$V1)
#View(data_ch)
con <- file("data_zl.txt", "r")
data_zl <- readLines(con,n=-1)
data_ch<-data_zl



# ####想用data.table加速  test
# data_zl2<-as.data.table(data_zl)
# class(data_zl2)
# View(data_zl2)
# data_ch2<-as.character(data_zl2$V1)
# data_get2<-grep("<公开（公告）号>=.*",data_ch2)
# GKH___ <- data_zl2[data_get2]
# View(GKH___)
# 
# ####


####查找满足条件的行
data_get<-grep("<公开（公告）号>=.*",data_ch)
GKH <- data_ch[data_get]
head(GKH)
####删除<  >=之间的所有字符
GKH2 <- gsub("<.*?>=","",GKH)
head(GKH2)

 
# ####删除特定字符 >=
# GKH2 <- gsub(">=","",GKH)
# head(GKH2)
# ####



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

# data_get<-grep("<主权项>=.*",data_ch)
# ZQX <- data_ch[data_get]
# ZQX2 <- gsub("<.*?>=","",ZQX)
# 
# 
# data_get<-grep("<优先权>=.*",data_ch)
# YXQ <- data_ch[data_get]
# YXQ2 <- gsub("<.*?>=","",YXQ)
# 
# 
# data_get<-grep("<同族专利项>=.*",data_ch)
# TZZLX <- data_ch[data_get]
# TZZLX2 <- gsub("<.*?>=","",TZZLX)
# 
# 
# data_get<-grep("<国省代码>=.*",data_ch)
# GSDM <- data_ch[data_get]
# GSDM2 <- gsub("<.*?>=","",GSDM)
# 
# 
# data_get<-grep("<分案原申请号>=.*",data_ch)
# FAYSQH <- data_ch[data_get]
# FAYSQH2 <- gsub("<.*?>=","",FAYSQH)
# 
# data_get<-grep("<地址>=.*",data_ch)
# DZ <- data_ch[data_get]
# DZ2 <- gsub("<.*?>=","",DZ)
# 
# 
# 
# 
# data_get<-grep("<专利代理机构>=.*",data_ch)
# ZLDLJG <- data_ch[data_get]
# ZLDLJG2 <- gsub("<.*?>=","",ZLDLJG)
# 
# data_get<-grep("<代理人>=.*",data_ch)
# ZY <- data_ch[data_get]
# ZY2 <- gsub("<.*?>=","",ZY)
# 
# data_get<-grep("<审查员>=.*",data_ch)
# ZQX <- data_ch[data_get]
# ZQX2 <- gsub("<.*?>=","",ZQX)
# 
# 
# data_get<-grep("<颁证日>=.*",data_ch)
# YXQ <- data_ch[data_get]
# YXQ2 <- gsub("<.*?>=","",YXQ)
# 
# 
# data_get<-grep("<国际申请>=.*",data_ch)
# TZZLX <- data_ch[data_get]
# TZZLX2 <- gsub("<.*?>=","",TZZLX)
# 
# 
# data_get<-grep("<国际公布>=.*",data_ch)
# GSDM <- data_ch[data_get]
# GSDM2 <- gsub("<.*?>=","",GSDM)
# 
# 
# data_get<-grep("<进入国家日期>=.*",data_ch)
# FAYSQH <- data_ch[data_get]
# FAYSQH2 <- gsub("<.*?>=","",FAYSQH)
# 
# data_get<-grep("<摘要附图存储路径>=.*",data_ch)
# DZ <- data_ch[data_get]
# DZ2 <- gsub("<.*?>=","",DZ)







excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"专利号"=ZLH2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2)
View(excel_data)
# library(openxlsx)
# library(xlsx)
write.csv(excel_data,"excel_data.csv")











#excel_data
COL<-c(GKH,GKR)
excel_data2<-gsub("<.*?>=","",COL)
head(excel_data2)
GKH
GKR
library(stringr)
a<-"<公开（公告）日>=1231321312"
str_replace_all(a,"\\<(.*?)\\=","")

data_get<-gsub("\\<.*?\\=","","<公开（公告）日>=1231321312")
data_get



data_excel<-data.table(GKH,GKR)
View(data_excel)




data.table()
data_ch1<-sub("<公开（公告）号>=","",data_ch)
data_ch1
data_zl2 <- read.delim2("data_zl.txt")
View(data_zl2)
data_zl2 <-as.character(data_zl2$)
head(data_zl2)
