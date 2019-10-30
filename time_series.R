install.packages("forecast")
library(forecast)
input <-c(47,68,118,218,329,401,540,926)
tsscore<-ts(input,start=c(2011))
tsscore
plot(tsscore)
tsscore
tsscore2 <- auto.arima(tsscore) # 시계열 데이터 이용  
tsscore2

tsscore3 <- forecast(tsscore2)   # 미래값 예측-시계열모형 예측 forecas
tsscore3
plot(tsscore3) 