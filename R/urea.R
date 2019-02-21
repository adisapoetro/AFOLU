###3.C.3 Urea Application

# U.CO2 = ifelse(C.Type == "Urea", M * EF.CO2.U * (44/12) * 10^-6, 0)  #Calculates the CO2 emissions from urea application to managed soils (IPCC 2006, Vol 4 Ch 11, Eq 11.13)
# U.GHG = U.CO2

# M          = f(Year,Amendment);      activity data
# EF.CO2.U   = single value

urea <- function(urea, U.EF.CO2) {
  #equations
}