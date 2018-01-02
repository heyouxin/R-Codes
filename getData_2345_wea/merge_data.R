library(data.table)
data111 <- data.table()
filename<-dir("C:/Users/heyouxin/Documents/R codes/getData_2345_wea/wea_data")
for(i in 1:10)
{
  doc_name <- paste0("./wea_data/",filename[i])
  df <- fread(doc_name,header = F)
  data111 <- rbind(data111,df[-1,-1])
  
}
names(data111)<-c("日期","最高气温","最低气温","天气","风向风力","空气质量指数","城市")
head(data111)
write.csv(data111,"wea_data_2011-2017.csv")
