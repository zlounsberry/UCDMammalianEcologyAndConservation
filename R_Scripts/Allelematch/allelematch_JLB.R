library(allelematch)				
				
samplesAll<-read.csv("allelematchAll.csv")				
all <- amDataset(samplesAll, indexColumn="ID",ignoreColumn="SRY", missingCode="-99")				
amUniqueProfile(all, doPlot=TRUE)				
				
				
				
samples<-read.csv("allelematch.csv")				
consensus <- amDataset(samples, indexColumn=1,ignoreColumn=2, missingCode="-99")				
amUniqueProfile(consensus, doPlot=TRUE)				
unique <- amUnique(consensus, alleleMismatch=4)				
summary(unique, html="unique.html")				
unclassified <- amPairwise(unique$unclassified,unique$unique, alleleMismatch=5)				
summary(unclassified, html="unclassified.html")				