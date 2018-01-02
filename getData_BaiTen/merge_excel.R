data111 <- data.frame()
for(i in 1:7)
{
  doc_name <- paste0("firms",i,".csv")
  df <- read.csv(doc_name,header = F)
  data111 <- rbind(data111,df[-1,-1])

}
head(data111)


write.csv(data111,file = "./files/firms_no_invalidData.csv")

####读取EXCEL
# library(openxlsx)
# library(ggplot2)
# table_test <- read.xlsx("mydata2.xlsx")
# table_test$date <- convertToDate(table_test$date)
# qplot(table_test$date,table_test$beijing,geom = "path")
# 
# 
# 














no <- c(1:7)
no
doc_name <- paste0("firms",no,".csv")
doc_name
df_name <- paste0("df",no)
df_name <- read.csv(doc_name,header = F)
df_total <- rbind(df_name[-1,-1])
head(df_total)
df1 <- read.csv("firms1.csv",header = F)
df1[-1,-1]
df1 <- read.csv("firms1.csv",header = F)
df1[-1,-1]
df1 <- read.csv("firms1.csv",header = F)
df1[-1,-1]


df1 <- read.csv("firms1.csv",header = F)
df2 <- read.csv("firms2.csv",header = F)
df3 <- read.csv("firms3.csv",header = F)
df4 <- read.csv("firms4.csv",header = F)
df5 <- read.csv("firms5.csv",header = F)
df6 <- read.csv("firms6.csv",header = F)
df7 <- read.csv("firms7.csv",header = F)
df55 <- df5[!duplicated(df5),]

df <- rbind(df1[-1,-1],df2[-1,-1])






