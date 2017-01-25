setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/ConsensusGenotypeMaker")
library(allelematch)				
				
data = as.data.frame(read.table("TehamaDeer_5LociFailed_Output4Allelematch.txt", header = T, sep = "\t")) #Reads file.txt as the focal dataset
Data = amDataset(data, missingCode = "-99", indexColumn = 1, metaDataColumn = NULL) #Makes the amDataset formatted object for analysis

#amUniqueProfile(Data, doPlot=TRUE) #This will give you a most likely value for your allele cutoff

unique <- amUnique(Data, alleleMismatch=4)
	##This will give you your unique genotypes as an amDataset object 
	##This uses an allele mismatch threshold of 4, and this value can be changed depending on the output of the amUniqueProfile

amCSV.amUnique(unique, "outputAllelematch_TehamaDeer_5LociFailed_Output4Allelematch.csv")