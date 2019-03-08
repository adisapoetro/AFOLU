#########################################################
###   Writing IPCC, 2006 Emission Factors to .RData files   ###
#########################################################

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions and N in livestock
IPCC_2006_EF <- df
save(IPCC_2006_EF, file = "IPCC_2006_EF.RData")

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions from manure management
IPCC_2006_MM <- df
save(IPCC_2006_MM, file = "IPCC_2006_MM.RData")

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions from soil amendments
IPCC_2006_SA <- df
save(IPCC_2006_SA, file = "IPCC_2006_SA.RData")

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions from crop residues
IPCC_2006_CR <- df
save(IPCC_2006_CR, file = "IPCC_2006_CR.RData")

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions from biomass burning
IPCC_2006_BB <- df
save(IPCC_2006_BB, file = "IPCC_2006_BB.RData")

#Generates a dataframe storing IPCC 2006 emission factors for estimating GHG emissions from rice cultivation
IPCC_2006_RC <- df
save(IPCC_2006_RC, file = "IPCC_2006_BB.RData")