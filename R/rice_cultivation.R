#3.C.7 Rice Cultivation

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

rice_cultivation <- function(rice_area, RC.EF.CH4) {
  #equations
}