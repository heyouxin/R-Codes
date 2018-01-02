get_Data<-function(stock_num,t_from,t_to,sample_num){
	##stock data
	sample_num<-500;
	stock_num<-"000300.ss"
	t_from<-"2016-01-01"
	t_to<-Sys.Date()
	HS.Data<-getSymbols(stock_num,t_from,t_to,src = "yahoo",auto.assign=FALSE)
	HS300.Data<-na.omit(HS.Data)
	BackTestSample<-HS300.Data[,4]
	BackTestSample<-BackTestSample[c((length(BackTestSample)-sample_num-1):length(BackTestSample))]
	BackTestSample<-coredata(BackTestSample)
	return (BackTestSample)
	}