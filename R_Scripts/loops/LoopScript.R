setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/loops") # sets your working directory

################################
#This would be for if you want to read in text files (e.g., tables from excel)
#files = Sys.glob("*.txt") #This will read every file in your working directory that has the ".txt" extension at the end into an object "files"
#for (i in files) {
#	assign(i,read.table(file=i, sep="\t", header=F))
#}
################################



################################
#This bit is for Jen.
files = Sys.glob("*.shp") #This will read every file in your working directory that has the ".shp" extension at the end into an object "files"
for (i in files) {
	assign(i, readShapeLines(i, proj4string=CRS("+proj=longlat"), verbose=TRUE,repair=FALSE, delete_null_obj=FALSE))
}
#Just replace the readShapeLines command with the one that you want to use to import. It will change i to the name of the file and read it.
################################