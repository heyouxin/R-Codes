#rm(list = ls())
#library(data.table)
#con <- file(file.choose(),r)
con <- file("FLZT_2008-2016_3.txt", "r")
data_ch <- readLines(con,n=-1,encoding = "UTF-8")
#data_ch <- readLines(con,n=-1)
close(con)
head(data_ch)
rec_pos<-grep("<REC>",data_ch)
length(rec_pos)
record_t<-data.frame(授权公告号="",申请号="",法律状态公告日="",法律状态="",法律状态信息="")
record_t<-record_t[-1,]

i_rec_pos<-length(rec_pos)-1
i_rec_pos

#for (i in c(2:length(rec_pos)-1))
for (i in c(1:i_rec_pos))
{
  ####授权公告号 申请号  法律状态公告日  法律状态  法律状态信息  
  SQGGH2<-NA
  SQH2<-NA
  FLZTGGR2<-NA
  FLZT2<-NA
  FLZTXX2<-NA
  data_1<-data_ch[c(rec_pos[i]:rec_pos[i+1])]
  pos_SQGGH<-grep("<授权公告号>=.*",data_1)
  if(length(pos_SQGGH)!=0)
  {
    SQGGH <- data_1[pos_SQGGH]
    SQGGH2 <- gsub("<.*?>=","",SQGGH)
    
  }
  pos_SQH<-grep("申请号>=.*",data_1)
  if(length(pos_SQH)!=0)
  {
    SQH <- data_1[pos_SQH]
    SQH2 <- gsub("<.*?>=","",SQH)
    
  }
  
  pos_FLZTGGR<-grep("<法律状态公告日>=.*",data_1)
  if(length(pos_FLZTGGR)!=0)
  {
    FLZTGGR <- data_1[pos_FLZTGGR]
    FLZTGGR2 <- gsub("<.*?>=","",FLZTGGR)
    
  }
  pos_FLZT<-grep("<法律状态>=.*",data_1)

  if(length(pos_FLZT)!=0)
  {
    FLZT <- data_1[pos_FLZT]
    FLZT2 <- gsub("<.*?>=","",FLZT)
    
  }
  
  pos_FLZTXX<-grep("<法律状态信息>=.*",data_1)
  if(length(pos_FLZTXX)!=0)
  {
    FLZTXX <- data_1[pos_FLZTXX]
    FLZTXX2 <- gsub("<.*?>=","",FLZTXX)
    
  }
  
  

  # 
  record_1<-data.frame(授权公告号=SQGGH2,申请号=SQH2,法律状态公告日=FLZTGGR2,法律状态=FLZT2,法律状态信息=FLZTXX2)
  #record_1
  record_t<-rbind(record_t,record_1)
}
####最后一条记录
SQGGH2<-NA
SQH2<-NA
FLZTGGR2<-NA
FLZT2<-NA
FLZTXX2<-NA

data_1<-data_ch[c(rec_pos[length(rec_pos)]:length(data_ch))]
pos_SQGGH<-grep("<授权公告号>=.*",data_1)
if(length(pos_SQGGH)!=0)
{
  SQGGH <- data_1[pos_SQGGH]
  SQGGH2 <- gsub("<.*?>=","",SQGGH)
  
}
pos_SQH<-grep("申请号>=.*",data_1)
if(length(pos_SQH)!=0)
{
  SQH <- data_1[pos_SQH]
  SQH2 <- gsub("<.*?>=","",SQH)
  
}

pos_FLZTGGR<-grep("<法律状态公告日>=.*",data_1)
if(length(pos_FLZTGGR)!=0)
{
  FLZTGGR <- data_1[pos_FLZTGGR]
  FLZTGGR2 <- gsub("<.*?>=","",FLZTGGR)
  
}
pos_FLZT<-grep("<法律状态>=.*",data_1)

if(length(pos_FLZT)!=0)
{
  FLZT <- data_1[pos_FLZT]
  FLZT2 <- gsub("<.*?>=","",FLZT)
  
}

pos_FLZTXX<-grep("<法律状态信息>=.*",data_1)
if(length(pos_FLZTXX)!=0)
{
  FLZTXX <- data_1[pos_FLZTXX]
  FLZTXX2 <- gsub("<.*?>=","",FLZTXX)
  
}



# 
# 
record_1<-data.frame(授权公告号=SQGGH2,申请号=SQH2,法律状态公告日=FLZTGGR2,法律状态=FLZT2,法律状态信息=FLZTXX2)

record_t<-rbind(record_t,record_1)
head(record_t)
write.csv(record_t,"FLZT_2008-2016_3.csv")







