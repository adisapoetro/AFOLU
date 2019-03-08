###N Inputs to from Managed Soils

## Synthetic N Fertilizers
# N.SF = ifelse(N.Type == "Synthetic", M * N.A, 0) #Calculates N applied to managed soils from synthetic fertilizers
# SN.N2O = N.OA * EF.N2O.NI

# M          = f(Amendment,N.Type)
# N.A        = f(Amendment)
# EF.N2O.NI  = single value

## Organic N Amendments
# N.MA = ifelse(MMS == "PRP", 0, N * f.MMS * (Nex * (TAM / 1000) * 365 * (1 - f.L.MMS) + N.Bed))  #Calculates managed manure N available for application (IPCC 2006, Vol 4 Ch 10, Eq 10.34)
# N.M = N.MA * (1 - (f.FEED + f.FUEL + f.CNST))                                                   #Calculates the animal manure applied to soils (IPCC 2006, Vol 4 Ch 11, Eq 11.4)
# N.OOA = ifelse(N.Type == "Organic", M * N.A, 0)                                                 #Calculates N applied to managed soils from other organic amendments
# N.OA = N.OOA + N.M                                                                              #Calculates the total annual organic N applied to soils (IPCC 2006 Vol4 Ch11 eq11.3)
# ON.N2O = N.OA * EF.N2O.NI

# N          = f(Year,Livestock.Type)
# Nex        = f(Livestock.Type)
# TAM        = f(Livestock.Type)
# f.MMS      = f(Livestock.Type,MMS)
# f.L.MMS    = f(Livestock.Type,MMS)
# N.Bed      = f(Livestock.Type)
# f.FEED     = f(Livestock.Type)
# f.FUEL     = f(Livestock.Type)
# f.CNST     = f(Livestock.Type)
# M          = f(Amendment)
# N.A        = f(Amendment)
# EF.N2O.NI  = single value

## Urine and Dung N Deposited on Pasture Range and Paddock
# N.UD = ifelse(MMS == "PRP", N * Nex * (TAM / 1000) * 365 * f.MMS, 0) #Calculates N deposited on pasture, range and paddock (IPCC 2006, Vol 4 Ch 11, Eq 11.5)
# UD.N2O = N.UD * EF.N2O.UD * (44 / 28)                                #Calculates the annual direct N2O emissions from urine and dung deposited to grazed soil (IPCC 2006, Vol 4 Ch 11, Eq 11.1)

# N          = f(Year,Livestock.Type)
# Nex        = f(Livestock.Type)
# TAM        = f(Livestock.Type)
# f.MMS      = f(Livestock.Type,MMS)
# EF.N2O.UD  = f(Livestock.Type)

## N Inputs from Crop Residues
# Y.DM = Y.F * DM.Y                                                                                                    #Calculates the dry weight corrected crop yields
# f.Renew = ifelse(Planting.Cycle == "Annual", 1, 1 / HC)
# AGB.CR = (Y.DM / 1000) * AGR.S + AGR.I                                                                               #Estimates residue aboveground biomass based on IPCC regression
# R.AGR.Y = (AGB.CR * 1000) / Y.DM                                                                                     #Estimates the ratio of aboveground residues to harvested yield
# R.BGR.Y=R.BGR.AGB*(((AGB.CR*1000)+Y.DM)/Y.DM)                                                                        #Estimates the ratio of belowground residues to harvested yield
# N.CR = Y.DM * f.Renew * (((A.H - (A.H * f.CR.B) * C.F) * (1 - f.CR.RG) * R.AGR.Y * N.AGR) + (A.H * R.BGR.Y * N.BGR)) #Estimates the annual N inputs from decomposition of crop residues

# A.H        = f(Year,Crop);  activity data
# Y.F        = f(Year,Crop);                 activity data
# DM.Y       = f(Crop)
# HC         = f(Crop)
# AGR.S      = f(Crop)
# AGR.I      = f(Crop)
# R.BGR.AGB  = f(Crop)
# f.CR.B     = f(Crop)
# C.F        = f(Crop)
# f.CR.RG    = f(Crop)
# N.AGR      = f(Crop)
# N.BGR      = f(Crop)

## N Inputs from Soil Organic Matter Mineralization
# N.SOM = MS.C * (1 / R.C.N) *1000  #Calculates annual amount of N mineralized in mineral soils through loss of Soil C (IPCC 2006, Vol 4 Ch 11, Eq 11.8)

