setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/ConsensusGenotypeMaker")


#########Change the stuff here to fit your data#############

data = as.data.frame(read.table("testfile3.txt", header = T, sep = "\t")) 
	##Reads in focal dataset (2 column format, tab separated!)

missingValue = -99 
	##Put your missing data value here (I like -99)

startcol = 2 
	 ##This is the column that the first allele of the first locus occurs in.

####DON'T CHANGE ANYTHING BELOW HERE####

columns = seq(startcol,ncol(data),2)
	##Creates an object that tells the function how many loci you have.
	##You can use length(columns) to check that this is correct. It should return your number of loci

names=as.character(sort(unique(data[,1]))) 
	#This creates an object (class: character) of the unique sample names in a file


MakeCons = function(x, print = T){ 
	##Makes the function to call x, which we will feed to lapply such that x is every sample name (see below)

numbers = which(data[,1] == x) 
	##Finds which lines in the object "data" (your txt file as a data frame) contain the unique sample identifier

genotype=as.data.frame(data[numbers[1],])
	##Initializes your data frame (an object called 'genotype') as the first occurrence (full row) containing your sample name that is being run
  
for(i in numbers[2:length(numbers)])
{
	##Initializes your loop to find the remaining occurrences of rows containing your sample name (all occurrences after the first occurrence that was used to initialize the data frame)

obj=as.data.frame(data[i,])
	##Creates an object that is the genotype for the ith occurrence (replicate) of your sample ID 

genotype=rbind(genotype, obj)
}
	##Iteratively adds each new row (object called 'obj' changes with every value of i) containing a replicate to the object 'genotype'

for(i in 1:nrow(genotype)) 
{
	##Initializes a loop to run on the genotype object made above (which is all of your replicates of that sample name)

genotypes=as.data.frame(x)
	##Creates a new object called 'genotypes' that will end up as the consensus sequence for sample x
 
for(j in columns) 
{
	##starts the loop that will take occurrences of each unique alleles and collapse them to a 1 or 2-locus genotype

	if(length(sort(unique(c(genotype[,j],genotype[,j+1]))))>=2) {
		## "if the number of unique alleles (INCLUDING YOUR MISSINGVALUE) in columns j and j+1 (i.e., the jth locus) for all replicates is greater than 2..."

		obj1=sort(unique(c(genotype[,j],genotype[,j+1])))
			## "...then collapse them into just unique values..."

		obj1=obj1[obj1 != missingValue ]
			## "... and remove the missingValue"

	} else {
		obj1=(sort(unique(c(genotype[,j],genotype[,j+1]))))
	}
	if(length(obj1)==1){
		obj1=c(obj1,obj1)
	} 
genotypes=as.data.frame(c(genotypes,obj1))
}
}
print(genotypes)
}

test = lapply(names, MakeCons)
test = sapply(names, MakeCons)

writeLines(unlist(lapply(test, paste)))
writeLines(unlist(lapply(test, paste, collapse="\t")))

#############ABOVE THIS IS THE FINAL SCRIPT###############################



#############BELOW THIS IS THE WORKING SCRIPT###############################

data = as.data.frame(read.table("testfile3.txt", header = T, sep = "\t")) #Reads in focal dataset (2 column format, tab separated!)
missingValue = -99 # This is the value for missing data in your file
startcol = 2 # This is the column that the first allele of the first locus occurs in.

columns = seq(startcol,ncol(data),2)
names=sort(unique(data[,1])) # This creates an object (class factor) of the unique sample names in a file
names=as.character(sort(unique(data[,1]))) # This creates an object (class factor) of the unique sample names in a file

final=colnames(data)
MakeCons = function(x, print = T){ #make the
numbers = which(data[,1] == x)
genotype=as.data.frame(data[numbers[1],])  
for(i in numbers[2:length(numbers)])
{
obj=as.data.frame(data[i,])
genotype=rbind(genotype, obj)
}
for(i in 1:nrow(genotype)) 
{
genotypes=as.data.frame(x) 
for(j in columns) 
{
	if(length(sort(unique(c(genotype[,j],genotype[,j+1]))))>=2) {
		obj1=sort(unique(c(genotype[,j],genotype[,j+1])))
		obj1=obj1[obj1 != missingValue ]
	} else {
		obj1=(sort(unique(c(genotype[,j],genotype[,j+1]))))
	}
	if(length(obj1)==1){
		obj1=c(obj1,obj1)
	} 
genotypes=as.data.frame(c(genotypes,obj1))
}
}
}

test = lapply(names, MakeCons)

