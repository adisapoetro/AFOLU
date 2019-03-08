###3.A.1 Enteric Fermentation

# EF.GHG = EF.CH4 * GWP.CH4   # Calculates the GHG emissions from enteric fermentation

### 3.A.2 CH4 and Direct N2O Emissions from Manure Management

# MM.GHG.D = (MM.N2O.D * GWP.N2O * 10^-6) + (MM.CH4 * GWP.CH4)   # Calculates the direct GHG emissions from manure management

### 3.C.6 Indirect N2O Emissions from Manure Management

# MM.GHG.I = MM.N2O.I * GWP.N2O * 10^-6   # Calculates the indirect GHG emission from manure management

### 3.C.7 Rice Cultivation

# FR.GHG = FR.CH4 * GWP.CH4   #Calculates GHG emissions from rice cultivation

AFOLU <- function(L.AD, L.EF = IPCC.2006.L.EF,
                  MM.AD, MM.EF = IPCC.2006.MM.EFSA.EF,
                  SA.AD, SA.EF = IPCC.2006.SA.EF) {
  
  EF.MM <- livestock(L.AD, L.EF, MM.AD, MM.EF)[1]
  EF.MM.LT <- livestock(L.AD, L.EF, MM.AD, MM.EF)[2]
  L.U <- soil_amendments(SA.AD, SA.EF)[1]
  
  
  # Return a list with total lime and urea CO2 emissions and N inputs by year
  return(NA.Y, CA.Y)
}