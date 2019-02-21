###3.A.1 Enteric Fermentation

# EF.CH4 = (N * EF.CH4.EF) / 10^6  #Calculates CH4 emissions from enteric fermentation (IPCC 2006, Vol 4 Ch 10, Eq 10.19, 10.20)) group_by(Year)
# EF.GHG = EF.CH4 * GWP.CH4)       #Converts CH4 to CO2-eq

# N          = f(Year,Livestock.Type);         activity data
# EF.CH4.EF  = f(Livestock.Type);              IPCC = f(Livestock.Type,Region,AAT)
# GWP.CH4    = single value

enteric_fermentation <- function(livestock, EF.EF.CH4) {
  
  #Estimates enteric fermentation CH4 emissions by year and livestock type
  EF.Y.L = EF %>% mutate(Year=as.factor(Year),
                         EF.CH4 = (N * EF.CH4.EF) / 10^6, #Calculates CH4 emissions from enteric fermentation (IPCC 2006, Vol 4 Ch 10, Eq 10.19, 10.20)) group_by(Year)
                         EF.GHG = EF.CH4 * GWP.CH4) %>%   #Converts CH4 to CO2-eq
           group_by(Year,Livestock.Type) %>%
           summarize(EF.CH4=sum(EF.CH4),
                     EF.GHG=sum(EF.GHG))
  
  #Estimates enteric fermentation CH4 emissions by year
  EF.Y = EF.Y.L %>% group_by(Year) %>%
         summarize(EF.CH4=sum(EF.CH4),
                   EF.GHG=sum(EF.GHG))
  
  return(list(EF.Y,EF.Y.L))
}