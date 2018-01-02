rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)

remDr$open()
remDr$navigate("http://event.soe.xmu.edu.cn/LectureOrder.aspx")


Sys.sleep(15)
#for (times in 1:9) 
#{
  
  webElems <- remDr$findElements(using = 'css selector', "td:nth-child(14)")
  Action <- unlist(lapply(webElems, function(x){x$getElementText()}))
  while(!any(Action[]=="Reserve this seminar"))
  #while(!any(Action[]=="Cancel my reservation"))
  {
    #Sys.sleep(60)
    remDr$refresh() 
    webElems <- remDr$findElements(using = 'css selector', "td:nth-child(14)")
    Action <- unlist(lapply(webElems, function(x){x$getElementText()}))
    
  }

  
  #remDr$navigate("http://event.soe.xmu.edu.cn/LectureOrder.aspx")
  n <- length(Action)
  for (i in 1:n) 
  {
     if(Action[i]=="Reserve this seminar")
     {
       ### CSS//*[@id="ctl00_MainContent_GridView1_ctl04_btnrefuse"]
        #location <- paste0("#ctl00_MainContent_GridView1_ctl0",i+1,"_btnrefuse")
        location <- paste0("#ctl00_MainContent_GridView1_ctl0",i+1,"_btnreceive")
        make_reservation <- remDr$findElement(using = 'css selector', location)
        make_reservation$clickElement()
        Sys.sleep(30)
        remDr$navigate("http://event.soe.xmu.edu.cn/LectureOrder.aspx")
     }
   }
  remDr$navigate("http://event.soe.xmu.edu.cn/LectureOrder.aspx")
   
#}

