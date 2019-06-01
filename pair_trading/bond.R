library(xlsx)
library(quantmod)

bond_HQ <- read.xlsx("三只违约债券历史行情.xls",1,encoding = "UTF-8")

bond_112087 <- bond_HQ[bond_HQ$债券代码_BdCd=='112087',]
bond_112087 <- xts(bond_112087[,-c(1:3)],order.by = as.Date(bond_112087$交易日期_TrdDt))

bond_112072 <- bond_HQ[bond_HQ$债券代码_BdCd=='112072',]
bond_112072 <- xts(bond_112072[,-c(1:3)],order.by = as.Date(bond_112072$交易日期_TrdDt))

bond_112061 <- bond_HQ[bond_HQ$债券代码_BdCd=='112061',]
bond_112061 <- xts(bond_112061[,-c(1:3)],order.by = as.Date(bond_112061$交易日期_TrdDt))

View(bond_112087)

chartSeries(to.weekly(bond_112087),theme = 'black',name='债券合约:112087 K线图',up.col = 'red',dn.col = 'green')
chartSeries(to.weekly(bond_112072),theme = 'black',name='债券合约:112072 K线图',up.col = 'red',dn.col = 'green')
chartSeries(to.weekly(bond_112061),theme = 'black',name='债券合约:112061 K线图',up.col = 'red',dn.col = 'green')
addMACD()
addBBands()

