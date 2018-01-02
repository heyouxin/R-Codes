#rm(list=ls())
#library(openxlsx)
library(xlsx)
library(stringr)
library(splitstackshape)
filename<-"case_2.xlsx"
raw_data<-read.xlsx(filename,sheetName = 1,encoding = "UTF-8")

#获取列名
col_name<-names(raw_data)

#按“空格”符号分割表内数据
final_data <-cSplit(raw_data,col_name[3],"##")
#View(final_data)
write.xlsx(final_data,"law_case_2.xlsx",row.names = F)
#write.csv(final_data,"law_case.csv",row.names = F)
#a111 <- read.xlsx("law_case.xlsx",1,encoding = "UTF-8")
#View(a111)
