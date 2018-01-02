rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)



for (times in 1:9) 
{
  remDr$open()
  remDr$navigate("http://event.soe.xmu.edu.cn/LectureOrder.aspx")

  #login_account <- remDr$findElement(using = "css", "[name = 'UserName']")
  #login_account$sendKeysToElement(list("15320161152321"))
  
  #login_password <- remDr$findElement(using = "css", "[name = 'Password']")
  #login_password$sendKeysToElement(list("123456"))
  
  login_account <- remDr$findElement(using = "css", "[name = 'UserName']")
  login_account$sendKeysToElement(list("15320161152349"))
  
  login_password <- remDr$findElement(using = "css", "[name = 'Password']")
  login_password$sendKeysToElement(list("123456"))
  
  
  login <- remDr$findElement(using = 'css selector', "#default-main > div.default-content.logon-content > div > div > div.save-operation > input")
  login$clickElement()
  
  Sys.sleep(3)
  webElems <- remDr$findElements(using = 'css selector', "td:nth-child(14)")
  Action <- unlist(lapply(webElems, function(x){x$getElementText()}))
  while(!any(Action[]=="Reserve this seminar"))
  {
    #Sys.sleep(1)
    remDr$refresh() 
    webElems <- remDr$findElements(using = 'css selector', "td:nth-child(14)")
    Action <- unlist(lapply(webElems, function(x){x$getElementText()}))
    
  }

  n <- length(Action)
  for (i in 1:n) 
  {
    if(Action[i]=="Reserve this seminar")
    {
      location <- paste0("#ctl00_MainContent_GridView1_ctl0",i+1,"_btnreceive")
      make_reservation <- remDr$findElement(using = 'css selector', location)
      make_reservation$clickElement()
      Sys.sleep(3)
    }
  }
}

