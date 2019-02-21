###3.C.2 Liming

# L.CO2 = ifelse(C.Type == "Lime", M * EF.CO2.L * (44/12) * 10^-3, 0)  #Calculates the CO2 emissions from lime application to managed soils (IPCC 2006, Vol 4 Ch 11, Eq 11.12)
# L.GHG = L.CO2

# M          = f(Year,Amendment);      activity data
# EF.CO2.L   = f(Amendment)

liming <- function(lime, L.EF.CO2) {
  #equations
}