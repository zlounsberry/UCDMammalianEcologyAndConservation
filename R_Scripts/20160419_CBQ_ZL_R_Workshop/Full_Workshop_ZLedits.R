##This first section does not require packages. It works out of what is called "Base R" and is the native state of R without packages (more on those later) loaded.


############################################
###########LET'S PLAY ONE NIGHT!############
############################################

#Damn, Zach forgot the cards again...
#No worries, we can use R instead to assign roles

###### 1. whose playing?######
#We can store player names in a vector of characters

players <- c("cate", "zach", "luis", "preston", "jen", "tom", "sophie", "ben", "amanda", "mark") #make an object "players" that is a class "character" 
players

#we can alphabetize the players...
sort(players)

#we can single out players by their number in the vector
players[4]

#or by their name...
players=="jen"
which(players=="jen")

#and we can ask how many players we have
length(players)

##### 2. let's store all of the possible roles in a vector#####

roles <- c(rep("werewolf", 2), "minion", rep("villager", 4), "seer", "troublemaker", "hunter",
           "insomniac", rep("mason", 2), "drunk", "doppleganger")
roles
length(roles)

#too many, lets get rid of doppleganger and drunk
roles <- roles[-(14:15)] #since we know the positions of these offhand, we can remove them like this
roles

#Or, if we didn't know the positions, we can find their positions and eliminate them that way.
roles <- c(rep("werewolf", 2), "minion", rep("villager", 4), "seer", "troublemaker", "hunter",
           "insomniac", rep("mason", 2), "drunk", "doppleganger")
Badroles <- c(which(roles=="drunk"),which(roles=="doppleganger"))
roles <- roles[-Badroles]
roles

#We'll make a third vector indicating which team each role is on (notice the "as.factor" when making this object)
team <- as.factor(c(rep("WEREWOLF", 3), rep("VILLAGER", 10)))
team

#and then combine these into a data frame (like a matrix, but can store things besides numbers)
cards <- data.frame(roles=roles, team=team, stringsAsFactors = F)

head(cards)
dim(cards)
str(cards)

###### 3. Deal out the cards#####

#shuffle
deal1 <- sample(roles, size=length(players), replace = FALSE)
deal1
#deal out to players
game1 <- rbind(players=players, deal1=deal1)
colnames(game1) <- paste("card", 1:length(players), sep="_")
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
install.packages(c("ape","pegas","seqinr","ggplot2","devtools","adegenet","wordcloud","hierfstat"))

#Now load the packages (this tells R that you want to use functions built into these packages, which are not part of base R)
library("ape")
library("pegas")
library("seqinr")
library("ggplot2")
library("devtools")
library("adegenet")
library("wordcloud")
library("hierfstat")

##make a directory on your desktop (your filepath will be different than mine unless you named yourself Zach on your computer...
dir.create("C:/Users/Zach/Desktop/RWorkshop") 

##Make this the directory you plan to work
setwd("C:/Users/Zach/Desktop/RWorkshop")

##Copy the file from your downloads directory into this new directory you made
file.copy("C:/Users/Zach/Downloads/MontaneFoxes_20160419.stru","C:/Users/Zach/Desktop/RWorkshop/MontaneFoxes_20160419.stru") 

##Read in the DNA in structure format
DNA=read.structure("MontaneFoxes_20160419.stru",n.ind=230,n.loc=33,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1) 

##Check out the data in messy number form
sum=summary(DNA)

