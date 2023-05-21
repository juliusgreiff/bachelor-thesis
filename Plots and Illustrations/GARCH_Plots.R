pars <- list(mu = 0,
             omega = 0.5,
             alpha1 = 0.1,
             beta1 = 0.85)

specs <- ugarchspec(variance.model = list(model = "sGARCH"),
                    mean.model = list(armaOrder = c(0,0)),
                    fixed.pars = pars)

garch <- ugarchpath(specs, 1000)

par(mfrow = c(2, 1),     
    oma = c(0, 1, 0, 0), #rows of text at the outer margin
    mar = c(2.5, 1.5, 0.5, 1), # space for rows of text at ticks and to separate plots
    mgp = c(1.5, 0.75, 0),    # axis label distance, tick labels distance
    xpd = F)
plot(garch@path$seriesSim, type = "h", xlab = "", ylab = "")
text(x = 10,y = 9,labels = "(a)")
plot(garch@path$sigmaSim, type = "h", xlab = "", ylab = "")
text(x = 10,y = 5.3,labels = "(b)")

