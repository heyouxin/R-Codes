
library(rvest)
url1<-"http://datacenter.mep.gov.cn/report/air_daily/air_dairy_aqi.jsp?city=&startdate=&enddate=&page="
#url<-paste0(url1,1)
#url
total_data<-data.frame()
for(page in 1:12702)
{
  url<-paste0(url1,page)
  web <- read_html(url,encoding = "UTF-8")
  table_data<-html_table(html_nodes(web, "#report1"))
  table_data2<-as.data.frame(table_data)
  table_data2<-table_data2[-c(33:35),]
  table_data2<-table_data2[-c(1:2),]
  table_data2<-table_data2[,-c(1:2)]
  total_data<-rbind(total_data,table_data2)
  
  
  
  
}
write.csv(total_data,"envir_data_aqi.csv",row.names = F)


# web <- read_html(url1,encoding = "UTF-8")
# table_data<-html_table(html_nodes(web, "#report1"))
# table_data2<-as.data.frame(table_data)
# table_data2<-table_data2[-c(33:35),]
# table_data2<-table_data2[-c(1:2),]
# table_data2<-table_data2[,-c(1:2)]
# class(table_data2)
# View(table_data2)
# write.csv(table_data2,"envir_data.csv",row.names = F)
