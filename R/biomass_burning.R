###3.C.1 Emissions from Biomass Burning

# M.B = AGB + DOC                                             #Calculates the mass of fuel available for combustion
# BB.CO2 = A.B * M.B * C.F * EF.CO2.BB * 10^-3                #Calculates annual CO2 emissions from biomass burning (IPCC 2006 Vol4 Ch2 Eq2.27)
# BB.CH4 = A.B * M.B * C.F * EF.CH4.BB * 10^-3                #Calculates annual CH4 emissions from biomass burning (IPCC 2006 Vol4 Ch2 Eq2.27)
# BB.N2O = A.B * M.B * C.F * EF.N2O.BB * 10^-3                #Calculates annual N2O emissions from biomass burning (IPCC 2006 Vol4 Ch2 Eq2.27)
# BB.GHG = ((BB.CH4 * GWP.CH4) + (BB.N2O * GWP.N2O)) * 10^-3  #Calculates annual GHG emissions from biomass burning

# A.B        = f(Year,Land.Use.Subcategory);  activity data
# M.B        = f(Land.Use.Subcategory)
# C.F        = f(Land.Use.Subcategory)
# EF.CO2.BB  = f(Land.Use)
# EF.N2O.BB  = f(Land.Use)
# EF.CH4.BB  = f(Land.Use)
# GWP.N2O    = single value
# GWP.CH4    = single value

biomass_burning <- function(burnt_area, BB.EF.CH4, BB.EF.N2O) {
  #equations
}