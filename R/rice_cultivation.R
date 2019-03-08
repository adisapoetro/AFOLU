### 3.C.7 Rice Cultivation

# A.FR = A.H * f.FR                                           #Estimates the area of flooded rice cultivation
# SF.PWR = f.PWR * SF
# SF.WR = f.WR * SF
# SF.OA = (1 + (ROA * CFOA))^0.59
# FR.CH4 = A.FR * EF.CH4.FR * SF.WR * SF.PWR * SF.OA * 10^-6  #Calculates CH4 emissions from rice cultivation (IPCC 2006, Vol 4 Ch 5, Eq 5.1)
# FR.GHG = FR.CH4 * GWP.CH4                                   #Calculates GHG emissions from rice cultivation

## for reference
# SF.WR = Rice.EF %>% filter(Scaling.Factor == "Water Regime during Cultivation") %>% mutate(SF.WR = CP * f.A.FR * SCF) %>% summarize(SF.WR = sum(SF.WR)) %>% pull() #Calculates the scaling factor for the water regime during cultivation incorporating the cultivation period (IPCC 2006 Vol4 Ch5 Table5.12)
# SF.PWR = Rice.EF %>% filter(Scaling.Factor == "Pre-season Water Regime") %>% mutate(SF.PWR = f.A.FR * SCF) %>% summarize(SF.PWR = sum(SF.PWR)) %>% pull() #Calculates the scaling factor for the pre-season water regime (IPCC 2006 Vol4 Ch5 Table 5.13)
# SF.O = Rice.EF %>% filter(Scaling.Factor == "Organic Amendment") %>% mutate(SF.O = ROA * CFOA) %>% #Calculates the scaling factor by organic amendment (IPCC 2006 Vol4 Ch5 Eq5.3)
#   summarize(SF.O = sum(SF.O)) %>% mutate((1 +SF.O)^0.59) %>% pull() #Calculates the scaling factor for organic amendments (IPCC 2006 Vol4 Ch5 Eq5.3)

# A.H        = f(Year,Crop);                 activity data
# f.FR       = f(Year,Crop);                 activity data
# f.PWR      = f(Rice.PWR.Mgmt);             activity data
# f.WR       = f(Rice.WR.Mgmt);              activity data
# CP         = f(Rice.WR.Mgmt);              activity data
# ROA        = f(Rice.Amendment);            activity data
# CFOA       = f(Rice.Amendment);  
# SF         = f(Rice.PWR.Mgmt,Rice.WR.Mgmt)
# EF.CH4.FR  = single value
# GWP.CH4    = single value

rice_cultivation <- function(CM.AD, RC.EF = IPCC.2006.RC.EF) {
  
  # Format the activity data and emission factors
  RC.AD <- CM.AD %>% filter(Crop.Type == "Flooded Rice")
  T.A.H <- CM.AD %>% group_by(Year) %>% summarize(T.A.H = sum(A.H))
  f.FR <- left_join(RC.AD, T.A.H, by = "Year") %>% mutate(f.FR = A.H / T.A.H) %>% select(Year,f.FR)
  RC <- left_join(RC.AD, RC.EF, by = "Crop.Type")
  
  # Estimates total CH4 emissions from rice cultivations by year
  RC.Y <- RC %>% mutate(Year = as.factor(Year),
                        EF.CH4 = (N * EF.CH4.EF) / 10^6, # Estimates CH4 emissions from enteric fermentation
                        MM.CH4 = (N * EF.CH4.MM) / 10^6, # Estimates CH4 emissions from manure management
                        MM.N2O.D = N * Nex * (TAM / 1000) * 365 * f.MMS * EF.N2O.MM * (44/28), # Estimates direct N2O emissions from manure management
                        MM.N2O.I = N * Nex * (TAM / 1000) * 365 * f.MMS * f.DV.MMS * EF.N2O.DV * (44 / 28), # Estimates indirect N2O emissions from manure management
                        N.UD = ifelse(MMS == "PRP", N * Nex * (TAM / 1000) * 365 * f.MMS, 0), # Estimates the N deposited on pasture, range and paddock
                        N.MA = ifelse(MMS == "PRP", 0, N * f.MMS * (Nex * (TAM / 1000) * 365 * (1 - f.L.MMS) + N.Bed)), # Estimates the managed manure N available for application
                        N.M = N.MA * (1 - (f.FEED + f.FUEL + f.CNST))) %>% # Estimates the animal manure applied to soils
                 group_by(Year) %>%
                 summarize(RC.CH4 = sum(RC.CH4))
  
  # Returns a list of 1) CH4 emissions from rice cultivation by year
  #                   2) the fraction of flooded rice within total croplands
  return(RC.Y, f.FR)
}