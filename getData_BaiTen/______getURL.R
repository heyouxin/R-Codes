library(data.table)   # 为了rbindlist函数
library(dplyr)        # 为了数据整理
library(magrittr)     # 为了管道操作符 %>%
library(rvest)        # 为了read_html函数
library(RSelenium)    # 为了使用JavaScript进行网页抓取

url <- "https://www.goodreads.com/book/show/18619684-the-time-traveler-s-wife#other_reviews"
book.title <- "The time traveler's wife"
output.filename <- "GR_TimeTravelersWife.csv"
startServer()
remDr <- remoteDriver(browserName = "ie", port = 4444) # instantiate remote driver to connect to Selenium Server
remDr$open() # 打开浏览器
remDr$navigate(url) 



library(doParallel)



