setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Allelematch")
library('allelematch')

################################
##Start-to-finish basic script##
################################

data = as.data.frame(read.table("file.txt", header = T, sep = "\t")) #Reads file.txt as the focal dataset
head(data) #Just making sure the data got read in right
Data = amDataset(data, missingCode = "-99", indexColumn = 1, metaDataColumn = NULL) #Makes the amDataset formatted object for analysis
amUniqueProfile(Data, guessOptim=T,consensusMethod=1)
Output = amPairwise(Data, alleleMismatch = 5) #Makes an amPairwise formatted object for output (alleleMismatch = number from amUniqueProfile graph)
amCSV.amPairwise(Output, "outputAllelematch.csv") 

###########################################
##Simplifying output with unique ID calls##
###########################################

data = as.data.frame(read.table("file.txt", header = T, sep = "\t")) #Reads file.txt as the focal dataset
head(data) #Just making sure the data got read in right
Data = amDataset(data, missingCode = "-99", indexColumn = 1, metaDataColumn = NULL) #Makes the amDataset formatted object for analysis

amUniqueProfile(Data, guessOptim=T,consensusMethod=1)
	#Use the mismatch score from amUniqueProfile to determine cutoff in Output

myCluster = amCluster(Data, runUntilSingletons=T, consensusMethod=1) #This will create a file of JUST your unique genotypes
	#you can run this to get just a list of your unique genotypes

summary(myCluster, csv="myCluster.csv")
	#This gives you a summary of your new cluster data and also prints a csv file (here: 'myCluster.csv')

dataUnique = as.data.frame(read.csv("myCluster.csv", header = T)) 
	#Read in your new unique individual data

IDs=as.factor(1:nrow(dataUnique)) 
	#Make a new individual ID for each unique genotype in the dataset (numbered 1 through the number of individuals in your object)

dataUnique[,1] = IDs 
	#Replace ID names with numbers 1 through your total number of individuals

DataUnique= amDataset(dataUnique, missingCode = "-99", indexColumn = 1, metaDataColumn = NULL) 
	#Makes dataUnique into an amDataset for pairwise comparisons

Output2 = amPairwise(Data, amDatasetComparison = DataUnique, alleleMismatch = 5) 
	#Does pairwise comparisons using the individuals ID's from the DataUnique dataset on your whole

amCSV.amPairwise(Output2, "outputAllelematch_Unique.csv") 