# R.C.N      = f(LUC)
# MS.C (calculated in 3.B.2)

## N Inputs from Drained or Managed Organic Soils
# OS.N2O = A.OS * EF.N2O.OS * (44 / 28)  #Calculates annual N2O emissions from drained organic soils (IPCC 2006, Vol 4 Ch 11, Eq 11.1)

# A.OS       = f(Year,LU.Subcategory);        activity data
# EF.N2O.OS  = f(LU.Subcategory);

### 3.C.4 Direct N2O Emissions from Managed Soils

# f.FR = left_join(Crops.AD,A.CG,by="Year") %>% mutate(f.A.FR=A.H/A.CG) %>% filter(Crop=="Flooded Rice")    #Estimates the fraction of total croplands and grasslands under flooded rice
# NI.N2O = (N.SN + N.ON + N.CR + N.SOM) * (((1 - f.FR) * EF.N2O.NI) + (f.FR * EF.N2O.NI.FR)) * (44 / 28)      #Calculates the total annual direct N2O emissions from N inputs
# UD.N2O = N.UD * EF.N2O.UD * (44 / 28)                                                                       #Calculates the annual direct N2O emissions from urine and dung deposited to grazed soil (IPCC 2006, Vol 4 Ch 11, Eq 11.1)
# MS.N2O.D = NI.N2O + UD.N2O + OS.N2O                                                                         #Calculates the total annual direct N2O emissions from managed soils
# MS.GHG.D = MS.N2O.D * GWP.N2O * 10^-6                                                                       #Calculates the total annual direct GHG emissions from managed soils
# MS.GHG.D = (SN.N2O + ON.N2O + UD.N2O + CR.N2O + SM.N2O + OS.N2O) * GWP.N2O

# EF.N2O.NI     = single value
# EF.N2O.NI.FR  = single value
# EF.N2O.UD     = single value
# GWP.N2O       = single value

#3.C.5 Indirect N2O Emissions from Managed Soils

# VD.N2O.I = ((N.SN * f.V.SN) + ((N.ON + N.UD) * f.V.ON)) * EF.N2O.DV * (44/28)         #Calculates the total annual indirect N2O emissions from atmospheric deposition of volatilized N (IPCC 2006 Vol4 Ch11 Eq11.9)
# f.LR = A.W + A.I / A.CG                                                               #Estimates the area subject to leaching and runoff
# LR.N2O.I = (N.SN + N.ON + N.UD + N.CR + N.SOM) * f.A.LR * f.LR * EF.N2O.LR * (44/28)  #Calculates the total annual indirect N2O emissions from leaching and runoff of N additions (IPCC 2006 Vol4 Ch11 Eq11.10)
# MS.N2O.I = VD.N2O.I + LR.N2O.I                                                        #Calculates the total annual indirect N2O emissions from managed soils
# MS.GHG.I = MS.N2O.I * GWP.N2O * 10^-6                                                 #Calculates the total annual indirect GHG emissions from managed soils

# f.V.SN     = single value
# f.V.ON     = single value
# EF.N2O.DV  = single value
# f.A.LR
# A.W
# A.I
# A.CG
# EF.N2O.LR  = single value
# GWP.N2O    = single value

managed_soil <- function(L.AD, L.EF = IPCC.2006.L.EF,
                         MM.AD, MM.EF = IPCC.2006.MM.EFSA.EF,
                         SA.AD, SA.EF = IPCC.2006.SA.EF) {
  
  # Format the activity data and emission factors
  L.N <- livestock(L.AD, L.EF, MM.AD, MM.EF)[4]
  A.N <- soil_amendments(SA.AD, SA.EF)[2]
  CR.N <- crop_management(CM.AD, CM.EF)[1]
  S.N <- soils(LUC.AD, LUC.EF)[1]
  
  # Estimates total enteric fermentation and manure management GHG emissions and N inputs from livestock by year and livestock type
  MS <- T.N %>% mutate(Year = as.factor(Year),
                       NI.N2O = (N.SN + N.ON + N.CR + N.SOM) * (((1 - f.FR) * EF.N2O.NI) + (f.FR * EF.N2O.NI.FR)) * (44 / 28),
                       UD.N2O = N.UD * EF.N2O.UD * (44 / 28),
                       OS.N2O = A.OS * EF.N2O.OS * (44 / 28))

  # Returns a list of N2O emissions from managed soil by year
  return(MS)
}