setwd("C:\\Users\\Zach\\Desktop\\R Stuff\\R Scrip MSAT Finder")

#Making a tree for HV2 in Albatross via instructions on http://cran.r-project.org/web/packages/phangorn/vignettes/Trees.pdf
library(ape) #loads ape package
library(phangorn) #loads phangorn package
library(png) #For adding images

#Reads your fasta (or nexus, etc.) file into R and creates an object AlbTree
AlbTree = read.phyDat("AlbContigs_14KB_NoDup.fas", format = "fasta", type = "DNA")

#Prints AlbTree so you can see your sequences, characters, etc.
AlbTree

dm = dist.dna(as.DNAbin(AlbTree)) #creates a distance matrix using your sequence file
treeUPGMA = upgma(dm) #Rooted tree, rooted here with Black-Browed Alb
treeNJ = NJ(dm) #unrooted, neighbor-joining tree

treeUPGMA
treeNJ
axis(2,at=NULL, labels=T)
plot.new()
par(mar = c(8,5,5,18), xpd=T) #Parameters of margins that out
plot(treeUPGMA) #Plots your rooted UPGMA tree
BFAL = readPNG("BFALCut.png")
LAAL = readPNG("LAALCut.png")
STAL = readPNG("STALCut.png")
rasterImage(BFAL, 0.015, 2.4, 0.0205, 3.48)
rasterImage(LAAL, 0.0138, 1.4, 0.021, 2.5)
rasterImage(STAL, 0.0145, 0.45, 0.0193, 1.45)
segments(0, 0.9, 0.012, 0.9, lwd = 2.1)
segments(0.005, 3.1, 0.012, 3.1, lwd = 2.1)
text(0.006, 0.8, "2.4% seq divergence (320-bp)", cex=1.5)
text(0.0085, 3.2, "1.4% seq divergence (189-bp)", cex=1.5)

parsimony(treeUPGMA, AlbTree) # returns a parsimony score
parsimony(treeNJ, AlbTree) # in this example, the NJ tree has a better parsimony score than the UPGMA tree

#You can also use the parsimony ratchet method from 1999 to rearrange trees and find an optimal parsimony score
pars = optim.parsimony(treeUPGMA, AlbTree)
ratchet = pratchet(AlbTree, trace = 0)
parsimony(c(pars, ratchet), AlbTree)
#For small datasets (< 10taxa, for example). Not overly sure what this does...
#trees <- bab(subset(AlbTree,1:25)) #I hashtagged this one so if I run the whole script i doesn't take forever...

######Now for some Max Likelihood comparing of nucleotide substitution models using our new trees! Specifically unrooted trees.
fit = pml(treeNJ, data=AlbTree) #pml returns an object of class "pml".  

fit #This is all of the information prior to fitting the tree to the Jukes Cantor model and optimizing branch lengths to that model

#Now to optimize it and include a few more possible nucleotide substitution models 
JC = optim.pml(fit, optNni=TRUE, optBf=FALSE, optQ=FALSE, optInv=FALSE, optGamma=FALSE, optEdge=TRUE, optRate=FALSE, optRooted=FALSE, control = pml.control(epsilon=1e-08, maxit=10, trace=1), model = "JC")
TrN = optim.pml(fit, optNni=TRUE, optBf=FALSE, optQ=FALSE, optInv=FALSE, optGamma=FALSE, optEdge=TRUE, optRate=FALSE, optRooted=FALSE, control = pml.control(epsilon=1e-08, maxit=10, trace=1), model = "TrN")
HKY = optim.pml(fit, optNni=TRUE, optBf=FALSE, optQ=FALSE, optInv=FALSE, optGamma=FALSE, optEdge=TRUE, optRate=FALSE, optRooted=FALSE, control = pml.control(epsilon=1e-08, maxit=10, trace=1), model = "HKY")

JC #Do they work alright? Print and check
TrN
HKY

#How do the models compare? Let's look at one at a time to save computing time, and then modelTest() them at the end (since I have a small dataset
# modelTest is okay, but it'll take a while if you are doing it with a large dataset)!
anova(JC, HKY, TrN) #Looks like HKY works pretty well... Let's test with AIC to be sure!
AIC(JC) #One at a time
AIC(HKY)
AIC(TrN)
AIC(JC, HKY, TrN) #Or print a table

modelTest(AlbTree) #If you have a small enough dataset, look at ALL the models!

#Now that we know which model works, let's go ahead and print a tree with bootstrap values. I'm going to use HKY so I don't have to go back and
# code one with the GTR+G+I model. THe optim.pml allows us to code for those more complex models, the modelTest() is quicker and dirtier.
# Also, the bs="" refers to the number of bootstrap replicates.
#For control,  If trace is set to zero then no output is shown, if functions are called internally than the trace is decreased by one. 

