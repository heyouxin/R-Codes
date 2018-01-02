library(xlsx)
library(dplyr)
library(ggplot2)

filename <- dir("./Data/")
#删除隐藏文件
filename <- filename[-(1:6)]

filename[27:33]

price_plot <- function(i)
{
  #par(mfrow=c(1,2))
  par(fin=c(1,1))
  filepath <- paste0("./Data/",filename[1])
  

  #从第三部分开始读取文件，即28行开始
  file <- read.xlsx(filepath,1,startRow = 28)
  
  file <- filter(file,tradeID>0)
  View(group1)
  
  file <- file[order(file$tradeID),]
  
  
  group1 <- filter(file,Group==1)
  time_t <- c(1:nrow(group1))
  title <- paste0(filename[i],"_group1 price 波动图")
  
  group2 <- filter(file,Group==2)
  time_t <- c(1:nrow(group2))
  title <- paste0(filename[i],"_group2 price 波动图")
  
 
  
  ggplot(group1,aes(x=time_t,group1$price))
  
  ggplot(group2,aes(x=time_t,group2$price))
  
  par(mfrow=c(1,1))
  
  
  #print(plot2)
}

price_plot(2)
# 
# for (i in 1:7) 
# {
#   filepath <- paste0("./Data/",filename[i])
#   #从第三部分开始读取文件，即28行开始
#   file <- read.xlsx(filepath,1,startRow = 28)
#   group1 <- filter(file,Group==1)
#   time_t <- c(1:nrow(group1))
#   title <- paste0("group1 price 波动图")
#   ggplot(group1,aes(x=time_t,group1$price))+
#     geom_line(colour="green")+
#     ggtitle("title")
#   
#   group2 <- filter(file,Group==2)
#   time_t <- c(1:nrow(group2))
#   title <- paste0("group2 price 波动图")
#   ggplot(group2,aes(x=time_t,group2$price))+
#     geom_line(colour="red")+
#     ggtitle("title")
#   
#   
# }


#attach(file)
#library(sqldf)
#group1_price <- sqldf("select price from file where Group=1 ")
#View(data)
