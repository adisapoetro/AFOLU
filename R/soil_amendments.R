### 3.C.2 Liming

# L.CO2 = M * EF.CO2.L * (44/12) * 10^-3   #Calculates the CO2 emissions from lime application to managed soils (IPCC 2006, Vol 4 Ch 11, Eq 11.12)

# M          = f(Year, Amendment);     activity data
# EF.CO2.L   = f(Amendment)            IPCC = f(Amendment)

### 3.C.3 Urea Application

# U.CO2 = M * EF.CO2.U * (44/12) * 10^-6  #Calculates the CO2 emissions from urea application to managed soils (IPCC 2006, Vol 4 Ch 11, Eq 11.13)

# M          = f(Year,Amendment);      activity data
# EF.CO2.U   = single value

## Synthetic N Fertilizers

# N.SF = ifelse(N.Type == "Synthetic", M * N.A, 0) #Calculates N applied to managed soils from synthetic fertilizers

# M          = f(Year, Amendment, N.Type)
# N.A        = f(Amendment)

## Organic N Amendments

# N.OOA = ifelse(N.Type == "Organic", M * N.A, 0) #Calculates N applied to managed soils from other organic amendments

# M          = f(Year, Amendment)
# N.A        = f(Amendment)

soil_amendments <- function(SA.AD, SA.EF = IPCC.2006.SA.EF) {

  # Format the activity data and emission factors
  SA <- left_join(SA.AD, SA.EF, by = "Amendment")
  
  # Estimates total lime and urea CO2 emissions and N inputs by year
  SA.Y <- SA %>% mutate(Year = as.factor(Year),
                          L.CO2 = ifelse(C.Type == "Lime", M * EF.CO2.L * (44/12) * 10^-3, 0), # Estimates CO2 emissions from agricultural lime application
                          U.CO2 = ifelse(C.Type == "Urea", M * EF.CO2.U * (44/12) * 10^-6, 0), # Estimates CO2 emissions from urea application
                          N.SF = ifelse(N.Type == "Synthetic", M * N.A, 0), # Estimates N inputs from synthetic fertilizer application
                          N.OOA = ifelse(N.Type == "Organic", M * N.A, 0)) %>% # Estimates N inputs from organic fertilizer application
                 group_by(Year) %>%
                 summarize(L.CO2 = sum(L.CO2),
                           U.CO2 = sum(U.CO2),
                           N.SF = sum(N.SF),
                           N.OOA = sum(N.OOA))
  L.U <- SA.Y %>% select(Year, L.CO2, U.CO2)
  A.N <- SA.Y %>% select(Year, N.SF, N.OOA)
  
  # Returns a list of 1) CO2 emissions from lime and urea applications by year
  #                   2) Amendment N inputs by year
  return(L.U, A.N)
}