rm(list=ls())
library(cvar)


#VaR Illustration
VaR_95 <- VaR(qnorm)
ES_95 <- ES(qnorm)

x <- seq(-4, 4, by = 0.01)
y <- dnorm(x)

#Confidence level behavior 
clvls <- seq(0.9,0.99, by = 0.01)
clvls
VaRs <- numeric(length(clvls)) 
ESs <- numeric(length(clvls))
for(i in 1:length(clvls)){
  VaRs[i] <- VaR(dist = qnorm,p_loss = (1-clvls[i]))
  ESs[i] <- ES(dist = qnorm,p_loss = (1-clvls[i]))
}

par(mfrow = c(1,2))
plot(x, y, type = "l", ylab = "Probability density", xlab = "Loss")
grid(nx = NA, ny = NULL, lty = 1)
abline(h = 0)
abline(v = VaR_95)
text(x = 1.3,y = 0.39, labels = "VaR", cex = 0.7)
polygon(c(x[x >= VaR_95], VaR_95), c(y[x >= VaR_95],0), border = NA, density = 35)
abline(v = ES_95, lty = 2)
text(x = 2.4,y = 0.39, labels = "ES", cex = 0.7)
text(x = -3.85,y = 0.395,labels = "(a)")


plot(x = clvls,y = VaRs, type = "l", ylim = c(min(VaRs),max(ESs)), xlab = "Confidence levels", ylab = "VaR/ES")
grid(lty = 1)
text(x = 0.98,y = 1.95, labels = "VaR", cex = 0.7)
lines(x = clvls,y = ESs, type = "l", lty = 2)
text(x = 0.98,y = 2.33, labels = "ES", cex = 0.7)
text(x = 0.902,y = 2.64,labels = "(b)")
