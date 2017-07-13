#Thanks to (not-yet-Dr.-as-of-13-July-2017) Jen Brazeal for help with improvements

setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Allelematch")
library(allelematch)				
				
data = as.data.frame(read.table("file.txt", header = T, sep = "\t")) #Reads file.txt as the focal dataset
Data = amDataset(data, missingCode = "-99", indexColumn = 1, metaDataColumn = NULL) #Makes the amDataset formatted object for analysis

#amUniqueProfile(consensus, doPlot=TRUE) #This will give you a most likely value for your allele cutoff

unique <- amUnique(Data, alleleMismatch=4)
	##This will give you your unique genotypes as an amDataset object 
	##This uses an allele mismatch threshold of 4, and this value can be changed depending on the output of the amUniqueProfile
				
summary(unique, html="unique.html")				
unclassified <- amPairwise(unique$unclassified,unique$unique, alleleMismatch=4)				
summary(unclassified, html="unclassified.html")	
amCSV.amPairwise(unclassified , "outputAllelematchJBL.csv") 

amUniqueProfile(Data, guessOptim=T,consensusMethod=1)
Output = amPairwise(Data, alleleMismatch = 5) #Makes an amPairwise formatted object for output (alleleMismatch = number from amUniqueProfile graph)
amCSV.amPairwise(Output, "outputAllelematch.csv")
