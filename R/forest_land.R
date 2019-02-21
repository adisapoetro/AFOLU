###3.B.1 Forest Land

## Biomass C
# A.D=A.B+A.OD #Calculates the total area of disturbance
# L.WR=WR*BCEF.R*(1+R)*CF.B #Calculates the losses of biomass C from wood removals (IPCC 2006 Vol4 Ch2 Eq2.12)
# L.FW=(FW*f.FW.WT*BCEF.R*(1+R)+FW*(1-f.FW.WT)*WD)*CF.B #Calculates the losses of biomass C from fuelwood removal (IPCC 2006 Vol4 Ch2 Eq2.13)
# L.D=A.D*AGB*(1+R)*CF.B*f.D #Calculates the losses of biomass C from disturbance (IPCC 2006 Vol4 Ch2 Eq2.14)
# BC.G=A*G*(1+R)*CF.B #Calculates the total gains in biomass C (IPCC 2006 Vol4 Ch2 Eq2.9&10)
# BC.L=L.WR+L.FW+L.D #Calculates the total losses of biomass C (IPCC 2006 Vol4 Ch2 Eq2.11)
# BC.C=A*(((AGB.F*(1+R.F)*CF.B.F-AGB.I*(1+R.I)*CF.B.I))/T.LUC) #Calculates the initial change in biomass C stocks from land use change (IPCC 2006 Vol4 Ch2 Eq2.16)
# Biomass.C.GL=BC.G-BC.C-BC.L #Calculates total changes in biomass C stocks using the gain-loss method (IPCC 2006 Vol4 Ch2 Eq2.7&15)
# BC.S=A*V*BCEF.S*(1+R)*CF.B #Calculates biomass C stocks using the stock difference method (IPCC 2006, Vol 4 Ch 2, Eq 2.8)
# Biomass.C.SD=(BC.S.F-BC.S.I)/T.BI #Calculates total changes in biomass C stocks using the stock difference method (IPCC 2006 Vol4 Ch2 Eq2.8)
# Biomass.C=ifelse(Biomass.Method=="Gain-Loss",Biomass.C.GL,Biomass.C.SD) #Assigns Biomass.C based on the method selected
## Dead Organic Matter C
# DOM=DW.C*CF.DW+LT.C*CF.LT #Calculates dead organic matter C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.17)
# DOM.C=A*((DOM.F-DOM.I)/T.LUC) #Calculates total changes in dead organic matter C stocks (IPCC 2006 Vol4 Ch2 Eq2.23)
## Soil C
# SOC=A*SOC.R*SCF.LU*SCF.MG*SCF.I #Calculates soil organic C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.25)
# MS.C=(SOC.F-SOC.I)/T.SCF #Calculates changes in mineral soil C (IPCC 2006 Vol4 Ch2 Eq2.25)
# OS.C=A.OS*EF.CO2.OS #Calculates annual C loss from drained organic soils (IPCC 2006 Vol4 Ch2 Eq2.26)
# Soil.C=MS.C-OS.C #Calculates total changes in soil C stocks (IPCC 2006 Vol4 Ch2 Eq2.24)
# LU.C=Biomass.C+DOM.C+Soil.C #Calculates the total change in C stocks (IPCC 2006 Vol4 Ch2 Eq2.3)
# LU.GHG=LU.C*(44/12)*10^-3 #Calculates the GHG emissions from changes in C stocks

# A          = f(Year,LUC,LU.Subcategory,Soil.Type,Crop);    activity data 
# A.B        = f(Year,LUC,LU.Subcategory);                   activity data 
# A.OD       = f(Year,LUC,LU.Subcategory);                   activity data 
# WR         = f(Year,LUC,LU.Subcategory);                   activity data
# FW         = f(Year,LUC,LU.Subcategory);                   activity data
# f.FW.WT    = f(Year),                                      activity data
# A.OS       = f(Year,LUC,LU.Subcategory,Soil.Type);             activity data
# BCEF.R     = f(LU.Subcategory);
# R          = f(LU.Subcategory);
# CF         = f(LU.Subcategory,Pool);
# WD         = f(LU.Subcategory);
# AGB        = f(LUC,LU.Subcategory);
# f.D        = f(LU.Subcategory);
# G          = f(LU.Subcategory);
# V          = f(LU.Subcategory);
# BCEF.S     = f(LU.Subcategory);
# T.LUC      = f(LUC);
# T.BI       = f(LUC);
# DW         = f(LU.Subcategory);       
# LT         = f(LU.Subcategory);
# SOC.R      = f(Soil.Type);
# SCF.LU     = f(LUC,LU.Subcategory,Crop);
# SCF.MG     = f(Crop);
# SCF.I      = f(Crop);
# T.SCF      = f(LUC);
# EF.CO2.OS  = f(LU.Subcategory);