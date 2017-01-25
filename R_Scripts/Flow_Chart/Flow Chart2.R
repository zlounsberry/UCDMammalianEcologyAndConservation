#library(diagram)
#coords = coordinates(pos=c(4, 1, 4, 1, 5, 4, 3))
#rx = 0.1
#ry = 0.05
openplotmat(par(mar=c(2,2,2,2), xpd=T))
#text(coords, lab = c(1:22), cex = 2) #This labels each coordinate

straightarrow(from = coords[2,], to = coords[7,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[7,], to = coords[6,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[6,], to = c(0.12, 0.35714286), lty = 3, lcol = "black", lwd=2)
straightarrow(from = c(0.12, 0.35714286), to = coords[20,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[20,], to = coords[21,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[21,], to = coords[18,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[18,], to = c(0.5, 0.45), lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[18,], to = c(0.850, 0.35714286), lty = 3, lcol = "black", lwd=2)
straightarrow(from = c(0.850, 0.35714286), to = coords[9,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = c(0.5, 0.45), to = coords[7,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[9,], to = coords[4,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[9,], to = c(0.5, 0.45), lty = 3, lcol = "black", lwd=2)


textellipse(mid = coords[2,], radx = .10, rady = 0.05, lab = "Pre-process Reads", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="black", col="white")
textellipse(mid = coords[4,], radx = .10, rady = 0.05, lab = "Consensus Sequence", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="white")
textrect(mid = coords[6,], radx = .10, rady = 0.05, lab = "De novo assemble\n reads", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textrect(mid = coords[7,], radx = .11, rady = 0.055, lab = "Extract only reads that\nalign to reference", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textrect(mid = c(0.5, 0.45), radx = .12, rady = 0.052, lab = "Add gap-closed sequence\nas reference", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textrect(mid = c(0.12, 0.35714286), radx = .13, rady = 0.055, lab = "Align contigs into tentative\ngene order using reference", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80", xpd=T)
textrect(mid = c(0.850, 0.35714286), radx = .15, rady = 0.055, lab = "Align filtered reads to\ncontinuous, gap-closed sequence", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textrect(mid = coords[20,], radx = .10, rady = 0.055, lab = "Convert gaps to N’s\nto create scaffold", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textrect(mid = coords[21,], radx = .09, rady = 0.055, lab = "Use filtered reads\nto close gaps", cex = 2.2, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")

textellipse(mid = coords[18,], radx = .06, rady = 0.055, lab = "Any N's in\nsequence?", cex = 2.2, shadow.size=0.0, 
	shadow.col = "gray40", box.col="white", lcol="white")
textellipse(mid = coords[9,], radx = .10, rady = 0.07, lab = "Any breaks in coverage\n (0X covered regions)\nor mismatches?", cex = 2.2, shadow.size=0.0, 
	shadow.col = "gray40", box.col="white", lcol="white")

text(0.7, 0.6, "yes", cex = 1.4) #top
text(0.890, 0.78, "no", cex = 1.4) #top

text(0.58, 0.34, "yes", cex = 1.4) #bot
text(0.74, 0.25, "no", cex = 1.4) #bot
