setwd("C:/Users/AwesomeZach/Desktop/R Folder") #This makes the current folder (R Scripts in the Wildlife folder) the working directory
#Setting the working directory means you can leave path names out of files that you pull from this folder.
	#If you don't know your working directory, rightclick the file you want to use and go to properties. You can copy the directory
	#right from the window that pops up. Careful, R doesn't like "\'s", so turn the slashes to "/" or "\\" in file names and directories.
# Either one of these will do the same thing:
# setwd("C:\\Users\\AwesomeZach\\Desktop\\R Folder")
# setwd("C:/Users/AwesomeZach/Desktop/R Folder")

library(ape) #If you don't have ape and phangorn installed, go ahead and install those packages. Go ahead. I'll wait.
library(phangorn) #Okay great, now load the packages by executing the library(package) commands.

#Now time to read your file. The following command makes an object named "DNA" from your fasta file
	#Careful, R is case sensitive! YourFile and yourfile are two different things in R.
DNA = read.dna("YourFile.fas", format = "fasta") #This makes your fasta file an object (specifically a matrix) in R to be played with
DNA #This is just to make sure it's in there and read right

#Here is the basic label appender. It will take the first # of characters specified by "len = #", assign repeat names a number
	#with "make.unique = TRUE", chop out superfluous characters using "illegal = "superfluous characters", and determine whether
	#or not to put them in quotes with "quote = FALSE".
DNA1 = makeLabel(DNA, len = 5, space = "_", make.unique = TRUE, illegal = "():;,[]-", quote = FALSE)
#And write this file to a new Fasta (named YourFileNewNames.fas) file in your working directory
#The "append = FALSE" means it'll overwrite previous iterations of YourFileNewNames. append = TRUE just slaps your new sequences on the
	#end of YourFileNewNames. i.e., if you execute this command 3 times with append = TRUE, you get 3 copies of your sequences in 1 file.
write.dna(DNA1, "C:/Users/AwesomeZach/Desktop/R Folder/YourFileNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)

##Now making new labels with just the last few characters!##

#First, read your file (you can use your new one like I did, here... Or the original YourFile.fas... Or any .fas file) and make an
	#object, DNA2.
DNA2 = read.dna("C:/Users/AwesomeZach/Desktop/R Folder/YourFileNewNames.fas", format = "fasta")
DNA2 #Prints it. Did it work? Of course it did.

zl <- labels(DNA2) #extract the labels
zl <- substr(zl, nchar(zl) - 5, nchar(zl)) #remove the desired number of characters from the end. "nchar(zl) - #" allows 
	#you to truncate to # characters.
if (is.list(DNA2)) names(DNA2) <- zl #if it's a list, this will print the new names to that list
if (is.matrix(DNA2)) rownames(DNA2) <- zl #if it's a matrix, this will print the new names to the matrix (ours is a matrix)

#then just write your newly labeled sequence file!
write.dna(DNA2, "C:/Users/AwesomeZach/Desktop/R Folder/YourFileNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)

#if you have to alter it further (e.g., remove special characters, make unique, etc.), you can use the script above. 
	#Just replace the "read.dna" with your new file.


#Example: Sarah's long-way script for pulling haplotype ID's from GenBank
	#Scenerio: Imagine you got your sequences from GenBank (using ape's sweet read.GenBank feature or otherwise).
	#Sarah doesn't want pesky long names. She just wants the Haplotype names!
	#That is, she wants "haplotype A" instead of "gi|15420443|gb|AF355204.1| Balaena mysticetus haplotype A mitochondrial control region, partial sequence"
	#All she has to do is execute the following script, assuming she needs Whales2.fas from my "R Scrip MSAT Finder" folder:
setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
library(phangorn)
library(ape)
DNA = read.dna("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\Whales2.fas", format = "fasta") #read the file "Whales2.fas"
lab <- labels(DNA) #extract the labels
lab <- substr(lab, nchar(lab) - 60, nchar(lab)) #remove 60 characters from the end.
if (is.matrix(DNA)) rownames(DNA) <- lab #This is a matrix, so this will print the new names to the matrix
DNA #check to make sure the labels are right. They are? Super.
write.dna(DNA, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
DNA = read.dna("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta") 
DNA = makeLabel(DNA, len = 15, space = "_", make.unique = TRUE, illegal = "():;,[]-", quote = FALSE)
write.dna(DNA, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
#Now her intermediate file SarahNewNames is overwritten by her final file... Consider it the unstable intermediate because I know you love organic chemistry.
	#If append = TRUE, then both sets of sequences will be in there, and that's no fun.
#Now, since her haplotypes are different lengths, there is some fat to trim on either side of her single- and double- character
	#Haplotype ID's... I trim them in BioEdit because it's easier... 
	#In Bioedit: 'Edit->Search->Find/Replace in Titles' works just like Microsoft Office would... Only better
	#And I save the new Fasta File as SarahNewNames1.fas in the same folder. 

#and make a tree while you're at it. Let's go with a Boostrapped NJ tree in Sarah's UC-Davis proud colors.
Whales = read.phyDat("SarahNewNames1.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales) 
tree = nj(dm) #Only difference between this and the one above it
fit = pml(tree, Whales)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,1), type="phylogram", cex=.75, bs.col="darkgoldenrod2", font = 1, use.edge.length = FALSE, edge.color="blue3", tip.color="darkgrey", label.offset = 0.1)
