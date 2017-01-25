#See "Label Appender for Network VGL.R" for better descriptions of the preliminary steps...
#I can only get bootstrap values on an unrooted tree, so this script is a bit limited in that respect.
setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts") #sets your working directory
library(phangorn) #loads phangorn
library(ape) #loads ape
DNA = read.phyDat("CR_All2.fas", format = "fasta", type = "DNA") #turns YourFile.fas from your wd into an object 'DNA', class phyDat
dm = dist.logDet(DNA) #computes pairwise distances of your sequences and turns that into an object 'dm'
tree = nj(dm) #Neighbor-joining tree using your pairwise distance object
tree2=njs(dm)
#Also available: 
#"the BIONJ algorithm of Gascuel (1997)" = bionj(dm);
#"the [balanced] Minimum Evolution algorithm of Desper and Gascuel (2002)" = fastme.bal(dm, nni = TRUE, spr = TRUE, tbr = TRUE)
#"the [OLS] Minimum Evolution algorithm of Desper and Gascuel (2002)" = fastme.ols(dm, nni = TRUE)
fit = pml(tree, DNA) #computes the likelihood of a phylogenetic tree given a sequence alignment and makes that an object 'fit'
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY") #optimizes the tree and makes it an object 'fit1'. You can specify a nucleotide substitution
	#model here. Use "?optim.pml" for a list of models as well as how to specify gamma distribution and tons of other goodies.
	#Here I use the HKY model, but be sure to test for model fit in another program. Or use R! But it takes a while in R...
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE) #performs 50 bootstrap replicates on your new optimized tree, 'fit1'
par(mar=c(1,1,1,5), xpd=T) #this just optimizes your graphics window... You can plot multiple trees together, etc. using this
#The following command plots your boostrapped tree. Use "?plotBS" and "?plotBS" to play with colors, lengths, types, etc. 
plotBS(root, bs, bs.adj = c(1.1,1), type="phylogram", cex=2, bs.col="gray80", font = 1, use.edge.length = T, edge.color="black", tip.color="black", label.offset = 0.1, root.edge=T)

root = root(fit1$tree, 9)
plot.phylo(root, cex=2.7, bs.col="red", edge.width=6, font = 2, edge.color="black", tip.color="black", label.offset = 0.001)
add.scale.bar(lwd=6, ask = T, cex = 2.5)
?plot.phylo()


##Maybe you want to prune that NJ tree up... Here's how!
DNA = read.phyDat("SarahNewNames.fas", format = "fasta", type = "DNA")
dm = dist.ml(DNA)
tree = fastme.bal(dm)
pruned<-drop.tip(tree, trim.internal = TRUE, c("Node name 1, Node name 2, etc"), rooted = FALSE)
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

##Now Whales with NJ instead of Minimum Evolution
Whales = read.phyDat("SarahNewNames.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales) 
tree = bionj(dm) #Only difference between this and the one above it
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

##Now with a nexus file!##
##Once again, I'm cheating and taking the long way... Just rewriting the nexus file as a fasta and doing the same thing...##
##Whatever, it works##

NexWhale = read.nexus.data("Grey_whales_20121127.nex")
write.dna(NexWhale, "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\WhalesNex.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 10, indent = NULL, blocksep = 1)
Whales = read.phyDat("WhalesNex.fas", format = "fasta", type = "DNA")
dm = dist.ml(Whales) 
tree = nj(dm) #Only difference between this and the one above it
fit = pml(tree, Whales)
fit1 = optim.pml(fit, optNni = TRUE, model = "HKY")
bs = bootstrap.pml(fit1, bs = 50, optNni = TRUE)
par(mar=c(.1,.1,.1,.1))
plotBS(fit1$tree, bs, bs.adj = c(1.1,1), type="phylogram", cex=.75, bs.col="black", font = 1, use.edge.length = FALSE, label.offset = 0.1)

WhaleNex = as.character(unlist(NexWhale))

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