#### version 2.0 2017.12 hyx

####1.逐行读取判断，读到<rec>写入一条记录，往下循环，判断是哪个字段，
####2.读到“摘要”字段，即往下判断是否为“<”,进行拼接
####3.有无可能连接数据库，每条记录直接写入数据库中。

####4.用sampe  data_zl.txt进行测试。按行读取。
# GKH2 <- NULL     
# con <- file("data_zl.txt", "r")
# line<-readLines(con,n=1)
# while( length(line) != 0 ) {
#   
#   data_ch <- line
#   
#   if(grepl("<公开（公告）号>=.*",data_ch))
#   {
#     GKH <- gsub("<.*?>=","",data_ch)
#     GKH2 <- rbind(GKH2,GKH)
#     GKH2 <- as.vector(GKH2)
#   } 
#   
#   line<-readLines(con,n=1)
# }
# GKH2
#####
####log 完全正常的数据
# FM2011-2016_4
# XX_4
# XX_3
# 
# 
# ####有异常的数据
# > excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
# Warning message:
#   In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                      Item 11 is of size 901323 but maximum size is 901383 (recycled leaving remainder of 60 items)
#                    > #View(excel_data)
#                      > write.csv(excel_data,"FM2011-2016_3.csv")
# 
#                    
#                    
# 
#                    
#  excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
#                    Warning messages:
#                      1: In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                                            Item 11 is of size 1007031 but maximum size is 1007254 (recycled leaving remainder of 223 items)
#                                          2: In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                                                                Item 12 is of size 1007242 but maximum size is 1007254 (recycled leaving remainder of 12 items)
#                                                              > #View(excel_data)
#                                                                > write.csv(excel_data,"FM2011-2016_2.csv")
#                                                              
#                                                              
#   xcel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)                                                             Warning message:
#                                                                In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                                                                                   Item 12 is of size 1022601 but maximum size is 1022619 (recycled leaving remainder of 18 items)
#                                                                                 > #View(excel_data)
# 
#                                                                                   
#                                                                                   
#                                                                                   
#                                                                                   
#                                                                                   
#                                                                                   excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"专利号"=ZLH2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
#                                                                                         In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                                                                                                      Item 13 is of size 1123657 but maximum size is 1123728 (recycled leaving remainder of 71 items)
#                                                                                                    > #View(excel_data)
#                                                                                                      > write.csv(excel_data,"XX_2.csv") 
#                                                                                                    
#                                                                                                    
#                                                                                                    excel_data <- data.table("公开号"=GKH2,"公开日"=GKR2,"申请号"=SQH2,"申请日"=SQR2,"专利号"=ZLH2,"名称"=MC2,"主分类号"=ZFLH2,"分类号"=FLH2,"申请(专利权)人"=SQZLR2,"发明(设计)人"=FMR2,"摘要"=ZY2,"主权项"=ZQX2,"国省代码"=GSDM2,"地址"=DZ2,"发布路径"=FBLJ2,"页数"=YS2,"申请国代码"=SQGDM2,"专利类型"=ZLLX2,"申请来源"=SQLY2)
#                                                                                                    Warning message:
#                                                                                                      In data.table(公开号 = GKH2, 公开日 = GKR2, 申请号 = SQH2, 申请日 = SQR2,  :
#                                                                                                                         Item 13 is of size 1106452 but maximum size is 1106520 (recycled leaving remainder of 68 items)
#                                                                                                                       > #View(excel_data)
#                                                                                                                         > write.csv(excel_data,"XX_1.csv")
#                                                                                                                       
#                                                                                                                       
#                                                                                                                       
#                                                                                                                       
#                                                                                                                       
#                                                                                                    
#                                                                                                    
#                                                           
                                                                                                                                                                    > write.csv(excel_data,"FM2011-2016_1.txt")