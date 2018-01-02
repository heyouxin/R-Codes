library(httr)
library(rvest)
library(RSelenium)
library(stringr)
library(xlsx)
library(data.table)


openHtml <- function(url,casename)
{


  remDr$navigate(url)
  #remDr$refresh()
  Case_data <- remDr$findElements(using = 'css selector', "#divFullText")
  #webElem_totalcount <- remDr$findElement('xpath', "//*[@id="divFullText"]/text()[1]")
  Case_txt <- unlist(lapply(Case_data, function(x){x$getElementText()}))
  
  ##文本处理
  str <- strsplit(Case_txt,"原告")
  str2 <- str[[1]][2]
  
  useful_str <- strsplit(str2,"\n")
  #list 转 vector
  useful_str2 = as.vector(unlist(useful_str[1]))
  yuangao <- useful_str2[1]
  yuangao2 <- gsub("原告","",yuangao)
  yuangao2 <- gsub("。","",yuangao2)
  yuangao2 <- gsub("：","",yuangao2)
  yuangao2 <- gsub(":","",yuangao2)
  
  beigao_pos <- grep(pattern = "被告.*",useful_str2)
  beigao <- c()
  for (i in 1:length(beigao_pos)) 
  {
    beigao[i]=useful_str2[beigao_pos[i]]
    
  }
  beigao2 <- gsub("被告","",beigao)
  beigao2 <- gsub("。","",beigao2)
  beigao2 <- gsub("：","",beigao2)
  beigao2 <- gsub(":","",beigao2)
  beigao2 <- paste0(beigao2,collapse = "##")
  data1 <- data.frame()
  data1 <- data.frame("casename"=casename,"accuser"=yuangao2,"defender"=beigao2)
  return (data1)
  
  
}



##读URL
url_data <- data.frame()
#url_data <- read.xlsx("url.xlsx",1)
url_data <- fread("url_3.csv",encoding = "UTF-8")
#View(url_data)
site <- as.character(url_data$website)
name <- url_data$case_name

##抓取数据
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)
remDr$open()
remDr$navigate(site[1])
Sys.sleep(5)
remDr$refresh()

#remDr$navigate(site[24])
#head(site)
# remDr$refresh()
# Case_data <- remDr$findElements(using = 'css selector', "#divFullText")
# #webElem_totalcount <- remDr$findElement('xpath', "//*[@id="divFullText"]/text()[1]")
# Case_txt <- unlist(lapply(Case_data, function(x){x$getElementText()}))

data <- data.frame()
i
for(i in 1681:length(site))
{
 data <- rbind(data,openHtml(site[i],name[i]))
  
}
write.xlsx(data,"case_2.xlsx",row.names = F)
#View(data)
#site[i]
