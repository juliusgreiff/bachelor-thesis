paths <- c("MonteCarlo_sGARCH_Sim1.R",
           "MonteCarlo_gjrGARCH_Sim1.R",
           "MonteCarlo_eGARCH_Sim1.R",
           "MonteCarlo_sGARCH_Sim2.R",
           "MonteCarlo_gjrGARCH_Sim2.R",
           "MonteCarlo_eGARCH_Sim2.R",
           "MonteCarlo_sGARCH_Sim3.R",
           "MonteCarlo_gjrGARCH_Sim3.R",
           "MonteCarlo_eGARCH_Sim3.R",
           "MonteCarlo_sGARCH_Sim4.R",
           "MonteCarlo_gjrGARCH_Sim4.R",
           "MonteCarlo_eGARCH_Sim4.R")

n.sim = 1000

for(file in paths){
  source(file)
}

df_Error <- rbind(round(df_Error_sGARCH_Sim1,3),
                  round(df_Error_gjrGARCH_Sim1,3),
                  round(df_Error_eGARCH_Sim1,3),
                  round(df_Error_sGARCH_Sim2,3),
                  round(df_Error_gjrGARCH_Sim2,3),
                  round(df_Error_eGARCH_Sim2,3),
                  round(df_Error_sGARCH_Sim3,3),
                  round(df_Error_gjrGARCH_Sim3,3),
                  round(df_Error_eGARCH_Sim3,3),
                  round(df_Error_sGARCH_Sim4,3),
                  round(df_Error_gjrGARCH_Sim4,3),
                  round(df_Error_eGARCH_Sim4,3))
                  