bs = bootstrap.pml(HKY, bs=100, optNni=TRUE, control = pml.control(trace = 0))
par(mar=c(.1,.1,.1,.1))
plotBS(HKY$tree, bs)

#Now with my rooted tree... It doesn't work! Get the unrooted the tree error 'coz apparently it can' bootstrap with a rooted tree yet?
#Okay, so I just removed the root. Let's get a pretty tree with bootstrap values, shall we?
#I got this script from http://rug.mnhn.fr/semin-r/PDF/semin-R_phylogenetics_KSchliep_180310.pdf
write.dna(DNA, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\AlbNameFixed.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
DNA =  read.phyDat("AlbContigs_14KB_NoDup.fas", format = "fasta", type = "DNA")
DNA
dm = dist.ml(DNA)
tree = fastme.bal(dm)
fit = pml(tree, DNA)
fit1 = optim.pml(fit, optNni = TRUE)
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, type="phylogram", cex=.75, bs.col="black")
nodelabels(frame="none",cex=0.7,adj=c(1,0))

plot.phylo(fit1$tree)

##Doing the same thing with a tree with diff names. Here, I cut the numbers out of the names so it's just down to species ID and individuals labeled with a single unique number

trim = read.dna("AlbUnrooted.fas", format = "fasta")
alb1 = makeLabel(trim, len = 5, space = "_", make.unique = TRUE, illegal = "1234567890_():;,[]-", quote = FALSE)
write.dna(alb1, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\AlbNameFixed.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
DNA = read.phyDat("AlbNameFixed.fas", format = "fasta", type = "DNA")
dm = dist.ml(DNA)
tree = fastme.bal(dm)
fit = pml(tree, DNA)
fit1 = optim.pml(fit, optNni = TRUE, model = "GTR")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, type="phylogram", cex=.75, bs.col="black")


##Maybe you want to prune that NJ tree up... Here's how!
DNA = read.phyDat("AlbNameFixed.fas", format = "fasta", type = "DNA")
dm = dist.ml(DNA)
tree = fastme.bal(dm)
pruned<-drop.tip(tree, trim.internal = TRUE, c("BFAL1","BFAL2","BFAL3","BFAL4","BFAL5","STAL9","STAL1","STAL7","STAL2","STAL3","STAL4","LAAL1","LAAL3"), rooted = FALSE)
pruned #This is the new tree without repetative haplotypes
fit = pml(pruned, DNA)
fit1 = optim.pml(fit, optNni = TRUE, model = "GTR")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,-0.2), type="phylogram", cex=.75, bs.col="black", font = 1, use.edge.length = FALSE, label.offset = 0.1)

#use.edge.length determines whether the branch lengths are included (TRUE) or excluded (FALSE)
#edge.color = "color" determines branch color
#'bs.adj = c(1.1,-0.2)' puts the bootstrap values on top of the branch leading up to the node (which I prefer), you can adjust as follows:
	#0 (left-justification), 0.5 (centering), or 1 (right-justification) (first number is horizontal, second is vertical)


##Sarah's Nexus File Format - Minimum Evolution algorithm for Whales
Whales = read.phyDat("Whales.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales)
tree = fastme.bal(dm)
fit = pml(tree, Whales)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,1), type="phylogram", cex=.75, bs.col="black", font = 1, use.edge.length = FALSE, label.offset = 0.1)

##Now Whales with NJ instead of Minimum Evolution
Whales = read.phyDat("Whales.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales) 
tree = nj(dm) #Only difference between this and the one above it
fit = pml(tree, Whales)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,1), type="phylogram", cex=.75, bs.col="black", font = 1, use.edge.length = FALSE, label.offset = 0.1)

plot.phylo(fit1$tree, use.edge.length = FALSE)

nodelabels(0, adj = c(-0.35, 0.5), frame = "none", pch = 17, thermo = NULL, pie = NULL, piecol = NULL, col = "Green", bg = "Black", horiz = FALSE, width = NULL, height = NULL)
bs1 = as.character(unlist(c(bs)))
bs1

?nodelabels

plot(fit1$tree,type="phylogram",edge.width=2,edge.color="blue",show.node.label=T,cex=0.7, use.edge.length = F)

Whales

?fastme.bal

#Some helpful commands:
args(plot.phylo)
args(plotBS)
args(bs.adj)
args(nodelabels)
?read.dna
?read.nexus
?plotBS #can use commands from plot and plot.phylo!
?plot.phylo
?plot
?pml
?pml.control
?bootstrap.pml
?optim.pml