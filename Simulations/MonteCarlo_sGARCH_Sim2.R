library(rugarch)
library(cvar)

VaR_sGARCH_Sim2 <- matrix(data = NA,nrow = n.sim,ncol = 3)
ES_sGARCH_Sim2 <- matrix(data = NA, nrow = n.sim,ncol = 3)

pars <- list(mu = 0,
             omega = 0.5,
             alpha1 = 0.3,
             beta1 = 0.2)

specs <- ugarchspec(variance.model = list(model = "sGARCH"),
                    mean.model = list(armaOrder = c(0,0)),
                    fixed.pars = pars)

sGARCH_specs <- ugarchspec(variance.model = list(model = "sGARCH"),
                           mean.model = list(armaOrder = c(0,0)))

gjrGARCH_specs <- ugarchspec(variance.model = list(model = "gjrGARCH"),
                             mean.model = list(armaOrder = c(0,0)))

eGARCH_specs <- ugarchspec(variance.model = list(model = "eGARCH"),
                           mean.model = list(armaOrder = c(0,0)))

for(i in 1:n.sim){
  
  n <- 500
  
  garch <- ugarchpath(specs, n)
  
  sGARCH_fit <- ugarchfit(sGARCH_specs,garch@path$seriesSim,solver = "hybrid",solver.control = list(tol = 1e-12))
  
  gjrGARCH_fit <- ugarchfit(gjrGARCH_specs,garch@path$seriesSim,solver = "hybrid",solver.control = list(tol = 1e-12))
  
  eGARCH_fit <- ugarchfit(eGARCH_specs,garch@path$seriesSim,solver = "hybrid",solver.control = list(tol = 1e-12))
  
  
  true_VaR <- garch@path$sigmaSim[n]*VaR(qnorm)
  true_ES <- garch@path$sigmaSim[n]*ES(qnorm)
  
  L <- as.numeric(garch@path$seriesSim)
  
  s_sig2 <- numeric(n)
  s_sig2[1] <- var(L)
  for (t in 2:n) {
    s_sig2[t] <- sGARCH_fit@fit$coef[2] + sGARCH_fit@fit$coef[3] * L[t-1]^2 + sGARCH_fit@fit$coef[4] * s_sig2[t-1]
  }
  sVaR <- sqrt(s_sig2[n])*VaR(qnorm)
  sES <- sqrt(s_sig2[n])*ES(qnorm)
  
  gjr_sig2 <- numeric(n)
  gjr_sig2[1] <- var(L)
  for (t in 2:n) {
    gjr_sig2[t] <- gjrGARCH_fit@fit$coef[2] + gjrGARCH_fit@fit$coef[3] * L[t-1]^2 + gjrGARCH_fit@fit$coef[4] * gjr_sig2[t-1] + gjrGARCH_fit@fit$coef[5] * L[t-1]^2*(0+(L[t-1]<0))
  }
  gjrVaR <- sqrt(gjr_sig2[n])*VaR(qnorm)
  gjrES <- sqrt(gjr_sig2[n])*ES(qnorm)
  
  e_sig2 <- numeric(n)
  e_sig2[1] <- var(L)
  for (t in 2:n) {
    lnsig2 <- eGARCH_fit@fit$coef[2] + eGARCH_fit@fit$coef[5] * ((abs(L[t-1])/sqrt(e_sig2[t-1])) - sqrt(2/pi)) + eGARCH_fit@fit$coef[3] * (L[t-1]/sqrt(e_sig2[t-1])) + eGARCH_fit@fit$coef[4] * log(e_sig2[t-1])
    e_sig2[t] <- exp(lnsig2)
  }
  eVaR <- sqrt(e_sig2[n])*VaR(qnorm)
  eES <- sqrt(e_sig2[n])*ES(qnorm)
  
  
  VaR_sGARCH_Sim2[i,] <- c(sVaR - true_VaR, gjrVaR - true_VaR, eVaR - true_VaR)
  ES_sGARCH_Sim2[i,] <- c(sES - true_ES , gjrES - true_ES , eES - true_ES )
  
}

df_Error_sGARCH_Sim2 <- data.frame(matrix(nrow = 2,ncol = 3))
df_Error_sGARCH_Sim2[1,] <- sqrt(colMeans(VaR_sGARCH_Sim2^2))
df_Error_sGARCH_Sim2[2,] <- sqrt(colMeans(ES_sGARCH_Sim2^2))

print(df_Error_sGARCH_Sim2)


