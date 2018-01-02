rm(list=ls())
#library(openxlsx)
library(xlsx)
library(stringr)
library(splitstackshape)
filename<-"./advEconometric_homework_files/demand_data.xlsx"
raw_data<-read.xlsx(filename,sheetName = 1,encoding = "UTF-8",header = F)

#获取列名
col_name<-names(raw_data)

#按“空格”符号分割表内数据
data<-cSplit(raw_data,col_name," ")
#View(data)

#重命令列名
names(data)<-c("OBS","log_quan","log_price","X_2","X_3","X_4","X_5")


ols_fit <- lm(log_quan~X_2+X_3+log_price,data = data)
summary(ols_fit)


write.xlsx(data,"./advEconometric_homework_files/demand_data_adjusted.xlsx",row.names = F)
