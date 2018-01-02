#rm(list = ls())
library(rvest)
start<-as.Date("1996-06-27") 
end<-as.Date("2017-12-7")
date <- seq(from=start,to=end,by=7) 
#date <- as.data.frame(date)

# year <- format(date,format="%Y") 
# month <- format(date,format="%m") 
# day <- format(date,format="%d") 
# date_all <- data.frame(date,year,month,day)

dir("./data")

date_ch <- as.character(format(date,"%Y%m%d"))


date1<- "19960627"
date2<- "20080703"
date_part <-  date_ch[date_ch>=date1 & date_ch<date2]

f_gsub <- function(table)
{
  
  gsub("\u00A0","",table)
  
}

total_assets <- data.frame()
for (i in c(1:2)) 
{
  date_er <- c(date[i],date[i]+1,date[i]+2)
  date_er <- as.character(date_er,"%Y%m%d")
  for (n in 1:3) 
  {

    tryCatch( 
      {
        url <- paste0("https://www.federalreserve.gov/releases/H41/",date_er[n],"/h41.htm")
        web <- read_html(url)
        
        #table_index <- c("2","5","14")
        #tryCatch(
        #{
          
          table_2 <- web %>%   
            html_nodes(xpath="/html/body/table[2]") %>%
            html_table(fill=T)
            
        #},error=function(e){}
        #)
        table_2 <- as.data.frame(table_2)
        table_2 <- sapply(table_2,f_gsub)
        total_assets_2 <- table_2[toupper(table_2[,1])=="TOTALASSETS",]
        print(total_assets_2)
        total_assets_2 <- as.vector(total_assets_2)
        total_assets_2 <- c(as.character(date_er[n]),total_assets_2)
        if(i==1)
        {
          total_assets <- total_assets_2
        }
        else
        {
          total_assets <- rbind(total_assets,total_assets_2)
        }
        total_assets_2 <- NULL
      },
      error=function(e)
      {
        print(date_er[i])
      })
    
    
  }

 
}   


total_assets <-  as.data.frame(total_assets)    

write.csv(total_assets,"total_assets_2.csv",row.names = F)


#1996
#/html/body/table[2]

#20080703
#/html/body/table[5]


#20141204
#/html/body/table[14]






