setwd("C:/Users/Zach/Desktop/R Stuff/Temp")
load("Rpackages")
for (p in setdiff(packages, installed.packages()[,"Package"]))
install.packages(p)