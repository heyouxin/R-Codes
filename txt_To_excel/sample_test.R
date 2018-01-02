#### version 2.0 2017.12 hyx    FLZT

####1.逐行读取判断，读到<rec>写入一条记录，往下循环，判断是哪个字段，
####2.读到“摘要”字段，即往下判断是否为“<”,进行拼接
####3.有无可能连接数据库，每条记录直接写入数据库中。

####4.用sampe  test_flzt.txt进行测试。按行读取。


####   完全不行  用while 太慢了！！！   只能把数据先读入内存
# 
# #View(excel_data)
# library(data.table)
# record_t <- data.table()    
record_t<-list()
#con <- file("data_zl.txt", "r")
con <- file(file.choose(),r)

line<-readLines(con,n=1)
while( length(line) != 0 )
{
  record_1<-c()
  if(grepl("<rec>=.*",line))
  {
    line<-readLines(con,n=1)
    while(!grepl("<rec>=.*",line))
    {
      append(record_1,line)
      line<-readLines(con,n=1)
    }
    append(record_t,record_1)
  }
}
head(record_t)
 
# # GKH2