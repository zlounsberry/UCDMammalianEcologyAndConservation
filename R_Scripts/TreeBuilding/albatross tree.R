#See "Label Appender for Network VGL.R" for better descriptions of the preliminary steps...
#I can only get bootstrap values on an unrooted tree, so this script is a bit limited in that respect.
setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\TreeBuilding") #sets your working directory
library(phangorn) #loads phangorn
library(ape) #loads ape
DNA = read.phyDat("CR_All.fas", format = "fasta", type = "DNA") #turns YourFile.fas from your wd into an object 'DNA', class phyDat
dm = dist.logDet(DNA) #computes pairwise distances of your sequences and turns that into an object 'dm'
tree = nj(dm) #Neighbor-joining tree using your pairwise distance object
#Also available: 
#"the BIONJ algorithm of Gascuel (1997)" = bionj(dm);
#"the [balanced] Minimum Evolution algorithm of Desper and Gascuel (2002)" = fastme.bal(dm, nni = TRUE, spr = TRUE, tbr = TRUE)
#"the [OLS] Minimum Evolution algorithm of Desper and Gascuel (2002)" = fastme.ols(dm, nni = TRUE)
fit = pml(tree, DNA) #computes the likelihood of a phylogenetic tree given a sequence alignment and makes that an object 'fit'
modelTest(fit)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY", optInv=T) #optimizes the tree and makes it an object 'fit1'. You can specify a nucleotide substitution
	#model here. Use "?optim.pml" for a list of models as well as how to specify gamma distribution and tons of other goodies.
	#Here I use the HKY model, but be sure to test for model fit in another program. Or use R! But it takes a while in R...
bs = bootstrap.pml(fit1, bs = 5000, optNni = TRUE) #performs 50 bootstrap replicates on your new optimized tree, 'fit1'
par(mar=c(1,1,1,5), xpd=T) #this just optimizes your graphics window... You can plot multiple trees together, etc. using this
root = root(fit1$tree, 9)
plotBS(root, bs, bs.adj = c(1.1,1), type="phylogram", cex=2, bs.cex=1, bs.col="gray50", font = 1, use.edge.length = T, edge.color="black", tip.color="black", label.offset = 0.001, root.edge=T)
add.scale.bar(lwd=2, ask = T, cex = 2.5)
?plotBS()