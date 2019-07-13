
#PA package port data
data("managers")


charts.PerformanceSummary(managers[,c("US 10Y TR","HAM2")])
table.CalendarReturns(managers[,c("US 10Y TR")])
table.Stats(managers[,c("US 10Y TR")])

chart.Boxplot(managers)
chart.Histogram(managers[,9])

layout(rbind(c(1,2),c(3,4)))
 chart.Histogram(managers[,1,drop=F], main = "Plain", methods = NULL)
 chart.Histogram(managers[,1,drop=F], main = "Density", breaks=40, methods = c("add.density", "add.normal"))
 chart.Histogram(managers[,1,drop=F], main = "Skew and Kurt", methods = c("add.centered", "add.rug"))
 chart.Histogram(managers[,1,drop=F], main = "Risk Measures", methods = c("add.risk"))
  
   
chart.RiskReturnScatter(managers[,1:8], Rf=.03/12, add.boxplots = TRUE)

?chart.RiskReturnScatter



DGS10
