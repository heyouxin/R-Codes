a <- data_frame(color=c("green","yellow","red"),num=1:3)
b <- data_frame(color=c("green","yellow","pink"),size=c("S","M","L"))
m1 <- inner_join(a,b)
m1
m2 <- left_join(a,b)
m2
m3 <- right_join(a,b)
m3
m4 <- full_join(a,b)
m4
?as.Date

read.excel
data <- read.csv("mydata2.csv")
View(data)
library(xlsx)
 read.xlsx("mydata2.xlsx",sheetName="Sheet1")
 install.packages("openxlsx")
 
 #read excel qplot
library(openxlsx)
library(ggplot2)
table_test <- read.xlsx("mydata2.xlsx")
table_test$date <- convertToDate(table_test$date)
qplot(table_test$date,table_test$beijing,geom = "path")
