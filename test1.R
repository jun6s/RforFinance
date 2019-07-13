library(tidyverse)
library(magrittr)
library(lubridate)
library(xts)
library(quantmod)
library(PerformanceAnalytics)

today <- Sys.Date()


#BBG?O?ł̃f?[?^?擾
getSymbols("FB",from="2019-04-01",to=today)
getSymbols("AAPL",from="2019-04-01",to=today)
getSymbols("AMZN",from="2019-04-01",to=today)

#FX
getFX("USD/JPY",from="2019-04-01",to=today)


#Treasury
USbondssymbols <- paste0("DGS",c(1,2,3,5,7,10,20,30))

ust.xts <- xts()
for (i in 1:length( USbondssymbols ) ) {
  ust.xts <- merge( 
    ust.xts,
    getSymbols( 
     USbondssymbols[i],
     auto.assign = FALSE,
     src = "FRED",
     from="2019-04-01",
     to="2019-07-12"
    )
  )
}

ust.xts <- ust.xts["2019-04-01::"]
