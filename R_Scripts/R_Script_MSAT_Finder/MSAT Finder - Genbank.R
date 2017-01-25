setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
library(ape)
acc = read.table("nuccore_result.txt")
acc
accfix = as.character(unlist(c(acc)))
accfix
mode(accfix)
newtable = edit(acc)
edit(accfix)

read.GenBank(accfix, seq.names = accfix, species.names = TRUE, as.character = FALSE)

foxdat = read.table("foxCB.txt")
fox = as.character(unlist(c(foxdat)))
foxDNA = read.GenBank(fox, seq.names = access.nb, species.names = TRUE, as.character = TRUE)

ifelse(cat(foxDNA[[2]], "\n", sep = "") == cat(foxDNA[[5]], "\n", sep = ""), "yes", "no")
 
foxDNA[[2]]

foxDNA[2]
cat(foxDNA[[2]], "\n", sep = "")

setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
acc = read.table("nucest_result.txt")
acc
accfix = as.character(unlist(c(acc)))
accfix
mode(accfix)

wormest = read.GenBank(accfix, seq.names = accfix, species.names = TRUE, as.character = FALSE)

?read.GenBank

cat(wormest[[15000]], "\n", sep = "")

?cat()

write.dna(wormest[1:5000], "C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder\\suck_it_R.fas", format = "fasta", append = FALSE, nbcol = -1, colsep = "", colw = 500, indent = 0, blocksep = 0)

?write.dna

read.dna(accfix[3])

?read.nexus