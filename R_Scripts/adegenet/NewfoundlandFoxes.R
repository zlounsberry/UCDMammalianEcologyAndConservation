setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/adegenet")
library("adegenet")
mycol=transp(c("black","firebrick1","dodgerblue1","darkgreen","yellow"), 0.4)

##Color reference:
##c("Fur Farm","North","Central","South") = c(mycol[2],mycol[3],mycol[1],mycol[4]) = c("firebrick1","dodgerblue1","black","darkgreen")

############################################################
####   This section is for pre-defined populations   #######
############################################################

DNA=read.structure("4stru_NewfoundlandRF.stru", n.ind=147,n.loc=21,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

par(xpd=T, mfcol=c(1,2))
dapc1=dapc(DNA, DNA$pop, n.pca=40, n.da=3) #calculate your dapc (it will prompt you to choose # of PC and discriminate functions to use.
opt1=optim.a.score(dapc1, plot=F)
dapc1=dapc(DNA, DNA$pop, n.pca=opt1$best, n.da=3) 
scatter(dapc1, col=mycol, cex=3, leg=F, clab=0) 
legend(-2,2850, c("Fur Farm","North","Central","South"), pch=c(19,19,19,19),cex=3, pt.cex=3.5, col=transp(c("firebrick1","dodgerblue1","black","darkgreen"), 0.8), bty="n")


############################################################




############################################################################
####This section is for looking for populations (Did not use for paper)#####
############################################################################

DNA=read.structure("4stru_NewfoundlandRF.stru", n.ind=147,n.loc=21,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1)

DNAgrp=find.clusters(DNA, max.n.clust=40, n.pca=100) # This is your test for the number of clusters (k's). max.n.clust refers to the maximum number of putative clusters.
3
	##This will ask you to choose a number of PCs to retain. No reason not to take as many as possible (I did 100, hence 'n.pca=100')
	##It will then ask you to check out the BIC vs. cluster size. Pick the k associated with the lowest (meaningful) BIC value.
par(xpd=T, mfcol=c(1,2))
table.value(table(pop(DNA), DNAgrp$grp),col.lab=paste("Cluster",1:3),row.lab=paste(c("Fur Farm","North Wild","South Wild"))) # This looks at how your populations parse with your hypothetical populations
dapc2=dapc(DNA, DNAgrp$grp, n.pca=40, n.da=3) #calculate your dapc (it will prompt you to choose # of PC and discriminate functions to use.
opt1=optim.a.score(dapc1, plot=T)
	##This calculates the number of PCs that give you the best a value
dapc2=dapc(DNA, DNAgrp$grp, n.pca=opt1$best, n.da=3) 
scatter(dapc2, cstar=0, col=mycol, cex=3, leg=T, txt.leg=paste("Cluster",1:3), clab=0, scree.pca=F)

	##scatter(dapc2, cstar=0, col=mycol, cex=3, leg=T, txt.leg=c("Wild 1","Wild 2","Fur Farm"), clab=0) 
	##scatter plots your dapc1 object. 
	##scree.da=T, inset.da=c(0.75,0.05), ratio.da=0.2, scree.pca=T, inset.pca=c(0.15,0.05), ratio.pca=0.2 plots both nicely (with this graphics window, anyway).


X = tab(DNA, NA.method="zero") #tab()
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE)
temp <- as.integer(pop(DNA)) #makes a temporary object to be used for myCol and myPch (below) that convert your populations to integers
myCol <- transp(c("gray25","gray75", "black"),.7)[temp] #makes some grayscale, transparent colors
myPch <- c(21,22,23)[temp] #Sets points to each population given in DNA
plot(pca1$li, col="black", cex=2, pch=myPch, bg=myCol,inset.pca=c(0.15,0.05), ratio.pca=0.2) # $li refers to the principal components, so that's what we're plotting here
textplot(pca1$li[,1], pca1$li[,2], words=rownames(X), cex=1, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or sparse one

contrib <- loadingplot(dapc1$var.contr, axis=1,thres=.07, lab.jitter=1) #To see which loci are contributing to each PC
	##This bit looks at

############################################################

############################################################
############Structure-like DAPC analyses####################
############################################################

##This is better with user-defined (e.g., biological) populations rather than populations defined by find.clusters
assignplot(dapc1, cex=0.4)
assignplot(dapc2, cex=0.4)

compoplot(dapc1)
compoplot(dapc2)

temp = which(apply(dapc1$posterior,1, function(e) all(e<.001)))
temp
compoplot(dapc1, subset=temp)
summary(dapc1)




