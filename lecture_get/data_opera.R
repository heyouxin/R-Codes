rm(list=ls())


library(xlsx)
raw_data <- read.xlsx("C:/Users/heyouxin/Desktop/2013_2003城市数据整理v5.xlsx",1,encoding = "UTF-8",stringsAsFactors=F)



data <-raw_data
data2 <- data[,10:99]
data <- data[,1:9]
data <- data[-285,]
data2 <- data2[-285,]

  View(data)

 

names(data) <-c("city_name","city","year","SO2","popu","p_gdp","hos","bed","doc")

for (i in 1:10) 
{
  temp_data <- data2[,(9*(i-1)+1):(9*i)]
  names(temp_data) <- c("city_name","city","year","SO2","popu","p_gdp","hos","bed","doc")
  data <- rbind(data,temp_data)
  
}
warnings()





for (y in 1:11) 
{
  data[(284*(y-1)+1):(284*y),3] <- (2014-y)
  
}



write.xlsx(data,"C:/Users/heyouxin/Desktop/2013_2003城市数据.xlsx")


data3 <- read.xlsx("C:/Users/heyouxin/Desktop/2013_2003城市数据.xlsx",1,encoding = "UTF-8",stringsAsFactors=F)

View(data3)

if(grepl("*市",data3$city_name))
{
  city_name2 <- gsub("市","",data3$city_name)
}

data4 <- cbind(data3,city_name2,stringsAsFactors=F)


  data4$city_name2 <- gsub("([N ])", "",data4$city_name2 )

which(is.na(city_name2))

View(data4)

typeof(patent_data$city)

typeof(data4$year)


patent_data <- read.csv("C:/Users/heyouxin/Desktop/patent_city_year.csv",stringsAsFactors = F)
if(grepl("*市",patent_data$city))
{
  city <- gsub("市","",patent_data$city)
}

patent_data$city <- gsub("([N ])", "",patent_data$city )

View(patent_data)
typeof(patent_data$appliyear)
typeof(patent_data$city)
typeof(patent_data$patent_num)
patent_data$city <- as.character(patent_data$city)
typeof(data4$year)
typeof(data4$city_name2)
typeof(patent_data$patent_num)
which(patent_data$city==data4$city_name2)==T

data4$year <- as.integer(data4$year)
library(dplyr)
data5 <- left_join(data4,patent_data,c("city_name2"="city","year"="appliyear"))
View(data5)

subset(data4,city_name2="北京")


which(data4$city_name2=="  石家庄")

View(data4)
which(data4$city_name2=="普洱")

which(data4$city_name2=="Simao")

data4[537,]

data4$city_name2[537] <- "思茅"




library(sqldf)
sql <- sqldf(c("select * from data4 left join patent_data  on (data4.city_name2=patent_data.city and data4.year=patent_data.appliyear) group by data4.city_name2,data4.year"))



sql2 <- sql[,-c(12:13)]
#View(sql2)
sql2$city_name <- sql2$city_name2
sql2 <- sql2[,-10]
if(is.na(sql2$patent_num))
{
  sql2[which(is.na(sql2$patent_num)),10]=0
  sql2$patent_num=0
  
}
View(sql2)

which(sql2[])


write.csv(sql2,"C:/Users/heyouxin/Desktop/2013_2003_final_2.csv",row.names = F)

data_final <- read.csv("C:/Users/heyouxin/Desktop/2013_2003_final_2.csv")
View(data_final)

p_patent <- data_final$patent_num/data_final$popu
p_doc <- data_final$doc/data_final$popu

data_final2 <-cbind(data_final2,p_doc) 

data_final2$city <- as.integer(data_final2$city)
for (i in 1:283) 
{
  data_final2[(11*(i-1)+1):(11*i),2] <- i
  
}
View(data_final2)
write.csv(data_final2,"C:/Users/heyouxin/Desktop/2013_2003_final_3.csv",row.names = F)

library(xlsx)

data_fix <- read.xlsx("C:/Users/heyouxin/Desktop/2013_2003_final_3.xlsx",1,stringsAsFactors = F,encoding = "UTF-8")
View(data_fix)
data_fix2 <- data_fix
library(sqldf)


df <- sqldf(c("select * from data_fix2 left join patent_data on (data_fix2.city_name=patent_data.city and data_fix2.year=patent_data.appliyear) group by data_fix2.city_name,data_fix2.year"))

View(df)

df <- df[,-10]
df$patent_num.1
df[which(is.na(df$patent_num.1)),12]=0
df$p_patent <- df$patent_num.1/df$popu

df$city <- as.integer(df$city)
for (i in 1:283) 
{
  df[(11*(i-1)+1):(11*i),2] <- i
  
}
df[273,6] <- 24853

write.csv(df,"C:/Users/heyouxin/Desktop/2013_2003_final_4.csv",row.names = F)


library(xlsx)

data_fix <- read.xlsx("C:/Users/heyouxin/Desktop/2013_2003_final_5.xlsx",1,stringsAsFactors = F,encoding = "UTF-8")
View(data_fix)

data_fix[which(is.na(df$patent_num.1)),7]
data_fix$hos <- as.numeric(data_fix$hos)

p_hos <- data_fix$hos/data_fix$popu
typeof(p_hos)
data_fix <- cbind(data_fix,p_hos)
write.csv(data_fix,"C:/Users/heyouxin/Desktop/2013_2003_final_5.csv",row.names = F)
warnings()
which(is.na(data_fix$hos))

df <- read.csv("C:/Users/heyouxin/Desktop/2013_2003_final_5.csv")
View(df)
View(df[which(df$p_doc<5),])

