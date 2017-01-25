setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
library(ape)
alb = read.dna("C:\\Users\\Zach\\Desktop\\Albatross - Zach Folder\\Sequences\\Albatross CR1 HV2 All 3 spp.fas", format = "fasta")

alb

write.dna(alb, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\test.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)

## S3 method for class ’character’
alb1 = makeLabel(alb, len = 5, space = "_", make.unique = TRUE, illegal = "():;,[]-", quote = FALSE)

alb1

write.dna(alb1, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\test1.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
alb2 = makeLabel(alb, len = substr(12, 5, 12), space = "_", make.unique = TRUE, illegal = "_():;,[]-", quote = FALSE)
alb2 = makeLabel(alb, len substr(alb, nchar(alb)-5, nchar(alb)), space = "_", make.unique = TRUE, illegal = "_-", quote = FALSE)
write.dna(alb2, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\test1.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
x = c(1:10)

y = substr(x, nchar(x-5), nchar(x))
?substr

##Now taking the last few characters! Different working directory here, just fyi##

alb = read.dna("C:\\Users\\Zach\\Desktop\\Albatross - Zach Folder\\Sequences\\Albatross CR1 HV2 All 3 spp.fas", format = "fasta")
alb

zl <- labels(alb) #extract the labels
zl <- substr(zl, nchar(zl) - 5, nchar(zl)) #remove the desired number of characters from the end. "nchar(zl) - #" allows you to truncate to # characters.
if (is.list(alb)) names(alb) <- zl #if it's a list, this will print the new names to that list
if (is.matrix(alb)) rownames(alb) <- zl #if it's a matrix, this will print the new names to the matrix

#then just write your newly named file!
write.dna(alb, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\NewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)

#if you have to alter it further (e.g., remove special characters, make unique, etc.), you can use the script above. Just replace the "read.dna" with your new file.


#Sarah's long-way script for pulling haplotype ID's
setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
library(phangorn)
library(ape)
DNA = read.dna("Whales2.fas", format = "fasta") #read the file "Whales2.fas"
lab <- labels(DNA) #extract the labels
lab <- substr(lab, nchar(lab) - 60, nchar(lab)) #remove 60 characters from the end.
if (is.matrix(DNA)) rownames(DNA) <- lab #This is a matrix, so this will print the new names to the matrix
DNA #check to make sure the labels are right. They are.
write.dna(DNA, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)

DNA = read.dna("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta") 
DNA = makeLabel(DNA, len = 15, space = "", make.unique = TRUE, illegal = "():;,[]-", quote = FALSE)
write.dna(DNA, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\SarahNewNames.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
#and make a tree while you're at it
Whales = read.phyDat("SarahNewNames1.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales) 
tree = nj(dm) #Only difference between this and the one above it
fit = pml(tree, Whales)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)

par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,1), type="phylogram", cex=.75, bs.col="red", font = 1, use.edge.length = FALSE, edge.color="black", tip.color="darkgrey", label.offset = 0.1)


?plot.phylo
###############From website, don't execute this...################## 
Arguments
x a vector of mode character or an object for which labels are to be changed.
len the maximum length of the labels: those longer than ‘len’ will be truncated.
space the character to replace spaces, tabulations, and linebreaks.
make.unique a logical specifying whether duplicate labels should be made unique by appending
numerals; TRUE by default.
illegal a string specifying the characters to be deleted.
quote a logical specifying whether to quote the labels; FALSE by default.
tips a logical specifying whether tip labels are to be modified; TRUE by default.
nodes a logical specifying whether node labels are to be modified; TRUE by default.
... further arguments to be passed to or from other methods.
Details
The option make.unique does not work exactly in the same way then the function of the same
name: numbers are suffixed to all labels that are identical (without separator). See the examples.
If there are 10–99 identical labels, the labels returned are "xxx01", "xxx02", etc, or "xxx001",
"xxx002", etc, if they are 100–999, and so on. The number of digits added preserves the option
‘len’.
The default for ‘len’ makes labels short enough to be read by PhyML. Clustal accepts labels up to
30 character long.
