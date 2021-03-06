##This first section does not require packages. It works out of what is called "Base R" and is the native state of R without packages (more on those later) loaded.
##Use hashes in code like you would on Twitter... Everything following the "#" symbol on that line gets ignored.


############################################
###########LET'S PLAY ONE NIGHT!############
############################################

#Damn, Zach forgot the cards again...
#No worries, we can use R instead to assign roles

###### 1. who's playing?######
#We can store player names in a vector of characters.
#This is an "object." Think of them as temporary files stored within R's memory. 
#You can tinker with these the same way you can a txt or excel spreadsheet.
#You can use "<-" or "=" to define an object. Objects can have different classes (and types) 
  #the same way files can be different extensions. The class/type matters!

players <- c("cate", "zach", "luis", "preston", "jen", "tom", "sophie", "ben", "amanda", "mark") #make an object "players" that is a class "character" 
players
class(players)

#we can alphabetize the players...
sort(players)

#we can single out players by their number in the vector
players[4]

#or by their name...
players=="jen" #notice the "==", which is different than "="!!
which(players=="jen")
#tip: if you don't know what a function does, you can look it up

#and we can ask how many players we have
length(players)

##### 2. let's store all of the possible roles in a vector#####

roles <- c(rep("werewolf", 2), "minion", rep("villager", 4), "seer", "troublemaker", "hunter",
           "insomniac", rep("mason", 2), "drunk", "doppleganger")
roles
length(roles)
class(roles)
is.vector(roles) #returns TRUE b/c it's a vector
is.data.frame(roles) #returns FALSE b/c it's not a data.frame

#Anyway, too many roles, so let's get rid of doppleganger and drunk
roles <- roles[-(14:15)] #since we know the positions of these offhand, we can remove them like this
roles

#Or, if we didn't know the positions, we can find their positions and eliminate them that way.
roles <- c(rep("werewolf", 2), "minion", rep("villager", 4), "seer", "troublemaker", "hunter",
           "insomniac", rep("mason", 2), "drunk", "doppleganger")
Badroles <- c(which(roles=="drunk"),which(roles=="doppleganger"))
Badroles
roles <- roles[-Badroles]
roles

#We'll make a third vector indicating which team each role is on (notice the "as.factor" when making this object)
team <- as.factor(c(rep("WEREWOLF", 3), rep("VILLAGER", 10)))
team
class(team)

#and then combine these into a data frame (like a matrix, but can store things besides numbers)
#These have to be the same length! IF they are not, R will refuse to make your data frame and you will get upset.
cards <- data.frame(roles=roles, team=team, stringsAsFactors = F)

head(cards)
dim(cards)
str(cards)

###### 3. Deal out the cards#####

#shuffle
deal1 <- sample(roles, size=length(players), replace = FALSE)
deal1
#deal out to players
game1 <- rbind(players=players, deal1=deal1) #rbind() is a handy way to concatenate rows.
colnames(game1) <- paste("card", 1:length(players), sep="_") #paste() smushes together everything separated by commas: paste("what a","great", "comment", "!!", sep=" ")
game1

#5 minutes pass: We decide to kill Zach.
#But which team was he on?  Everyone needs to flip over their cards

which(players=="zach")
game1[2,which(players=="zach")]

#and what team is that?
losingteam <- cards[which(cards$roles==game1[2,players=="zach"]),2][1]
losingteam

#so the winners are...
winningcards <- cards[which(cards$team!=losingteam),1]
winningcards

#which means these people win the game!
players[deal1 %in% winningcards]

#and these people lose
players[!(deal1 %in% winningcards)]

######Let's play 100 games to see who's the overall winner for the month#####
ngames <- 100

# initialize a blank data frame that we will populate with a loop
deals <- data.frame(matrix(NA, nrow=ngames, ncol=length(players)))
colnames(deals) <- players
head(deals)
#...and a blank vector for who gets killed each game
killed <- rep(NA,ngames)

#create a loop for dealing cards
for (i in 1:ngames) {
  deals[i,] <- sample(x = cards$roles, size=length(players), replace = FALSE)
  killed[i] <- sample(players,1)
}

deals

#create empty winner matrix
winners <- matrix(0, nrow=ngames, ncol=length(players))
colnames(winners) <- players
rownames(winners) <- 1:ngames

for (i in 1:ngames) {
  #what role was the person who was killed
  tmprole <- deals[i,colnames(deals)==killed[i]]
  #what team was that?
  losingteam <- cards[which(cards$roles==tmprole), 2][1]
  winningcards <- cards[which(cards$team!=losingteam),1]
  winners[i,players[deals[i,] %in% winningcards]] <- 1
  }

