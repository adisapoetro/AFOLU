###3.B.3 Grassland

## Biomass C
# A.D=A.B+A.OD #Calculates the total area of disturbance
# L.D=A.D*AGB*(1+R)*CF*f.D #Calculates the losses of biomass C from disturbance (IPCC 2006 Vol4 Ch2 Eq2.14)
# BC.L=L.D #Calculates the total losses of biomass C (IPCC 2006 Vol4 Ch2 Eq2.11)
# BC.C=A*(((AGB.F*(1+R.F)*CF.F-AGB.I*(1+R.I)*CF.I))/T.LUC) #Calculates the initial change in biomass C stocks from land use change (IPCC 2006 Vol4 Ch2 Eq2.16)
# Biomass.C=-BC.C-BC.L #Calculates total changes in biomass C stocks using the gain-loss method (IPCC 2006 Vol4 Ch2 Eq2.7&15)
## Dead Organic Matter C
# DOM=DW*CF.DW+LT*CF.LT #Calculates dead organic matter C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.17)
# DOM.C=A*((DOM.F-DOM.I)/T.LUC) #Calculates total changes in dead organic matter C stocks (IPCC 2006 Vol4 Ch2 Eq2.23)
## Soil C
# SCF.MG=f.G.MG*SCF
# SCF.I=f.G.I*SCF
# SOC=A*SOC.R*SCF.LU*SCF.MG*SCF.I #Calculates soil organic C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.25)
# MS.C=(SOC.F-SOC.I)/T.SCF #Calculates changes in mineral soil C (IPCC 2006 Vol4 Ch2 Eq2.25)
# OS.C=A.OS*EF.CO2.OS #Calculates annual C loss from drained organic soils (IPCC 2006 Vol4 Ch2 Eq2.26)
# Soil.C=MS.C-OS.C #Calculates total changes in soil C stocks (IPCC 2006 Vol4 Ch2 Eq2.24)
# LU.C=Biomass.C+DOM.C+Soil.C #Calculates the total change in C stocks (IPCC 2006 Vol4 Ch2 Eq2.3)
# LU.GHG=LU.C*(44/12)*10^-3 #Calculates the GHG emissions from changes in C stocks

# A          = f(Year,LUC,LU.Subcategory,Soil.Type,Crop);    activity data 
# A.B        = f(Year,LUC,LU.Subcategory);                   activity data 
# A.OD       = f(Year,LUC,LU.Subcategory);                   activity data 
# A.OS       = f(Year,LUC,LU.Subcategory,Soil.Type);             activity data
# R          = f(LU.Subcategory);
# CF         = f(LU.Subcategory,Pool);
# AGB        = f(LUC,LU.Subcategory,Crop);
# f.D        = f(LU.Subcategory);
# T.LUC      = f(LUC);
# DW         = f(LU.Subcategory);       
# LT         = f(LU.Subcategory);
# SOC.R      = f(Soil.Type);
# SCF.LU     = f(LU.Subcategory);
# f.G.MG     = f(LU.Subcategory,Grassland.Management);
# f.G.I      = f(LU.Subcategory,Grassland.Management);
# SCF        = f(Crop.LU,Crop.Management,Crop.Inputs);
# T.SCF      = f(LUC);
# EF.CO2.OS  = f(LU.Subcategory);