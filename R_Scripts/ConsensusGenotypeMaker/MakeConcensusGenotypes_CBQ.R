#########Script to consolidate replicate runs of samples into one concensus genotype#############
#CBQ:adapted from ZL's script 12072015

setwd("~/Documents/Foxes/R/Genotypes - SNRF/replicate project/")
#########START OF INPUT SECTION##########

##Read in focal dataset (2 column format, tab separated!)
data_full <- read.table("SonPass_reps_20151118_2col.txt", header = T, sep = "\t")

##Put your missing data value here (I like  -99)
missingValue = -99 

  #note from CBQ: I have it formatted so my input file can come from binning, hence 15 extra text files
  #I do a little dancing around because of this, that in the future could be streamlined. 

##Column that the first allele of the first locus occurs in.
startcol = 17
##Column that unique sample identifier (e.g. S15-2333) is in.
id <- 4

##########END OF INPUT SECTION##########
#truncate full dataframe so that it is just an id column and genotype 
  data <- data_full[,c(id,startcol:ncol(data_full))]
  #now need to reassign startcol and id
  startcol <- 2
  id <- 1

####DON'T CHANGE ANYTHING BELOW HERE####

##Create a vector that indexes the start column for every locus
  #length(columns) returns your number of loci
columns = seq(startcol,ncol(data),2)

##Creates a vector of the unique sample names in a file
  #length(names) is the number of samples you have
names=as.character(sort(unique(data[,id]))) 

##Create a blank final dataframe that eventually will hold all of your concensus genotypes 
final <- data.frame(matrix(NA, nrow=length(names), ncol=ncol(data)))
names(final) <- names(data)


######Run loop...######

#i is a loop that walks through each unique sample identifier....
for (i in 1:length(names))  {
    x <- names[i]
##creates a dataframe called "replicates" that subsets the data to only those that match the given sample ID
    replicates <- data[which(data[,id]==x),]
  ##creates a temporary blank dataframe called genotype that will eventually contain the concensus genotype for this sample
    genotype <- data.frame(matrix(NA, nrow=1, ncol=ncol(replicates)))
    #add in sample id and column names
    genotype[,id] <- replicates[1,id]
    names(genotype) <- names(replicates)
 
##nested within this loop is a j loop that for each locus j, will take occurrences of  unique alleles and collapse them to a 1 or 2-locus genotype
    for(j in columns) {
      #create a temporary object with only unique values, and remove missingValue 
      temp <- sort(unique(c(replicates[,j],replicates[,j+1])))
      temp <- temp[temp != missingValue] 
      
      ## "if the number of unique alleles (NOT INCLUDING YOUR missingValue) in columns j and j+1 (i.e., the jth locus) for all replicates is greater than 2..."
      if(length(temp)>2) {
        #...assing dummy values to indicate there is a false allele here... 
        obj1 <- c("-666","-666")
        #...and assign these values to the corresponding locus in the genotype object
        genotype[,c(j,j+1)] <- obj1 
        
      ##but if there are <2 unique values NOT INCLUDING your missingValue
      }  else {
        ## "1) if the number of unique alleles (INCLUDING YOUR MISSINGVALUE) in columns j and j+1 (i.e., the jth locus) for all replicates is greater than 2..."
        if(length(sort(unique(c(replicates[,j],replicates[,j+1]))))>=2) {
          ## "...then collapse them into just unique values..."
          obj1 <- sort(unique(c(replicates[,j],replicates[,j+1])))
          ## "... and remove the missingValue"
          obj1=obj1[obj1 != missingValue ]
        ## "...and assign to appropriate columns in genotype object
        }
        ## but if there are 2 or less unique alleles (INCLUDING YOUR MISSINGVALUE)...
        else {
          ## then set obj 1 equal to them
        obj1=(sort(unique(c(replicates[,j],replicates[,j+1]))))
        }
          #and if obj1 has only 1 unique allele... (eg homozygote)
        if(length(obj1)==1){
          #repeat it two times
        obj1=c(obj1,obj1)
        }
      }     
      #...and finally assign obj 1 to appropriate columns in genotype object
      genotype[,c(j,j+1)] <- obj1 
    }
      final[i,] <- genotype
      final[,1] <- names 
}

    
#can print to .txt file with this command
#write.table(final, "test.txt", sep="\t", row.names=F)

####OR

#can o add a column identifying these as concensus genotypes
final <- cbind("concensus"="concensus", final)
#....and combine with original data of all replicates
all <- rbind(cbind("concensus"="replicates", data), final)
#and then export as a tab-delimited txt file
write.table(all, "test3.txt", sep="\t", row.names=F)
  
  
  
  