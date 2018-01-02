head(USArrests)
substr(STATES,1,4)
STATES=rownames(USArrests)
state_chars <- nchar(STATES)
state_chars
hist(state_chars)
STATES[grep("w",STATES)]
STATES[grep("[Ww]",STATES)]
STATES[grep("w",STATES,ignore.case = T)]
library(stringr)
str_count(STATES,"a")
vowels <- c("a","e","i","o","u")
str_count(STATES,vowels)
test_vector<-c("a1","33","\n","4")
test_vector
str_extract_all(test_vector,"[4$]")
str_extract_all(test_vector,"\n")



