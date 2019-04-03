###3.A.1 Enteric Fermentation

# EF.CH4 = (N * EF.CH4.EF) / 10^6  #Calculates CH4 emissions from enteric fermentation (IPCC 2006, Vol 4 Ch 10, Eq 10.19, 10.20)

# N          = f(Year, Livestock.Type);        activity data
# EF.CH4.EF  = f(Livestock.Type);              IPCC = f(Livestock.Type,Region,AAT)

### 3.A.2 CH4 and Direct N2O Emissions from Manure Management

# MM.CH4 = (N * EF.CH4.MM) / 10^6                                        #Calculates CH4 emissions from manure management
# MM.N2O.D = N * Nex * (TAM / 1000) * 365 * f.MMS * EF.N2O.MM * (44/28)  #Calculates direct N2O emissions from manure management (IPCC 2006, Vol 4 Ch 10, Eq 10.25)

# N          = f(Year, Livestock.Type);        activity data
# f.MMS      = f(Livestock.Type, MMS);         activity data
# EF.CH4.MM  = f(Livestock.Type);              IPCC = f(Livestock.Type, Region, AAT)
# Nex        = f(Livestock.Type);              IPCC = f(Livestock.Type, Region)
# TAM        = f(Livestock.Type);              IPCC = f(Livestock.Type, Region)
# EF.N2O.MM  = f(MMS);                         IPCC = f(MMS)

### 3.C.6 Indirect N2O Emissions from Manure Management

# MM.N2O.I = N * Nex * (TAM / 1000) * 365 * f.MMS * f.DV.MMS * EF.N2O.DV * (44 / 28)  # Estimates indirect N2O emissions from manure management (IPCC 2006, Vol 4 Ch 10, Eq 10.26, 10.27)

# N          = f(Year, Livestock.Type);        activty data
# f.MMS      = f(Livestock.Type, MMS);         activty data
# Nex        = f(Livestock.Type);              IPCC = f(Livestock.Type, Region)
# TAM        = f(Livestock.Type);              IPCC = f(Livestock.Type, Region)
# f.DV.MMS   = f(Livestock.Type, MMS);         IPCC = f(Livestock.Type, MMS)  
# EF.N2O.DV  = single value

### Urine and Dung N Deposited on Pasture Range and Paddock

# N.UD = N * Nex * (TAM / 1000) * 365   # Estimates N deposited on pasture, range and paddock (IPCC 2006, Vol 4 Ch 11, Eq 11.5)

# N          = f(Year,Livestock.Type)
# Nex        = f(Livestock.Type)
# TAM        = f(Livestock.Type)
# f.MMS      = f(Livestock.Type,MMS)

### Manure N Amendments

# N.MA = N * f.MMS * (Nex * (TAM / 1000) * 365 * (1 - f.L.MMS) + N.Bed)   # Estimates managed manure N available for application (IPCC 2006, Vol 4 Ch 10, Eq 10.34)
# N.M = N.MA * (1 - (f.FEED + f.FUEL + f.CNST))                           # Estimates the animal manure applied to soils (IPCC 2006, Vol 4 Ch 11, Eq 11.4)

# N          = f(Year,Livestock.Type)
# Nex        = f(Livestock.Type)
# TAM        = f(Livestock.Type)
# f.MMS      = f(Livestock.Type,MMS)
# f.L.MMS    = f(Livestock.Type,MMS)
# N.Bed      = f(Livestock.Type)
# f.FEED     = f(Livestock.Type)
# f.FUEL     = f(Livestock.Type)
# f.CNST     = f(Livestock.Type)

livestock <- function(L.AD, MM.AD, L.EF = IPCC.2006.L.EF, MM.EF = IPCC.2006.MM.EF) {
  
  # Format the activity data and emission factors
  EF.N2O.DV = 0.01 # Apply IPCC default value for indirect N2O emissions factor (IPCC 2006, Vol 4, Ch 11, Table 11.3)
  L <- left_join(L.AD, L.EF, by = "Livestock.Subtype")
  L.MM <- left_join(L, MM.EF, by = "Livestock.Subtype")
  
  # Estimates total enteric fermentation and manure management CH4 emissions by year and livestock type
  L.Y.LT <- L %>% mutate(Year = as.factor(Year),
                         EF.CH4 = (N * EF.CH4.EF) / 10^6, # Estimates CH4 emissions from enteric fermentation
                         MM.CH4 = (N * EF.CH4.MM) / 10^6) %>% # Estimates CH4 emissions from manure management
            group_by(Year, Livestock.Subtype) %>%
            summarize(EF.CH4 = sum(EF.CH4),
                      MM.CH4 = sum(MM.CH4))
  # Estimates total manure management N2O emissions and N inputs from livestock by year and livestock type
  MM.Y.LT <- L.MM %>% mutate(Year = as.factor(Year),
                            MM.N2O.D = N * Nex * (TAM / 1000) * 365 * f.MMS * EF.N2O.MM * (44/28), # Estimates direct N2O emissions from manure management
                            MM.N2O.I = N * Nex * (TAM / 1000) * 365 * f.MMS * f.DV.MMS * EF.N2O.DV * (44 / 28), # Estimates indirect N2O emissions from manure management
                            N.UD = ifelse(MMS == "PRP", N * Nex * (TAM / 1000) * 365 * f.MMS, 0), # Estimates the N deposited on pasture, range and paddock
                            N.MA = ifelse(MMS == "PRP", 0, N * f.MMS * (Nex * (TAM / 1000) * 365 * (1 - f.L.MMS) + N.Bed)), # Estimates the managed manure N available for application
                            N.M = N.MA * (1 - (f.FEED + f.FUEL + f.CNST))) %>% # Estimates the animal manure applied to soils
            group_by(Year, Livestock.Subtype) %>%
            summarize(MM.N2O.D = sum(MM.N2O.D),
                      MM.N2O.I = sum(MM.N2O.I),
                      N.UD = sum(N.UD),
                      N.MA = sum(N.MA),
                      N.M = sum(N.M))
  
  L.MM.Y.LT = left_join(L.Y.LT, MM.Y.LT, by = c("Livestock.Subtype","Year"))
  EF.MM.LT = L.MM.Y.LT %>% select(Year, Livestock.Subtype, EF.CH4, MM.CH4, MM.N2O.D, MM.N2O.I)
  L.N.LT = MM.Y.LT %>% select(Year, Livestock.Subtype, N.UD, N.M)
  
  # Estimates total enteric fermentation and manure management GHG emissions and N inputs by year
  L.Y <- L.MM.Y.LT %>% group_by(Year) %>%
         summarize(EF.CH4 = sum(EF.CH4),
                   MM.CH4 = sum(MM.CH4),
                   MM.N2O.D = sum(MM.N2O.D),
                   MM.N2O.I = sum(MM.N2O.I),
                   N.UD = sum(N.UD),
                   N.MA = sum(N.MA),
                   N.M = sum(N.M))
  EF.MM = L.Y %>% select(Year, EF.CH4, MM.CH4, MM.N2O.D, MM.N2O.I)
  L.N = L.Y %>% select(Year, N.UD, N.M)
  
  # Returns a list of 1) GHG emissions by year and livestock type
  #                   2) GHG emissions by year only 
  #                   3) Livestock N inputs by year and livestock type
  #                   4) Livestock N inputs by year only 
  return(list(EF.MM.LT, EF.MM, L.N.LT, L.N))
}