##Check out the data is clean pretty graphic form
dev.new(width=160, height=65) #This will make a new device
par(mfrow=c(1,3), mar=c(8,5,2,2))
barplot(sum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus", las=3) # Shows # of alleles per locus
barplot(sum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed",ylab="Hexp - Hobs", las=3) # Shows expected - observed heterozygosity
barplot(sum$pop.eff,main="Sample sizes per population",ylab="Number of genotypes", las=3) # Number of samples per population

##Curious about comparing populations? Use "seppop" to check it out.
UtahDNA = seppop(DNA)$Utah
Utahsum=summary(UtahDNA)
RockiesDNA = seppop(DNA)$Rockies
Rockiessum=summary(RockiesDNA)
dev.new(width=160, height=65) #Thisw will make a new device
par(mfrow=c(2,2),mar=c(8,5,2,2))
barplot(Utahsum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus - Utah", las=3, col="dodgerblue1") # Shows # of alleles per locus
barplot(Utahsum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed - Utah",ylab="Hexp - Hobs", las=3,col="dodgerblue1") # Shows expected - observed heterozygosity
barplot(Rockiessum$loc.n.all,ylab="Number of alleles",main="Number of alleles per locus - Rockies", las=3, col="firebrick1") # Shows # of alleles per locus
barplot(Rockiessum$Hexp-sum$Hobs,main="Heterozygosity: expected-observed - Rockies",ylab="Hexp - Hobs", las=3,col="firebrick1") # Shows expected - observed heterozygosity

#Checking to see if observed H is lower than expected
t.test(sum$Hexp,sum$Hobs,pair=T,var.equal=TRUE,alter="greater")

#Checking for deviations from HWE from pegas' locus-by-locus hw.test.
hw.test(DNA, B=1000) # B refers to the number of permutations to use for Monte-Carlo simulations
hw.test(UtahDNA, B=1000)
hw.test(RockiesDNA, B=1000)

############################################
##################PCAs######################
############################################

####ZL: edit/annotate/delete/replace as much as you want here.  
#and there are a few things specifically i'm having trouble with,
#such as legends in the s.plots
#also note that I edited the .stru file because I the CA-nonnative and nonnatives were suspiciously similar

#PCA's are created from allele frequencies that are contained in the $tab portion of our object
#Let's explore it
DNA$tab[1:5,1:8]
dim(DNA$tab)

#There are a few things we need to do before we can do a PCA

#First, how many missing data do we have?  We will need to replace these.
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
loadingplot(pca1$c1^2)


#Let's see the pretty pictures!
s.class(pca1$li, pop(DNA))
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#We can make prettier
mycol <- funky(nPop(DNA))

#without inertia ellipses
s.class(pca1$li, pop(DNA),xax=1,yax=2, col=transp(col,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, label="", cellipse=0,
        sub=popNames(DNA), csub=.75, possub="topleft") #Why isn't the legend working?
title("Western red fox")
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#with inertia ellipses
s.class(pca1$li, pop(DNA),xax=1,yax=2, col=transp(mycol,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("Western red fox")
add.scatter.eig(pca1$eig[1:20], 3,1,2)

#We can also ignore group membership and use color as an additional representation of the first 3 PCs
colorplot(pca1$li, pca1$li, cex=3, xlab="PC 1", ylab="PC 2") 
title("Western red fox")
text(pca1$li[,1], pca1$li[,2], labels=pop(DNA), cex=.6, pos=1, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or foxesarse one
add.scatter.eig(pca1$eig[1:20], 3,1,2, ratio=.2)
abline(v=0,h=0,col="grey", lty=2)

#Sonora Pass and Lassen obviously influenced by drift.  Let's remove them.

#Zach: is there a smoother way to do this? (exclude one or two pops)
q <- seppop(DNA)
names(q)
small <- q[-c(4,9)]
small <- repool(small)


X <- scaleGen(small, NA.method="mean") 
pca1 <- dudi.pca(X, center=F, scale=F, scannf=F, nf=3)

#colorplot
colorplot(pca1$li, pca1$li, cex=3, xlab="PC 1", ylab="PC 2") 
title("Western red fox (no Lassen or SP)")
text(pca1$li[,1], pca1$li[,2], labels=pop(small), cex=.6, pos=1, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or foxesarse one
add.scatter.eig(pca1$eig[1:20], 3,1,2, ratio=.2)
abline(v=0,h=0,col="grey", lty=2)

#traditional 
s.class(pca1$li, pop(small),xax=1,yax=2, col=transp(mycol,.9), axesell=FALSE, 
        cstar=0, cpoint=3, grid=FALSE, clabel=.75)
title("Rocky Mt red fox")
add.scatter.eig(pca1$eig[1:20], 3,1,1)

#Or we can look at just the Rockies complex
small <- q[c("Idaho","Nevada", "Rockies", "Utah")]
small <- repool(small)

X <- scaleGen(small, NA.method="mean") #centers and scales the allele frequencies before PCA. 
pca1 <- dudi.pca(X, center=F, scale=F, scannf=F, nf=3)

colorplot(pca1$li, pca1$li, cex=4, xlab="PC 1", ylab="PC 2") 
title("PCA of Rockies red fo, 33 loci, PC axes 1&2")
text(pca1$li[,1], pca1$li[,2], labels=pop(small), cex=.75, pos=1, new=FALSE) #labels points; don't use this for a large PCA, but you can use it for a small or foxesarse one
add.scatter.eig(pca1$eig[1:20], 3,1,2, ratio=.2)
abline(v=0,h=0,col="grey", lty=2)

#####
