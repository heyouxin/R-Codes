library(xlsx)
library(stringr)
library(splitstackshape)
raw_data <- read.xlsx("./files/工作簿Z.xlsx",1,encoding = "UTF-8")
#col_name<-names(data)
data<-cSplit(raw_data,"时间",",")
View(data)
Date1 <- as.Date(data$时间_1,"%Y-%m-%d")
data$year <- format(Date1,format="%Y") 
data$month <- format(Date1,format="%m") 
data$day <- format(Date1,format="%d") 

last_day <- aggregate(data,by=list(data$year,data$month),FUN=max)

View(data)
library(sqldf)
attach(data)
sql1 <- sqldf("select *,max(day) from data group by year,month")
View(sql1)
write.xlsx(sql1,"Z.xlsx")


