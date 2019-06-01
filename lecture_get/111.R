rm(list=ls())
library(httr)
library(rvest)
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)

remDr$open()

remDr$navigate("http://ids.xmu.edu.cn/authserver/login?service=http://xsswdt.xmu.edu.cn/login/login/idsLogin")

login_account <- remDr$findElement(using = "css", "#username")
#login_account$sendKeysToElement(list("15520170155207"))
login_account$sendKeysToElement(list("15620170155226"))
login_password <- remDr$findElement(using = "css", "#password")
#login_password$sendKeysToElement(list("180929"))
login_password$sendKeysToElement(list("270021"))
login <- remDr$findElement(using = 'css selector', ".auth_login_btn")
login$clickElement()


remDr$navigate("http://gongyu.xmu.edu.cn/index.php/Student/Freshman/index")

while(1)
{
  remDr$refresh() 
  Sys.sleep(1)
} 
  