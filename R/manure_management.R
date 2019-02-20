###3.A.2 Manure Management (Direct)

#MM.CH4=(N*EF.CH4.MM)/10^6 #Calculates CH4 emissions from manure management
#MM.N2O.D=N*Nex*(TAM/1000)*365*f.MMS*EF.N2O.MM*(44/28) #Calculates direct N2O emissions from manure management (IPCC 2006, Vol 4 Ch 10, Eq 10.25)
#MM.GHG.D=(MM.N2O.D*GWP.N2O*10^-6)+(MM.CH4*GWP.CH4) #Calculates the direct GHG emissions from manure management

# N          = f(Year,Livestock.Type);         activity data
# f.MMS      = f(Livestock.Type,MMS);          activity data
# EF.CH4.MM  = f(Livestock.Type);              IPCC = f(Livestock.Type,Region,AAT)
# Nex        = f(Livestock.Type);              IPCC = f(Livestock.Type,Region)
# TAM        = f(Livestock.Type);              IPCC = f(Livestock.Type,Region)
# EF.N2O.MM  = f(MMS);                         IPCC = f(MMS)
# GWP.N2O    = single value;                   IPCC
# GWP.CH4    = single value;                   IPCC

manure_management <- function(livestock, MM.EF.CH4, MM.EF.N2O) {
  #equations
}