library(RSelenium)
library(Rwebdriver)
library(XML)

start_session(root = "http://127.0.0.1:4444/wd/hub", browser = "firefox")



#active_sessions()
post.url(url = "http://www.r-datacollection.com/materials/ selenium/intro.html")
get.url()


library(devtools)
install_github(repo="Rwebdriver",username="crubba")
checkForServer()
startServer()
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "firefox"
)
remDr$open()
remDr$getStatus()
remDr$navigate("http://www.google.com")


unlink(file.path(find.package("RSelenium"), "bin"), recursive = TRUE, force = TRUE)
RSelenium::checkForServer()
brew install geckodriver
selServ <- RSelenium::startServer(args = c("-port 5556"))
remDr <- RSelenium::remoteDriver(extraCapabilities = list(marionette = TRUE), port=5556)
remDr$open()

















