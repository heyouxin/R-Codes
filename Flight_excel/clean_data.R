library(openxlsx)
df <- read.xlsx("2011flights.xlsx")
head(df)
##rm(list=ls())
library(sqldf)
df <- read.csv("2011fights.csv",encoding = 'UTF-8')
View(df)
attach(df2)
#df[which((df$city1)==(df$city2)),]

library(openxlsx)
df <- read.xlsx("2016flights.xlsx")
df <- df[,-10]
length(df[,1])

####2016年总记录数 12035
c1 <- as.vector(df$flight_num)
nchar(c1)
c1 <- as.character(c1)
head(c1)

####删除字符串中特定字符
c1<-gsub("\\.","",c1)

View(c1)
flight_account <- c1
flight_account <-nchar(flight_account)
df <- cbind(df,flight_account)
head(df)
#head(df)
#sql1 <- sqldf("select count(*) from df2 ")
#sql1
error_data <- df[which((is.na(df$city1))|(is.na(df$city2))),]
length(error_data[,1])
#error_data
write.csv(error_data,"error_data.csv")

##除去error_data 剩下5729
df <- df[-which((is.na(df$city1))|(is.na(df$city2))),]
length(df[,1])

##除去两条error 5727
df <- df[-which((is.na(df$city3))&(!is.na(df$city4))),]
length(df[,1])
####把city3=NA提取出来

data1 <- df[which(is.na(df$city3)),]
length(data1[,1])

####把city3!=NA,city4=NA 提取出来 
data2 <- df[which((!is.na(df$city3))&(is.na(df$city4))),]
length(data2[,1])


####提取 city4!=NA
data3 <- df[which(!is.na(df$city4)),]
length(data3[,1])


write.csv(df,"cleaned_data_2016.csv")
8148+3722+165



#length(df[,1])
for (i in 1:5755) 
{
  if((!is.na(df[i,5])) && (is.na(df[i,6])))
  {
    print(df[i,])
     
  }
  
}
!is.na(df[1,5])
#df2[which(df2[,5]!=NA & df2[,6])=NA]
