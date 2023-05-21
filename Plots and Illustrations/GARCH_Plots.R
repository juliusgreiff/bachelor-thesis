library(rugarch)

pars <- list(mu = 0,
             omega = 0.5,
             alpha1 = 0.1,
             beta1 = 0.85)

specs <- ugarchspec(variance.model = list(model = "sGARCH"),
                    mean.model = list(armaOrder = c(0,0)),
                    fixed.pars = pars)

garch <- ugarchpath(specs, 1000)

par(mfrow = c(2, 1),     
    oma = c(0, 2.5, 0, 0), #rows of text at the outer margin
    mar = c(2.5, 1.5, 0.5, 1), # space for rows of text at ticks and to separate plots
    mgp = c(1.5, 0.75, 0),    # axis label distance, tick labels distance
    xpd = F)
plot(garch@path$seriesSim, type = "h", xlab = "", las=1, ylab = "")
text(x = -130,y = 13,labels = "(a)", cex = 1, xpd=NA)
plot(garch@path$sigmaSim, type = "h", xlab = "", las=1, ylab = "")
text(x = -130,y = 6,labels = "(b)", cex = 1, xpd=NA)

