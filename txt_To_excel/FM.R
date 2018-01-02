#rm(list = ls())
library(data.table)
con <- file("FM2011-2016_1.txt", "r")
data_ch <- readLines(con,n=-1,encoding = "UTF-8")
close(con)
head(data_ch)


#data_zl <- read.DIF("FM2011-2016_1.txt")
#data_zl <- fread("data_zl.txt",sep="\r")
#con <- file("FM2011-2016_1.txt", "r")
# con <- file("data_zl.txt", "r")
# data_zl <- readLines(con,n=-1)
# data_ch <- data_zl
# head(data_zl)
# View(data_zl)
# data_zl2<-as.data.table(data_zl)
# data_ch<-as.character(data_zl2$V1)
#View(data_ch)

# con <- file("data_zl.txt", "r")
# line <- readLines(con,n=-1)
# line

     
# GKH2 <- NULL     
# con <- file("data_zl.txt", "r")
# line<-readLines(con,n=1)
# while( length(line) != 0 ) {
#   
#   data_ch <- line
#   
#   if(grepl("<公开（公告）号>=.*",data_ch))
#   {
#     GKH <- gsub("<.*?>=","",data_ch)
#     GKH2 <- rbind(GKH2,GKH)
#     GKH2 <- as.vector(GKH2)
#   } 
#   
#   line<-readLines(con,n=1)
# }
# GKH2
#class(GKH)
#class(GKH2)




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

data_get<-grep("<主权项>=.*",data_ch)
ZQX <- data_ch[data_get]
ZQX2 <- gsub("<.*?>=","",ZQX)
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
data_get<-grep("<国省代码>=.*",data_ch)
GSDM <- data_ch[data_get]
GSDM2 <- gsub("<.*?>=","",GSDM)
# 
# 
#data_get<-grep("<分案原申请号>=.*",data_ch)
#FAYSQH <- data_ch[data_get]
#FAYSQH2 <- gsub("<.*?>=","",FAYSQH)
# 
data_get<-grep("<地址>=.*",data_ch)
DZ <- data_ch[data_get]
DZ2 <- gsub("<.*?>=","",DZ)
# 
# 
# 
# 
data_get<-grep("<发布路径>=.*",data_ch)
FBLJ <- data_ch[data_get]
FBLJ2 <- gsub("<.*?>=","",FBLJ)
# 
data_get<-grep("<页数>=.*",data_ch)
YS <- data_ch[data_get]
YS2 <- gsub("<.*?>=","",YS)
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



excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
#View(excel_data)
write.csv(excel_data,"FM2011-2016_1.txt")










