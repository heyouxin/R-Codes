library(readxl)
read.xl
temp <- read_excel("./files/hs300_weights_2016.xls",1)
temp
View(temp)
write.
write.xlsx(temp,"1.xlsx")


library(RODBC)
channel <- odbcConnectExcel("./files/hs300_weights_2016.xls",1)
myDf <- sqlFetch(channel,1)