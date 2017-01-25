#Run this in R 3.2.1#

library("ape")
library("pegas")
library("seqinr")
library("ggplot2")
library("devtools")
library("adegenet")
library("wordcloud")
library("hierfstat")
setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/adegenet/dogwolf")

########################################################################################################################
####################                          MICROSATELLITES 						  ###############################
########################################################################################################################


############################################################
###### 		 Basic Pop Gen Stats					 #######
############################################################

#This section will help give us an idea of the genetic characteristics of our population (H, HWE, structure, inbreeding).
DNA=read.structure("NCD33321_34683_166i_4p.stru", n.ind=166,n.loc=38,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

pops=seppop(DNA)
UN=pops$UN
DNA1=repool(pops$GermanShepherd,pops$Husky,pops$InuitGreenland,pops$Wolf)
sum=summary(DNA1)

#Plotting some statistics for each locus:
dev.new(width=80, height=45)
par(mfrow=c(1,3))
barplot(sum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus", las=3,col="dodgerblue1") # Shows # of alleles per locus
barplot(sum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed",ylab="Hexp - Hobs", las=3,col="dodgerblue1") # Shows expected - observed heterozygosity
barplot(sum$pop.eff,main="Sample sizes per population",ylab="Number of genotypes",col="dodgerblue1") # Number of samples per population
#plot(sum$pop.eff, sum$pop.nall,xlab="Population sample size",ylab="Number of alleles",main="Alleles numbers and sample sizes",type="n") 
#text(sum$pop.eff,sum$pop.nall,lab=names(sum$pop.eff))

#Checking for deviations from HWE from pegas' locus-by-locus hw.test. I need to check if this takes population information into account...
hw.test(DNA, B=1000) # B refers to the number of permutations to use for Monte-Carlo simulations

############################################################
###### 		 			PCA						 #######
############################################################

dev.new(width=60, height=45)
X = tab(DNA1, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
temp <- as.integer(pop(DNA1)) #makes a temporary object to be used for myCol and myPch (below) that convert your populations to integers
s.class(pca1$li,pop(DNA1),xax=1,yax=2,label=c('GermanShepherd','Husky','InuitGreenland','Wolf'),col=transp(c("firebrick1","dodgerblue1","black","pink","yellow"),0.75),axesell=FALSE,cstar=1,cpoint=3,grid=FALSE)
s.class(pca1$li,pop(DNA1),xax=1,yax=2,label=c('GermanShepherd','Husky','InuitGreenland','Wolf'),col=transp(c("firebrick1","dodgerblue1","black","darkgreen","pink"),0.75),axesell=FALSE,cstar=0,cell=F,cpoint=3,grid=FALSE)

############################################################
###### 		  		DAPC							 #######
############################################################

############################################################
####   This section is for pre-defined populations   #######
############################################################

DNA=read.structure("NCD33321_34683_166i_4p.stru", n.ind=166,n.loc=38,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

pops=seppop(DNA)
DNA=repool(pops$GermanShepherd,pops$Husky,pops$InuitGreenland,pops$Wolf) #Leaving out the Unknown group
par(xpd=T, mfcol=c(1,2))
mycol=transp(c("black","red","blue","purple","green","yellow"), 0.8)
table.value(table(pop(DNA)[1:132], DNA$pop[1:132]),col.lab=paste("inf",1:4),row.lab=paste(c("GermanShepherd","Husky","InuitGreenland","Wolf"))) # This looks at how your populations parse with your hypothetical populations
dapc1=dapc(DNA, DNA$pop, n.pca=100, n.da=4) #calculate your dapc (it will prompt you to choose # of PC and discriminate functions to use.
opt=optim.a.score(dapc1, plot=T)
	##This calculates the number of PCs that give you the best a value. Next section uses opt1$best to use this value as the number of PCs
dapc2=dapc(DNA, DNA$pop, n.pca=opt$best, n.da=4)
scatter(dapc2, cstar=0, col=mycol, cex=3, leg=F, txt.leg=c("GermanShepherd","Husky","InuitGreenland","Wolf"), clab=1) #scree.da=FALSE to get rid of the DA eigenvalues barplot

myInset <- function(){
temp <- dapc2$pca.eig
temp <- 100* cumsum(temp)/sum(temp)
plot(temp, col=rep(c("black","lightgrey"),
c(dapc2$n.pca,1000)), ylim=c(0,100),
xlab="PCA axis", ylab="Cumulated variance (%)",
cex=1, pch=20, type="h", lwd=2)
}

add.scatter(myInset(), posi="bottomleft",inset=c(-0.03,-0.01), ratio=.28,bg=transp("white"))


############################################################
####   This section is for looking for populations   #######
############################################################

#There is some stochasticity in terms of which clusters assign to which groups, so for the legend of the PCA, use the "table.value" results to assign names

DNA=read.structure("NCD33321_34683_166i_4p.stru", n.ind=166,n.loc=38,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

pops=seppop(DNA)
DNA=repool(pops$GermanShepherd,pops$Husky,pops$InuitGreenland,pops$Wolf) #Leaving out the Unknown group
DNAgrp=find.clusters(DNA, max.n.clust=40, n.pca=100) # This is your test for the number of clusters (k's). max.n.clust refers to the maximum number of putative clusters.
6
	##This will ask you to choose a number of PCs to retain. No reason not to take as many as possible (I did 100, hence 'n.pca=100')
	##It will then ask you to check out the BIC vs. cluster size. Pick the k associated with the lowest (meaningful) BIC value.
	##For this dataset, I chose k=6 (according to BIC)

#par(xpd=T, mfcol=c(1,2))
#table.value(table(pop(DNA), DNAgrp$grp),col.lab=paste("inf",1:6),row.lab=paste(c("GermanShepherd","Husky","InuitGreenland","Wolf")))
	##Looks like wolves are split into 3 groups here.

dapc1=dapc(DNA, DNAgrp$grp, n.pca=30, n.da=6)
opt1=optim.a.score(dapc1, plot=F)
	##This calculates the number of PCs that give you the best a value. Next section uses opt1$best to use this value as the number of PCs
dapc2=dapc(DNA, DNAgrp$grp, n.pca=opt1$best, n.da=6)

scatter(dapc2, cstar=0, col=mycol, cex=3, leg=T, txt.leg=paste("Cluster",1:6), clab=0, scree.pca=F, inset.pca=c(0.15,0.05), ratio.pca=0.2)


############################################################
########Supplementary individuals (unknown origin)##########
############################################################

DNA=read.structure("NCD33321_34683_166i_4p.stru", n.ind=166,n.loc=38,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)

pops=seppop(DNA)
UN=pops$UN
dapc1=dapc(DNA[1:132], DNA$pop[1:132], n.pca=30, n.da=4)
	##For this, using [1:132] just takes the first 132 individuals in your genind object (which is a factor, hence the notation [x:y].
	##In this dataset, that leaves off the unknown individuals, but also does not force you to repool, etc. when loci go missing.
	##Cannot do an a-score optimization if a population (here: UN) is missing. But you can do it with the whole dataset and use this value

pred.sup=predict.dapc(dapc1, newdata=UN) 
	##This will predict the assignment of individuals in the UN group (unknown)

pred.sup$posterior 
round(pred.sup$posterior, 3)
	##This gives each individual's likelihood of assignment into each population!

###To plot it###
par(xpd=TRUE)
mycol=transp(c("black","red","blue","green","pink"),0.8)
	##Assign colors to object mycol

col.points = transp(mycol[as.integer(pop(DNA))],.8) #original grouping based on original file
	##Makes specific points for the populations in the DNA dataset

scatter(dapc1, col=col.points, bg="white", scree.da=0, pch="", cstar=0, clab=1, legend=F)
	##plot an empty scatterplot to add points to (including known and unknown individuals separately)
	##Note: legend turned off because it only wants to give me one population color currently...

points(dapc1$ind.coord[,1], dapc1$ind.coord[,2], pch=20,col=col.points, cex=3)
	##Add your original dapc coordinates to the plot (color coded by pop, here)

points(pred.sup$ind.scores[,1], pred.sup$ind.scores[,2], pch=21,col=transp("green", 0.8), cex=3)
	##Plot your unknowns (in green, here)

add.scatter.eig(dapc1$eig,15,1,2, posi="bottomright", inset=.02)
	##Add your eigenvalue plot


############################################################
######Supplementary individuals (known hybrid origin)#######
############################################################

#First, hybridize German Shepherds and Wolves
temp=seppop(DNA) 
Wolf=temp$Wolf
Shep=temp$GermanShepherd
Hyb=hybridize(Shep, Wolf, n=30, pop="DogWolf") 
DNAHyb=repool(c(DNA,Hyb)) 
temp=seppop(DNAHyb) 
dapc1=dapc(DNA[1:132], DNA$pop[1:132], n.pca=8, n.da=4)
pred.sup=predict.dapc(dapc1, newdata=temp$DogWolf)
round(pred.sup$posterior,3)
par(xpd=T,mfrow=c(2,2))
mycol=transp(c("black","red","blue","purple","green","yellow"),0.9)
col.points = transp(mycol[as.integer(pop(DNA))],.8) #original grouping based on original file
scatter(dapc1, col=col.points, bg="white", scree.da=0, pch="", cstar=0, clab=0, legend=F)
points(dapc1$ind.coord[,1], dapc1$ind.coord[,2], pch=20,col=col.points, cex=3)
points(pred.sup$ind.scores[,1], pred.sup$ind.scores[,2], pch=20,col=transp("green", 0.8), cex=3)
add.scatter.eig(dapc1$eig,15,1,2, posi="bottomright", inset=.02)


########################################################################################################################
####################                          SNPs			 						  ###############################
########################################################################################################################

DNA=read.structure("NCD33321_33850_91i_2p_SNP.stru", n.ind=91,n.loc=49,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)
pops=seppop(DNA)
UN=pops$UN
DNA1=repool(pops$DOG,pops$WOLF)
sum=summary(DNA1)
dev.new(width=80, height=45)
par(mfrow=c(1,3))
barplot(sum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus", las=3) # Shows # of alleles per locus
barplot(sum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed",ylab="Hexp - Hobs", las=3) # Shows expected - observed heterozygosity
barplot(sum$pop.eff,main="Sample sizes per population",ylab="Number of genotypes") # Number of samples per population
#plot(sum$pop.eff, sum$pop.nall,xlab="Population sample size",ylab="Number of alleles",main="Alleles numbers and sample sizes",type="n") 
#text(sum$pop.eff,sum$pop.nall,lab=names(sum$pop.eff))


DNAgrp=find.clusters(DNA1, max.n.clust=40, n.pca=100) 

par(xpd=T, mfcol=c(1,2))
mycol=transp(c("black","red","blue","purple","green","yellow"), 0.8)
table.value(table(pop(DNA1), DNAgrp$grp),col.lab=paste("inf",1:2),row.lab=paste(c("DOG","WOLF"))) # This looks at how your populations parse with your hypothetical populations

dapc1=dapc(DNA1, DNA1$pop, n.pca=30, n.da=2) #calculate your dapc (it will prompt you to choose # of PC and discriminate functions to use.
opt=optim.a.score(dapc1, plot=T)
	##This calculates the number of PCs that give you the best a value. Next section uses opt1$best to use this value as the number of PCs
dapc2=dapc(DNA1, DNA1$pop, n.pca=opt$best, n.da=2)
scatter(dapc2, cstar=0, col=mycol, cex=3, leg=T, txt.leg=c("Dog","Wolf"), clab=1) #scree.da=FALSE to get rid of the DA eigenvalues barplot

##Unknown Origin##

DNA=read.structure("NCD33321_33850_91i_2p_SNP.stru", n.ind=91,n.loc=49,onerowperind=F,col.lab=1,col.pop=2,row.marknames=1) #This is 4stru.txt with the file handle changed (structure formatted txt file)
DNAgrp=find.clusters(DNA1, max.n.clust=40, n.pca=100) 
3

pops=seppop(DNA)
UN=pops$UN
DNA1=repool(pops$DOG,pops$WOLF)
dapc1=dapc(DNA1, DNAgrp$grp, n.pca=30, n.da=3)
table.value(table(pop(DNA1), DNAgrp$grp),col.lab=paste("inf",1:3),row.lab=paste(c("DOG","WOLF"))) # This looks at how your populations parse with your hypothetical populations

opt1=optim.a.score(dapc1, plot=T)
	##This calculates the number of PCs that give you the best a value. Next section uses opt1$best to use this value as the number of PCs
dapc2=dapc(DNA1, DNAgrp$grp, n.pca=opt1$best, n.da=3)

pred.sup=predict.dapc(dapc2, newdata=UN) 
	##This will predict the assignment of individuals in the UN group (unknown)

pred.sup$posterior 
round(pred.sup$posterior, 5)
	##This gives each individual's likelihood of assignment into each population!

###To plot it###
par(xpd=TRUE)
mycol=transp(c("black","red","blue","green","pink"),0.8)
	##Assign colors to object mycol

col.points = transp(mycol[as.integer(pop(DNA1))],.8) #original grouping based on original file
	##Makes specific points for the populations in the DNA dataset

scatter(dapc2, col=col.points, bg="white", scree.da=0, pch="", cstar=0, clab=1, xlim=c(-16,14), legend=F)
	##plot an empty scatterplot to add points to (including known and unknown individuals separately)
	##Note: legend turned off because it only wants to give me one population color currently...

points(dapc2$ind.coord[,1], dapc2$ind.coord[,2], pch=20,col=col.points, cex=3)
	##Add your original dapc coordinates to the plot (color coded by pop, here)

points(pred.sup$ind.scores[,1], pred.sup$ind.scores[,2], pch=20,col=transp("green", 0.8), cex=3)
	##Plot your unknowns (in green, here)

add.scatter.eig(dapc2$eig,15,1,2, posi="bottomright", inset=.02)
	##Add your eigenvalue plot