head(winners)

#how many games did each person win?
total <- apply(winners, 2, sum)
total

#graphically
barplot(total, main="Total Number of Games Won", las=3, col="orange")

#ultimate winner is...
names(which.max(total))




###############################################
###That was fun, now let's do some genetics!###
###############################################

#Let's install the necessary packages (aka "libraries")
#install.packages(c("ape","pegas","seqinr","ggplot2","devtools","adegenet","wordcloud","hierfstat"))

#Now load the packages (this tells R that you want to use functions built into these packages, which are not part of base R)
library("ape")
library("pegas")
library("seqinr")
library("ggplot2")
library("adegenet")
library("hierfstat")
library("poppr")

##make a directory on your desktop (your filepath will be different than mine unless you named yourself Zach on your computer...
dir.create("C:/Users/Zach/Desktop/RWorkshop") 

##Make this the directory you plan to work
setwd("C:/Users/Zach/Desktop/RWorkshop")

##Copy the file from your downloads directory into this new directory you made
##If you ever don't know what a full filepath is, you can navigate to it in Windows and right-click and go to "Properties"
##Copying and pasting that properties path works. However, the slashes are in the wrong direction! Change from "\" to "/" (as below) or R can't read them.
file.copy("C:/Users/Zach/Downloads/MontaneFoxes_20160419.stru","C:/Users/Zach/Desktop/RWorkshop/MontaneFoxes_20160419.stru") 

##Read in the DNA in structure format
DNA=read.structure("MontaneFoxes_20160419.stru",n.ind=207,n.loc=33,onerowperind=T,col.lab=2,col.pop=1,row.marknames=1) 

##Check out the data in messy number form
sum=summary(DNA)

