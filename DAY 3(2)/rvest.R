library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating
#> [1] 7.8

cast <- lego_movie %>%
#  html_nodes("#titleCast .itemprop span") %>%
   html_nodes(" .itemprop span") %>%
   html_text()
cast
#>  [1] "Will Arnett"     "Elizabeth Banks" "Craig Berry"    
#>  [4] "Alison Brie"     "David Burrows"   "Anthony Daniels"
#>  [7] "Charlie Day"     "Amanda Farinos"  "Keith Ferguson" 
#> [10] "Will Ferrell"    "Will Forte"      "Dave Franco"    
#> [13] "Morgan Freeman"  "Todd Hansen"     "Jonah Hill"

poster <- lego_movie %>%
  html_nodes(".poster img") %>%
  html_attr("src")
poster


View(c("rating",rating,"cast",cast,"poster",poster))
is.list(rating)
is.vector(rating)
is.list(cast)
View(poster)
#getdata<-rbind(rating,cat,poster)


library(rvest)
surface_price <- read_html("http://search.jd.com/Search?keyword=surface%20pro4&enc=utf-8&suggest=1.rem.0.0&wq=surface%20pro4&pvid=tw4k3vti.jvdu6h")

price <- surface_price %>% 
  html_nodes("strong i") %>%
  html_text() %>%
  as.numeric()
View(price)






library(rvest)
douban_movie <- read_html("https://movie.douban.com/tag/%E5%96%9C%E5%89%A7")

title <- douban_movie %>%
  #css selector
  html_nodes(".p12 div a")%>%
  html_text()
title

price <- douban_movie %>% 
  html_nodes("table tr td div div span") %>%
  html_text() 
  #as.numeric()
price


hist(rnorm(100))


Nile
hist(Nile)

#function
oddcount <- function(x){
  k <- 0
  for (n in x) {
    if(n%%2==1) k <- k+1
    
  }
  return(k)
}

oddcount(c(1,3,5,7))
mode(c(1,3))

u <- paste("a","b","c")
u
v <- strsplit(u," ")
v

m <- rbind(c(1,4),c(2,2))
m

mat <-matrix(1:4,nrow = 2)
mat

his <- hist(Nile)

name <- c("a","b","c")
age <- c(1,2,NA)

d <- data.frame(name,age)
d


summary(Nile)
mode(summary(Nile))
is.classes.frame(summary(Nile))






