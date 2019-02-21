###3.B.4 Wetlands

## Biomass C
# BC.C=A*(((AGB.F*(1+R.F)*CF.F-AGB.I*(1+R.I)*CF.I))/T.LUC) #Calculates the initial change in biomass C stocks from land use change (IPCC 2006 Vol4 Ch2 Eq2.16)
# Biomass.C=-BC.C #Calculates total changes in biomass C stocks using the gain-loss method (IPCC 2006 Vol4 Ch2 Eq2.7&15)
## Dead Organic Matter C
# DOM=DW*CF.DW+LT*CF.LT #Calculates dead organic matter C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.17)
# DOM.C=A*((DOM.F-DOM.I)/T.LUC) #Calculates total changes in dead organic matter C stocks (IPCC 2006 Vol4 Ch2 Eq2.23)
## Soil C
# SOC=A*SOC.R*SCF.LU*SCF.MG*SCF.I #Calculates soil organic C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.25)
# MS.C=(SOC.F-SOC.I)/T.SCF #Calculates changes in mineral soil C (IPCC 2006 Vol4 Ch2 Eq2.25)
# Soil.C=MS.C #Calculates total changes in soil C stocks (IPCC 2006 Vol4 Ch2 Eq2.24)
# LU.C=Biomass.C+DOM.C+Soil.C #Calculates the total change in C stocks (IPCC 2006 Vol4 Ch2 Eq2.3)
# LU.GHG=LU.C*(44/12)*10^-3 #Calculates the GHG emissions from changes in C stocks

# A          = f(Year,LUC,LU.Subcategory,Soil.Type,Crop);    activity data 
# R          = f(LU.Subcategory);
# CF         = f(LU.Subcategory,Pool);
# AGB        = f(LUC,LU.Subcategory,Crop);
# T.LUC      = f(LUC);
# DW         = f(LU.Subcategory);       
# LT         = f(LU.Subcategory);
# SOC.R      = f(Soil.Type);
# SCF.LU     = f(LU.Subcategory);
# T.SCF      = f(LUC);