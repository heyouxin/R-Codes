library(RMySQL)
conn <- dbConnect(MySQL(), dbname = "world", username="root", password="123456", host="127.0.0.1", port=3306)
res <- dbSendQuery(conn, "SELECT * FROM country where Code='CHN';")
data <- dbFetch(res)
data
dbClearResult(res)
dbDisconnect(conn)
res2 <- dbSendQuery(conn, "update country set Code2='CN' where Code='CHN';")

