library("ape")
library("pegas")
library("seqinr")
library("ggplot2")
library("devtools")
library("adegenet")
library("wordcloud")
library("hierfstat")
setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/adegenet")
###########################################################################
##This section is an example PCA using red fox microsatellite data and code from the tutorial (modified slightly)##
dev.new(width=60, height=45)
DNA=read.structure("Genotype Data for PCA.stru", n.ind=160,n.loc=33,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

X = tab(DNA, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
##NA must be removed to make a PCA. options include NA.method="mean" which sets missing to the mean allele freq at that locus.
##You can also set freq=T to make the matrix return allele frequencies instead of counts

pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
#If you look at the 
temp <- as.integer(pop(DNA)) #makes a temporary object to be used for myCol and myPch (below) that convert your populations to integers
myCol <- transp(c("yellow","green","black","blue"),.8)[temp] #makes some grayscale, transparent colors
myPch <- c(22,22,22,22)[temp] #Sets points to each population given in DNA
plot(pca1$li, col="black", cex=2, pch=myPch, bg=myCol) # $li refers to the principal components, so that's what we're plotting here
add.scatter.eig(pca1$eig[1:15],10,2,1,inset=c(0.2,0.75),ratio=0.2) #adds the distribution of the first 20 eigenvalues in a barchart as an insert
#legend("topright",pch=c(21,22), col="black", pt.bg=transp(c("gray25","gray75"),.8), leg=c("FurFarm","Wild"),pt.cex=2)
textplot(pca1$li[,1], pca1$li[,2], words=rownames(X), cex=.4, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or sparse one


##For some more informative figures (including inertia ellipses):
s.class(pca1$li[c(1,2)],pop(DNA),label=c("wild","fur farm"),cpoint=2,pch=myPch,col=c("black","black")) # This adds inertia ellipses for populations
	##above, inertia ellipses are included. Also sample names and lines drawn to the center of the ellipses are included
	##above, li[c(1,2)] refers to principal components 1 and 2. Can be used to plot other components, if that's something you have.


##For some prettier informative figures (including inertia ellipses):
s.class(pca1$li,pop(DNA),xax=1,yax=2,label=c("Nonnative","Native","Hybrids","SacValley"),col=transp(c("yellow","green","black","blue"),0.75),axesell=FALSE,cstar=1,cpoint=3,grid=FALSE)
	##above, 'xax=1, yax=2' refers to using PC1 and PC2 for x and y, respectively
	##also, col=transp(c("firebrick1","dodgerblue1"),0.75) color codes your populations and makes them transparent.
	##also, axesell=FALSE gets rid of axes with ellipses, cstar=0 gets rid of the lines to the center, cpoint=3 refers to point size, and grid=FALSE removes the grid from the figure

#some extra bits:
#colorplot(pca1$li,pca1$li,cex=3, transp=T)
#barplot(pca1$eig[1:50],main="PCA eigenvalues",col=heat.colors(50)) #This plots the pca eigenvalues (for eigenvalues 1:50, in this case)
#s.arrow(pca1$c1*.5,add.plot=TRUE) #This bit shows the contributions of loci to each axis?
#textplot(pca1$li[,1], pca1$li[,2], words=rownames(X), cex=1.4, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or sparse one
#par(xpd=T)
#abline(h=0,v=0,col="grey",lty=2) #center lines @0

###########################################################################

###########################################################################
##This section is an example (unfinished, but working) PCA using red fox sequence (mtDNA) data and code from the tutorial (modified slightly)##

myDNA <-  read.dna("Haplotypes_All_Aligned.fas", format = "fasta", as.matrix=T) #read in your data (using package 'ape')
DNA <- DNAbin2genind(myDNA, polyThres=0.01)
D=dist(tab(DNA))
pco1<-dudi.pco(D,scannf=FALSE,nf=2)
plot(pco1$li)
textplot(pco1$li[,1],pco1$li[,2],words=rownames(pco1$li),cex=0.4,new=FALSE,xpd=TRUE) # $li refers to the principal coordinates

###########################################################################

###########################################################################
##This section is an example (unfinished, not working well with these data) of an unrooted tree##
DNA <- DNAbin2genind(myDNA, polyThres=0.01)
D=dist(tab(DNA))
tre<-nj(D)
par(xpd=TRUE)
plot(tre,type="unrooted",edge.w=2)
edgelabels(tex=round(tre$edge.length,1),bg=rgb(.8,.8,1,.8))
###########################################################################

