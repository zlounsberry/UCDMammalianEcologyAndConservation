#setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\TreeBuilding") #sets your working directory
#source for this method: https://www.biostars.org/p/100432/

library(ape)
library(phangorn)

#This matrix is saved as "V:\\3730Data\\377STRs\\Wildlife\\Kris\\SNPmatrixforR.xlsx" on the Nomissing tab.
snp=rbind(Alaska1=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Alaska2=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Alaska3=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Canada4=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Canada5=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Canada6=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Colorado7=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
East8=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Europe9=c(1,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,0),
Europe10=c(1,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,0),
Iraq11=c(1,1,0,0,0,0,1,0,0,0,1,1,1,1,1,0,0,0,1),
Iraq12=c(1,1,0,0,0,0,1,0,0,0,1,1,1,1,1,0,0,0,1),
Iraq13=c(1,1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1),
Iraq14=c(1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,1),
Lassen15=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana16=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana17=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana18=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana19=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana20=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Montana21=c(0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1),
Nepal22=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1),
Yamal23=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1),
Yamal24=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1),
Yamal25=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1),
Yamal26=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1),
Yamal27=c(0,1,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1))


#par(mfrow=c(2,2))
dm = dist.gene(snp,method = "pairwise")
tree = nj(dm)
par(xpd=T)
plot(tree, cex=2, font=2, edge.width=5, type="phylogram", label.offset=0.1)
add.scale.bar(0,-1, lwd=3,cex=2, font=2)
#tree = bionj(dm)
#plot(tree)
#tree = fastme.bal(dm, nni = TRUE, spr = TRUE, tbr = TRUE)
#plot(tree)
#tree = fastme.ols(dm, nni = TRUE)
#plot(tree)


