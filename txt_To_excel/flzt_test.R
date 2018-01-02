#rm(list = ls())
library(data.table)
con <- file("data_zl.txt", "r")
data_ch <- readLines(con,n=-1)
close(con)
head(data_ch)
rec_pos<-grep("<REC>",data_ch)
#length(rec_pos)
#data_ch[c(rec_pos[1]:rec_pos[2])]
record_t<-data.frame(GKH="",GKR="")
record_t<-record_t[-1,]



for (i in c(1:length(rec_pos)-1))
{
  

  GKH2<-NA
  GKR2<-NA
  data_1<-data_ch[c(rec_pos[i]:rec_pos[i+1])]
  pos_GKH<-grep("<公开（公告）号>=.*",data_1)
  print(pos_GKH)
  if(length(pos_GKH)!=0)
  {
    GKH <- data_1[pos_GKH]
    GKH2 <- gsub("<.*?>=","",GKH)
    
  }

  pos_GKR<-grep("<公开（公告）日>=.*",data_1)
  if(length(pos_GKR)!=0)
  {
    GKR <- data_1[pos_GKR]
    GKR2 <- gsub("<.*?>=","",GKR)
    
  }
  # 
  # 
  record_1<-data.frame(GKH=GKH2,GKR=GKR2)
  record_1
  record_t<-rbind(record_t,record_1)
}
####最后一条记录

GKH2<-NA
GKR2<-NA
data_1<-data_ch[c(rec_pos[length(rec_pos)]:length(data_ch))]
pos_GKH<-grep("<公开（公告）号>=.*",data_1)
if(length(pos_GKH)!=0)
{

  GKH <- data_1[pos_GKH]
  GKH2 <- gsub("<.*?>=","",GKH)
  
}

pos_GKR<-grep("<公开（公告）日>=.*",data_1)
if(length(pos_GKR)!=0)
{
  GKR <- data_1[pos_GKR]
  GKR2 <- gsub("<.*?>=","",GKR)
  
}
# 
# 
record_1<-data.frame(GKH=GKH2,GKR=GKR2)
record_t<-rbind(record_t,record_1)
head(record_t)
View(record_t)

