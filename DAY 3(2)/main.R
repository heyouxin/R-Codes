#rm(list = ls())
library(rvest)
library(sqldf)
start<-as.Date("1996-06-27") 
end<-as.Date("2017-12-7")
date <- seq(from=start,to=end,by=7) 
#date <- as.data.frame(date)

year <- format(date,format="%Y") 
month <- format(date,format="%m") 
day <- format(date,format="%d") 
date_all <- data.frame(date,year,month,day)

attach(date_all)
date_1st_month <- sqldf("select *,min(day) from date_all group by year, month ")

date_ch <- as.character(format(date_1st_month$date,"%Y%m%d"))


date1<- "20080703"
date2<- "20171207"
date_part <-  date_ch[date_ch>=date1]


total_assets <- data.frame()

#for (i in c(1:length(date_part))) 
for (i in c(1:3)) 
  
{

  url <- paste0("https://www.federalreserve.gov/releases/H41/",date_part[i],"/h41.htm")
  tryCatch( 
  {
    web <- read_html(url)
    if(date_ch[i]>="20141204")
    {
      table_2 <- web %>%   
        html_nodes(xpath="/html/body/table[17]") %>%
        html_table(fill=T)
    }
    else
    {
      table_2 <- web %>%   
        html_nodes(xpath="/html/body/table[2]") %>%
        html_table(fill=T)
    }
    
    table_2 <- as.data.frame(table_2)
    
    
    f_gsub <- function(table)
    {
      
      gsub("\u00A0","",table)
      
    }
    table_2 <- sapply(table_2,f_gsub)
    total_assets_2 <- table_2[table_2[,1]=="TOTALASSETS" | table_2[,1]=="Totalassets" | table_2[,1]=="TotalAssets",]
    total_assets_2 <- as.vector(total_assets_2)
    total_assets_2 <- c(as.character(date_part[i]),total_assets_2)
    if(i==1)
    {
      total_assets <- total_assets_2
    }
    else
    {
      total_assets <- rbind(total_assets,total_assets_2)
    }
  },
  error=function(e)
  {
    print(date_part[i])
  })
}   


total_assets <-  as.data.frame(total_assets)    

write.csv(total_assets,"total_assets_2.csv",row.names = F)


#1996
#/html/body/table[2]

#20080703
#/html/body/table[5]


#20141204
#/html/body/table[14]








error_date <- c(
"19960705",
"19980102",
"20020705",
"20040102",
##网站上居然是0303 坑
"20050305",
"20090102",
"20130705",
"20150102",
"current")
date_ch <- error_date

rm(a)
a <- 33

vec1 <- c(1:10)
vec2 <- c(21:30)

df <- data.frame(vec1,vec2)
getwd()
write.csv(df,"df.csv")



df[c(1:2),-1]

View(df)
