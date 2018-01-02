x <- c(88,5,12,13)

x[c(1,3)]

x <- c(x[1:3],168,x[4]) 


x <- x[-c(1,2)]

x<-1:100



library(rvest)
website <- "https://www.federalreserve.gov/releases/H41/current/h41.htm"
web <- read_html(website)
table_2 <- web %>%   
  html_nodes(xpath="/html/body/table[17]") %>%
  
  html_table(fill=T)

View(table_2)
