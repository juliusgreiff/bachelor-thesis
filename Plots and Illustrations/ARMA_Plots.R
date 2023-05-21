rm(list=ls())

set.seed(123)
AR1 <- arima.sim(model = list(ar = 0.8), n = 1000)
MA4 <- arima.sim(model = list(ma = c(-0.8, 0.4, 0.2, -0.3)), n = 1000)
ARMA11 <- arima.sim(model = list(ar = 0.6, ma = 0.5), n = 1000)

#bottom, left, top, right
par(mfrow = c(3, 2),     
    oma = c(0, 2.5, 0, 0), #rows of text at the outer margin
    mar = c(2.5, 1.5, 0.5, 1), # space for rows of text at ticks and to separate plots
    mgp = c(1.5, 0.75, 0),    # axis label distance, tick labels distance
    xpd = F)
plot.ts(AR1, xlab = "", ylab = "", las=1, type = "h")
text(x = -160,y = 5.5,labels = "(a)", cex = 1.5, xpd=NA)
acf(AR1, lag.max = 30, main = "", xlab = "", las=1)
plot.ts(MA4, xlab = "", ylab = "", las=1, type = "h")
text(x = -160,y = 3.9,labels = "(b)", cex = 1.5, xpd=NA)
acf(MA4, lag.max = 30, main = "", xlab = "", las=1)
plot.ts(ARMA11, ylab = "", las=1, type = "h")
text(x = -160,y = 5.8,labels = "(c)", cex = 1.5, xpd=NA)
acf(ARMA11, lag.max = 30, main = "", las=1)

