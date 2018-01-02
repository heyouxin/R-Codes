#df <- read.csv("cleaned_data_2011.csv")
df <- df[,-1]
#df[which((df$city1)=(df$city2)),]
length(df[,1])
head(df)
library(openxlsx)
df <- read.xlsx("cleaned_data_2016.xlsx")
#df[which((is.na(df))&(is.na(df$city4))),]
####把city3!=NA,city4=NA 提取出来 3314条    3722

data1 <- df[which((!is.na(df$city3))&(is.na(df$city4))),]
#data1[1,10]
head(data1)
length(data1[,1])

for (i in 1:3722)
{
  new_data <- c(data1[i,1],data1[i,2],data1[i,3],data1[i,5],NA,NA,NA,data1[i,8],data1[i,9])
  new_data2 <- c(data1[i,1],data1[i,2],data1[i,4],data1[i,5],NA,NA,NA,data1[i,8],data1[i,9])
  data1 <-rbind(data1,new_data)
  data1 <-rbind(data1,new_data2)
  
}
#head(new_data)
city1_2 <- paste0(data1$city1,data1$city2)
#data1 <- data1[,-10]
data1 <- cbind(data1,city1_2)
length(data1[,1])
head(data1)
#df[which((is.na(df$flight))),]
####提取 city4!=NA 813   165
data2 <- df[which(!is.na(df$city4)),]
head(data2)
#length(data2[,1])
for (i in 1:165)
{
 
   
  new_data <- c(data2[i,1],data2[i,2],data2[i,3],data2[i,5],NA,NA,NA,data2[i,8],data2[i,9])
  new_data2 <- c(data2[i,1],data2[i,2],data2[i,4],data2[i,5],NA,NA,NA,data2[i,8],data2[i,9])
  new_data3 <-c(data2[i,1],data2[i,2],data2[i,3],data2[i,4],NA,NA,NA,data2[i,8],data2[i,9])
  data2 <- rbind(data2,new_data3)
  data2 <-rbind(data2,new_data)
  data2 <-rbind(data2,new_data)
  data2 <-rbind(data2,new_data2)
  data2 <-rbind(data2,new_data2)  
}
length(data2[,1])
city1_2 <- paste0(data2$city1,data2$city2)
head(city1_2)
head(data2)
data2 <- cbind(data2,city1_2)
head(data2)



data3 <- df[which(is.na(df$city3)),]
city1_2 <- paste0(data3$city1,data3$city2)
data3 <- cbind(data3,city1_2)
length(data3[,1])
head(data3)
final_data <- rbind(data1,data2)
final_data <- rbind(final_data,data3)
length(final_data[,1])
write.csv(final_data,"insert_record_2016.csv")

165*6+3722*3+8148
