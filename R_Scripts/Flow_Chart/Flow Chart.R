library(diagram)
coords = coordinates(pos=c(4, 1, 4, 1, 5, 4, 3))
rx = 0.1
ry = 0.05
?openplotmat()
openplotmat(par(mar=c(0.01,0.01,0.01,0.01), xpd=T))
text(coords, lab = c(1:22), cex = 2) #This labels each coordinate

straightarrow(from = coords[2,], to = coords[7,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[7,], to = coords[6,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[6,], to = c(0.12, 0.35714286), lty = 3, lcol = "black", lwd=2)
straightarrow(from = c(0.12, 0.35714286), to = coords[20,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[20,], to = coords[21,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[21,], to = coords[18,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[18,], to = coords[10,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[18,], to = c(0.850, 0.35714286), lty = 3, lcol = "black", lwd=2)
straightarrow(from = c(0.850, 0.35714286), to = coords[9,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[10,], to = coords[7,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[9,], to = coords[4,], lty = 3, lcol = "black", lwd=2)
straightarrow(from = coords[9,], to = coords[10,], lty = 3, lcol = "black", lwd=2)


textellipse(mid = coords[2,], radx = .10, rady = 0.05, lab = "Pre-process Reads", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="black", col="white")
textellipse(mid = coords[4,], radx = .10, rady = 0.05, lab = "Consensus Sequence", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="white")
textellipse(mid = coords[6,], radx = .10, rady = 0.05, lab = "De novo assemble\n reads", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textellipse(mid = coords[7,], radx = .10, rady = 0.05, lab = "Extract only reads that\nalign to reference", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textellipse(mid = coords[10,], radx = .11, rady = 0.06, lab = "Add gap-closed sequence\nas reference", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textellipse(mid = c(0.12, 0.35714286), radx = .12, rady = 0.08, lab = "Align contigs into tentative gene\norder using reference", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80", xpd=T)
textellipse(mid = c(0.850, 0.35714286), radx = .125, rady = 0.095, lab = "Align filtered reads to continuous,\ngap-closed sequence", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textellipse(mid = coords[20,], radx = .10, rady = 0.05, lab = "Convert gaps to N’s\nto create scaffold", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")
textellipse(mid = coords[21,], radx = .10, rady = 0.05, lab = "Use filtered reads\nto close gaps", cex = 1.5, shadow.size=0.005, 
	shadow.col = "gray40", box.col="gray80")

textellipse(mid = coords[18,], radx = .055, rady = 0.045, lab = "Any N's in\nsequence?", cex = 1.5, shadow.size=0.0, 
	shadow.col = "gray40", box.col="white", lcol="white")
textellipse(mid = coords[9,], radx = .09, rady = 0.06, lab = "Any breaks in coverage (0X\ncovered regions) or\nmismatches?", cex = 1.5, shadow.size=0.0, 
	shadow.col = "gray40", box.col="white", lcol="white")

text(0.7, 0.6, "yes", cex = 1.4)
text(0.890, 0.78, "no", cex = 1.4)
text(0.575, 0.375, "yes", cex = 1.4)
text(0.69, 0.285, "no", cex = 1.4)
