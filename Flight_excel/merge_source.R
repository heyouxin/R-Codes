# ####questions
# 1.并行计算不是多线程。R语言不支持多线程。并行计算是两只手做一件事，多线程是一只手做一件事。有人要开发支持多线程的R语言的消息。
# 2.RS多开，在wins下开多进程成本高，通信是个问题。
# 3.full_join  RStudio崩溃  merge(,,all = T) 与 full_join是一个意思？  merge(,,all = F)与inner_join
# 4.han_xin excel表格的处理思路
# ####




####




library(dplyr)
library(openxlsx)
df <- read.csv("insert_record_2016.csv")
#df <- df[,-1]
#length(df[,1])
head(df)



df


df2 <- read.xlsx("sources1218.xlsx")
head(df2)
#df2 <- df2[,-2]
length(df2[,1])

df3<- right_join(df,df2)
head(df3)
#df3 <- merge(df,df2,all = T)
df3 <- merge(df,df2)

####找出未匹配的
# View(df3)
# length(df3[,1])
# View(df3[which(is.na(df3$flag)),])
# write.csv(df3,"df3.csv")
# write.csv(df3[which(is.na(df3$flag)),],"2011_no_find.csv")
# df3<-df3[-which(as.character(df3$city1)==as.character(df3$city2)),]
# length(df3[,1])
# df3<-df3[-which(is.na(df3$flag)),]
# df3<-df3[-which(is.na(df3$city1)),]
#write.csv(df3[which(is.na(df3$city1)),],"2016_in_Dic_no_File.csv")

#head(df4)
# #df4$flight <- substr(df4$flight_num,1,2)
# head(df4)
# df4 <- df4[,-1]
# length(df4[,1])

# sql1 <- sqldf("select flag,count(*) flag_num from df3 group by flag")
# head(sql1)
# class(sql1)

df4 <- df3
library(sqldf)
attach(df4)
sql2 <- sqldf("select city1_2,flag,flight, sum(flight_account) flight_total_account,plane,remarks from df4 group by flag,flight")

write.csv(sql2,"group_2016_1218.csv")



