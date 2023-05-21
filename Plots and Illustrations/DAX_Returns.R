
library(quantmod)

getSymbols("^GDAXI", from = "2013-01-01", to = "2023-01-01")

dax_returns <- dailyReturn(GDAXI)

plot(dax_returns, main = "DAX Returns (2013-2023)", ylab = "Daily Returns")