##Check out the data is clean pretty graphic form
dev.new(width=160, height=65) #This will make a new device
par(mfrow=c(1,3), mar=c(8,5,2,2))
barplot(sum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus", las=3, col="darkgreen") # Shows # of alleles per locus
barplot(sum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed",ylab="Hexp - Hobs", las=3, col=c("yellow","black","white", "red2")) # Shows expected - observed heterozygosity
barplot(sum$pop.eff,main="Sample sizes per population",ylab="Number of genotypes", las=3, col="gray25") # Number of samples per population


##Curious about comparing populations? Use "seppop" to check it out.
UtahDNA = seppop(DNA)$Utah
Utahsum=summary(UtahDNA)
RockiesDNA = seppop(DNA)$Rockies
Rockiessum=summary(RockiesDNA)
dev.new(width=160, height=65) #This will make a new device

par(mfrow=c(2,2),mar=c(8,5,2,2))
barplot(Utahsum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus - Utah", las=3, col="dodgerblue1") # Shows # of alleles per locus
barplot(Utahsum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed - Utah",ylab="Hexp - Hobs", las=3,col="dodgerblue1") # Shows expected - observed heterozygosity
barplot(Rockiessum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus - Rockies", las=3, col="firebrick1") # Shows # of alleles per locus
barplot(Rockiessum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed - Rockies",ylab="Hexp - Hobs", las=3,col="firebrick1") # Shows expected - observed heterozygosity

#Checking to see if observed H is lower than expected
t.test(sum$Hexp,sum$Hobs,pair=T,var.equal=TRUE,alter="greater")
t.test(Utahsum$Hexp,Utahsum$Hobs,pair=T,var.equal=TRUE,alter="greater")
t.test(Rockiessum$Hexp,Rockiessum$Hobs,pair=T,var.equal=TRUE,alter="greater")


#Checking for deviations from HWE from pegas' locus-by-locus hw.test.
hw.test(DNA, B=1000) # B refers to the number of permutations to use for Monte-Carlo simulations
hw.test(UtahDNA, B=1000)
hw.test(RockiesDNA, B=1000)

############################################
##################PCAs######################
############################################

#(getting rid of fake Oregon popualtion)
DNA = popsub(DNA, blacklist="OregonCascades")

#PCA's are created from allele frequencies that are contained in the $tab portion of our object
#Let's explore it
DNA$tab[1:5,1:8]
dim(DNA$tab)

#There are a few things we need to do before we can do a PCA

#First, how much missing data do we have?  We will need to replace these.
sum(is.na(DNA$tab))
#Second, we need to normalize the data (subtract means of each allele and divide by their standard deviation)

#Conveniently, the function scaleGen does both
X <- scaleGen(DNA, NA.method="mean", center=TRUE, scale=TRUE) #replaces Nas; centers and scales the allele frequencies before PCA. 
X[1:5, 1:8]

#Now we can do the PCA
pca1 <- dudi.pca(X, center=F, scale=F, scannf=F, nf=3)

pca1
summary(pca1)

#Important components of a dudi.pca object:
head(pca1$eig) #eigenvalues (indicating amount of variance)
pca1$eig[1:10]/sum(pca1$eig) #proporition variance explained for first 10 PCs

head(pca1$li) #the principle components (e.g. our synthetic variables)

head(pca1$c1) #the allele loadings--contribution to each PC
par(mfrow=c(1,1))
loadingplot(pca1$c1^2)

##Cool, can we clean it up? Sure! Use this complicated nightmare:

NewLoad = (pca1$c1^2)[order((pca1$c1^2)[,1], decreasing=T),]
loadingplot(NewLoad)

##Can we make it... I dunno, readable?
loadingplot(head(NewLoad,15), threshold=0)


##Hmm, what's up with the 176 allele in CPH3?
CP = DNA$tab
CPH3.176 = CP[, "CPH3.176"]
table(CPH3.176)
rownames(CP)[CPH3.176 == 1]
rownames(CP)[CPH3.176 == 2]

##Ah, 176 allele at CPH3 is a Lassen allele!!

#Let's see the pictures!
s.class(pca1$li, pop(DNA))
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#We can make prettier
mycol <- funky(nPop(DNA))

#without inertia ellipses
s.class(pca1$li, pop(DNA),xax=1,yax=2, col=transp(mycol,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, cellipse=0, lab="") 
title("PCA - western fox", cex.main=3)
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#with inertia ellipses
s.class(pca1$li, pop(DNA),xax=1,yax=2, col=transp(mycol,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA - western fox")
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#We can also ignore group membership and use color as an additional representation of the first 3 PCs
par(mar=c(5,7,5,5))
colorplot(pca1$li, pca1$li, cex=3, xlab="PC 1", ylab="PC 2", cex.axis=2, cex.lab=4, tck=F) 
abline(v=0,h=0,col="grey", lty=2)
colorplot(pca1$li, pca1$li, cex=3, xlab="PC 1", ylab="PC 2", add=T) 
text(pca1$li[,1], pca1$li[,2], labels=pop(DNA), cex=.6, pos=1, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a DNA_noSN or foxesarse one
title("PCA - western fox", cex.main=4)
add.scatter.eig(pca1$eig[1:20], 3,1,2, ratio=.18)

#Sonora Pass and Lassen obviously influenced by drift.  Let's remove them.
length(popNames(DNA))
DNA_noSN = popsub(DNA, blacklist=c("Lassen","SonoraPass")) #the popsub command from the "poppr" library allows you to blacklist population names
length(popNames(DNA_noSN))

X2 <- scaleGen(DNA_noSN, NA.method="mean") 
pca2 <- dudi.pca(X2, center=F, scale=F, scannf=F, nf=3)

#Back to the PCA with ellipses
s.class(pca2$li, pop(DNA_noSN),xax=1,yax=2, col=transp(mycol,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA - subset western fox", cex.main=4)
add.scatter.eig(pca1$eig[1:20], 3,1,2)


#colorplot
par(mar=c(5,7,5,5))
colorplot(pca2$li, pca2$li, cex=3, xlab="PC 1", ylab="PC 2", cex.axis=2, cex.lab=4, tck=F) 
abline(v=0,h=0,col="grey", lty=2)
colorplot(pca2$li, pca2$li, cex=3, xlab="PC 1", ylab="PC 2", add=T) 
text(pca2$li[,1], pca2$li[,2], labels=pop(DNA_noSN), cex=.6, pos=1, new=FALSE)
title("PCA - some western fox", cex.main=4)
add.scatter.eig(pca2$eig[1:20], 3,1,2, ratio=.18)


#Or we can look at just the Rockies complex
DNA_rockies <- popsub(DNA, sublist=c("Idaho","Nevada", "Rockies", "Utah"))

X3 <- scaleGen(DNA_rockies, NA.method="mean") #centers and scales the allele frequencies before PCA. 
pca3 <- dudi.pca(X3, center=F, scale=F, scannf=F, nf=3)

#traditional 
s.class(pca3$li, pop(DNA_rockies),xax=1,yax=2, col=c("dark orange"," dodgerblue1","dark green","firebrick1"), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA - Rockies")
add.scatter.eig(pca3$eig[1:20], 3,1,1)

############################################
##################DAPC######################
############################################


#In principle, DAPC is simple to do... Only one line of code

dapc1 <- dapc(DNA, DNA$pop)
#The function will prompt you to choose a number of PCs to retain and discriminant functions to use.
#If you retain too many PCs you'll overfit the data, too few you and you lose power to discrimate groups
#The number of discrimant retained has more to do with computation (I think)

#Look at the object
dapc1
#Plot
scatter(dapc1, cstar=0, col=transp(funky(nPop(DNA)),1), cex=3, leg=F, txt.leg=popNames(DNA), clab=.6)

#allele contributions to axis 1
loadingplot(dapc1$var.contr, axis=1,thres=.07, lab.jitter=1, threshold=.03)

#Let's look at DAPC and PCA side by side
par(mfrow=c(2,1)) #sets graphic parameters to plot 2 rows of 1

#PCA
s.class(pca1$li, pop(DNA),xax=1,yax=2, col=transp(funky(nPop(DNA)),.9), axesell=FALSE,
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA")
#DAPC
scatter(dapc1, cstar=0, col=transp(funky(nPop(DNA)),.9), cex=3, leg=F, clab=.75)
title("DAPC")

#How about the other subsets we looked at?
dapc2 <- dapc(DNA_noSN, DNA_noSN$pop, n.pca = 40, n.da = 8)
#Look at DAPC and PCA side by side
#PCA
s.class(pca2$li, pop(DNA_noSN),xax=1,yax=2, col=transp(funky(nPop(DNA_noSN)),.9), axesell=FALSE,
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA")
#DAPC
scatter(dapc2, cstar=0, col=transp(funky(nPop(DNA_noSN)),.9), cex=3, leg=F, clab=.75)
title("DAPC")

dapc3 <- dapc(DNA_rockies, DNA_rockies$pop, n.pca=40, n.da=3)
#Look at DAPC and PCA side by side
#PCA
s.class(pca3$li, pop(DNA_rockies),xax=1,yax=2, col=c("dark orange"," dark blue","dark green","dark red"), axesell=FALSE,
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("PCA")
#DAPC
scatter(dapc3, cstar=0, col=c("dark orange"," dark blue","dark green","dark red"), cex=3, leg=F, clab=.75)
title("DAPC")

##So, because DAPC is maximizing among group variation and minimizing within group variation,
#it acts to "pulls apart" the centers of our pre-defined groups.
##But... there are two major hurdles:
#1) The number of PCs analyzed is not a trivial choice
#2) The apporach requires pre-defined groups, and how we choose group membership majorly influence results

#####Let's tackle the issue  one first: How do we decide number of PCs to retain?#####

#Let's get an intuitive idea of how PCs retained influence the plot?####
dapc2a <- dapc(DNA_noSN, DNA_noSN$pop, n.pca = 60, n.da = 8) #lots of PCs
dapc2b <- dapc(DNA_noSN, DNA_noSN$pop, n.pca = 5, n.da = 10) #few PCs

#plot
scatter(dapc2a, cstar=0, col=transp(mycol, .9), cex=3, leg=F, clab=.75)
title("50 PCs analyzed")
scatter(dapc2b, cstar=0, col=transp(mycol, .9), cex=3, leg=F, clab=.75)
title("10 PCs analyzed")

#structure-like plot
par(mar=c(5.1, 4.1, 1.1, 1.1), xpd=T)
compoplot(dapc2a, posi=list(x=11,y=-.01), main="50 PCs",
          txt.leg=popNames(DNA_noSN), lab="", leg=F,
          ncol=1, xlab="", col=mycol)

compoplot(dapc2b, posi=list(x=11,y=-.01), main="10 PCs",
          txt.leg=popNames(DNA_noSN), lab="", leg=F,
          ncol=1, xlab="", col=mycol)

#Clearly there are trade-offs between discriminant power and overfitting the data
#So how do we choose?

#One way is to use the a-score to optimize

#What is the a-score?
# a-score = observed discrimination - random discrimination
# essentially we repeat DAPC using random groups
# and calculate the proportion of successful reassignment

#a-score for many PCs
temp.a <- a.score(dapc2a)
temp.a
#a score for few PCs
temp.b <- a.score(dapc2b)
temp.b

#There's a function in adegenet that will optimize the numbers of PC by this a-score
dev.off() #clear graphical parameters
oa <- optim.a.score(dapc1)

#Another option is to use cross-validation to test
#(or, alternatively, we could actually withhold samples)
mat <- as.matrix(X)
grp <- pop(DNA)
xval <- xvalDapc(mat, grp, n.pca.max = 20, training.set = 0.9,
     result = "groupMean", center = TRUE, scale = FALSE,
     n.pca = NULL, n.rep = 30, xval.plot = TRUE)
xval[2:6]

#####ISSUE 2: IDENTIFYING CLUSTERS#####

#In the adegent package there is an option to identify the number of clusters and
#membership of individuals, using a K-means clustering algorithm
#K-means partitions data by minimizing the sum of squares from each point to its assigned center
#The function find.clusters goes through data iteratively, and reports the summary BIC value
#for each increasing value of K


#we transform to PCs first to make algorithm more efficient, but here we want to retain all the PCs
grp <- find.clusters(DNA, max.n.clus=15, n.pca=300)

#looking for low dip in BIC
k <- 6

#How do inferred clusters correspond to our geographic designations?
table(pop(DNA), grp$grp)
table.value(table(pop(DNA), grp$grp), col.lab=paste("inf", 1:k), row.lab=popNames(DNA))

#determine optimal number of PCs for DAPC
dapc_final <- dapc(DNA, grp$grp, n.pca = optim.a.score(dapc1)$best, n.da = k-1)

#plot
par(mfrow=c(2,1))

scatter(dapc_final, cstar=0, col=transp(funky(k),.9), cex=3, leg=F, clab=.75)
title("K-means cluster")
dapc1b <- dapc(DNA, DNA$pop, n.pca = 7, n.da = 10)
scatter(dapc1b, cstar=0, col=transp(funky(nPop(DNA_noSN)),.9), cex=3, leg=F, clab=.6)
title("Pre-assigned groups")


#We can also plot posterior probabilities in a structure-like barplot
dev.off()
par(mar=c(5.1, 4.1, 1.1, 1.1), xpd=T)
compoplot(dapc_final, leg=F, lab=DNA$pop, ncol=1, col=funky(k))

#could customize and make prettier in ggplot2
#see ZL's stacked barplot chart
#posterior probabilities can be accessed using:
round((dapc_final$posterior),3)


#now can customize plot in ggplot2

library(reshape)
posts <- melt((dapc_final$posterior), id.var=row.names())
colnames(posts) <- c("indiv", "grp", "prob")
posts$grp <- as.factor(posts$grp)

ggplot(posts, aes(x = indiv, y = prob, fill = grp, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
  geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
  scale_fill_manual(values=c("#A6CEE3", "#99CD91", "#B89B74", "#F06C45", "#ED8F47", "#825D99", "#B15928")) +  #Sets the colours (assigned by fill = variable above)
  coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
  ylab("Probability of assignment\n") + #added newline char to increase space between label
  theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) + 
  theme(axis.title.x = element_text(color="black", size=35, face="bold")) +
  theme(axis.text.y = element_text(color="black", size=20)) +
  xlab("Individuals") +
  theme(axis.text.x = element_blank()) +
  theme(axis.ticks.x = element_blank()) +
  theme(panel.background = element_blank()) +
  guides(fill=FALSE)

####END###







#########################SAME SCRIPT AS ABOVEBUT FOR DATASET WITHOUT LASSEN/SN3#####################


#In the adegent package there is an option to identify the number of clusters and
#membership of individuals, using a K-means clustering algorithm
#K-means partitions data by minimizing the sum of squares from each point to its assigned center
#The function find.clusters goes through data iteratively, and reports the summary BIC value
#for each increasing value of K


#we transform to PCs first to make algorithm more efficient, but here we want to retain all the PCs
grp <- find.clusters(DNA_noSN, max.n.clus=15, n.pca=300)

#looking for low dip in BIC
k <- 4

#How do inferred clusters correspond to our geographic designations?
table(pop(DNA_noSN), grp$grp)
table.value(table(pop(DNA_noSN), grp$grp), col.lab=paste("inf", 1:k,
         row.lab=popNames(DNA_noSN))


#determine optimal number of PCs for DAPC
dapc_final <- dapc(DNA_noSN, grp$grp, n.pca = optim.a.score(dapc2a)$best, n.da = k-1)

#plot
par(mfrow=c(2,1))

scatter(dapc_final, cstar=0, col=transp(funky(k),.9), cex=3, leg=F, clab=.75)
title("K-means cluster")
dapc1b <- dapc(DNA_noSN, DNA_noSN$pop, n.pca = 7, n.da = 10)
scatter(dapc2b, cstar=0, col=transp(funky(nPop(DNA_noSN)),.9), cex=3, leg=F, clab=.6)
title("Pre-assigned groups")
