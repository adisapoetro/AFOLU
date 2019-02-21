###3.B.2 Cropland

## Biomass C
# L.H=(f.PWB*A*HL)/HC #Calculates the losses of perennial woody biomass C from harvests
# A.D=(f.CR.B*A)+A.OD #Calculates the total area of disturbance
# L.D=A.D*AGB*(1+R)*CF*f.D #Calculates the losses of biomass C from disturbance (IPCC 2006 Vol4 Ch2 Eq2.14)
# BC.G=f.PWB*A*G #Calculates the total gains in biomass C (IPCC 2006 Vol4 Ch2 Eq2.9&10)
# BC.L=L.H+L.D #Calculates the total losses of biomass C (IPCC 2006 Vol4 Ch2 Eq2.11)
# BC.C=A*(((AGB.F*(1+R.F)*CF.F-AGB.I*(1+R.I)*CF.I))/T.LUC) #Calculates the initial change in biomass C stocks from land use change (IPCC 2006 Vol4 Ch2 Eq2.16)
# Biomass.C=BC.G-BC.C-BC.L #Calculates total changes in biomass C stocks using the gain-loss method (IPCC 2006 Vol4 Ch2 Eq2.7&15)
## Dead Organic Matter C
# DOM=DW*CF.DW+LT*CF.LT #Calculates dead organic matter C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.17)
# DOM.C=A*((DOM.F-DOM.I)/T.LUC) #Calculates total changes in dead organic matter C stocks (IPCC 2006 Vol4 Ch2 Eq2.23)
## Soil C
# SCF.LU=f.C.LU*SCF
# SCF.MG=f.C.MG*SCF
# SCF.I=f.C.I*SCF
# SOC=A*SOC.R*SCF.LU*SCF.MG*SCF.I #Calculates soil organic C stock for a given year (IPCC 2006 Vol4 Ch2 Eq2.25)
# MS.C=(SOC.F-SOC.I)/T.SCF #Calculates changes in mineral soil C (IPCC 2006 Vol4 Ch2 Eq2.25)
# OS.C=A.OS*EF.CO2.OS #Calculates annual C loss from drained organic soils (IPCC 2006 Vol4 Ch2 Eq2.26)
# Soil.C=MS.C-OS.C #Calculates total changes in soil C stocks (IPCC 2006 Vol4 Ch2 Eq2.24)
# LU.C=Biomass.C+DOM.C+Soil.C #Calculates the total change in C stocks (IPCC 2006 Vol4 Ch2 Eq2.3)
# LU.GHG=LU.C*(44/12)*10^-3 #Calculates the GHG emissions from changes in C stocks

# A          = f(Year,LUC,LU.Subcategory,Soil.Type,Crop);    activity data
# A.OD       = f(Year,LUC,LU.Subcategory);                   activity data 
# A.OS       = f(Year,LUC,LU.Subcategory,Soil.Type);             activity data
# f.CR.B     = f(Crop)
# f.PWB      = f(LU.Subcategory,Crop)
# HC         = f(Crop)
# HL         = f(Crop)
# R          = f(LU.Subcategory);
# CF         = f(LU.Subcategory,Pool);
# AGB        = f(LUC,LU.Subcategory,Crop);
# f.D        = f(LU.Subcategory);
# G          = f(Crop);
# T.LUC      = f(LUC);
# DW         = f(LU.Subcategory);       
# LT         = f(LU.Subcategory);
# SOC.R      = f(Soil.Type);
# f.C.LU     = f(Crop,Crop.LU);
# f.C.MG     = f(Crop,Crop.Management);
# f.C.I      = f(Crop,Crop.Inputs);
# SCF        = f(Crop.LU,Crop.Management,Crop.Inputs);
# T.SCF      = f(LUC);
# EF.CO2.OS  = f(LU.Subcategory);