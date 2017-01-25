setwd("V:/3730Data/377STRs/Wildlife/DeerMendocinoStudy/ZL-Deer Mendocino/Deer - Zach's Desktop/Geneland/2011")
library(rgdal) #Need Package rgdal to run this, so make sure that's installed and working.

setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Lat Long to UTM Converter")
xy
xy = read.table("Carolyn.txt", row.names = NULL)
#The above line reads your table of lat/longs. If you have headers, just drop a "header = TRUE" after the ',' in '...txt",' 

xy = as.matrix(xy) #rgdal likes matrices. 

UTM = project(xy, "+proj=utm +zone=35S ellps=WGS84") #Creates a matrix (named UTM) of UTMs converted from your lat/longs. You can check out the zone by using a converter online
#	like this one: http://www.rcn.montana.edu/resources/tools/coordinates.aspx . Put one of your lat/longs in there and see what zone it spits out. Then enter that zone here.

UTM #Check it to make sure it looks right.

write(UTM, file = "Carolyn_UTM2.txt", ncolumns = 1, append = FALSE, sep = " ") #This just writes a 1-column data file that you can pull into excel. Multiple columns were hard, and I'm busy. 
#	Just pull the Northing values from the "n+1"th row into column B and you're fine.

##2012##

setwd("V:/3730Data/377STRs/Wildlife/DeerMendocinoStudy/ZL-Deer Mendocino/Deer - Zach's Desktop/Geneland/2012")
library(rgdal) #Need Package rgdal to run this, so make sure that's installed and working.


xy = read.table("2012 Lat Longs.txt", row.names = NULL, header = T)
#The above line reads your table of lat/longs. If you have headers, just drop a "header = TRUE" after the ',' in '...txt",' 

xy = as.matrix(xy) #rgdal likes matrices. 

xy

UTM = project(xy, "+proj=utm +zone=10 ellps=WGS84") #Creates a matrix (named UTM) of UTMs converted from your lat/longs. You can check out the zone by using a converter online
#	like this one: http://www.rcn.montana.edu/resources/tools/coordinates.aspx . Put one of your lat/longs in there and see what zone it spits out. Then enter that zone here.

UTM #Check it to make sure it looks right.

write(UTM, file = "UTM", ncolumns = 1, append = FALSE, sep = " ") #This just writes a 1-column data file that you can pull into excel. Multiple columns were hard, and I'm busy. 
#	Just pull the Northing values from the "n+1"th row into column B and you're fine.