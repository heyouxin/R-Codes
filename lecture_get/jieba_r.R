library(jiebaR)
#  接受默认参数，建立分词引擎 
mixseg = worker()
segment(code= "广东省深圳市联通" , jiebar = mixseg)
# 相当于：
# worker( type = "mix", dict = "inst/dict/jieba.dict.utf8",
#         hmm  = "inst/dict/hmm_model.utf8",    # HMM模型数据
#         user = "inst/dict/user.dict.utf8")    # 用户自定义词库
# Initialize jiebaR worker 初始化worker
#This function can initialize jiebaR workers. You can initialize different kinds of workers including mix, mp, hmm, query, tag, simhash, and keywords.

mixseg <= "广东省深圳市联通"    # <= 分词运算符
# 相当于segment函数，看起来还是用segment函数顺眼一些
segment(code= "广东省深圳市联通" , jiebar = mixseg)
# code A Chinese sentence or the path of a text file.
# jiebar jiebaR Worker