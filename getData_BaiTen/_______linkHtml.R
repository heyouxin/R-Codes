require(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "firefox"
)
remDr$open()
remDr$getStatus()
remDr$navigate("http://so.baiten.cn/results?q=pd%253A%2528%255B2011%2520to%25202015%255D%2529%2520and%2520pa%253A%2528%25u5965%25u7EF4%25u901A%25u4FE1%25u80A1%25u4EFD%25u6709%25u9650%25u516C%25u53F8%2529&type=14&s=0&law=2&v=l")


selServ <- RSelenium::startServer(args = c("-port 5556"))
remDr <- RSelenium::remoteDriver(extraCapabilities = list(marionette = TRUE), port=5556)
remDr$open()