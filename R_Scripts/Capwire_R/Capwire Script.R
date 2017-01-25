setwd("C:/Users/Zach/Desktop/Capwire R") #Set working directory
library(capwire) #Load capwire
#http://cran.r-project.org/web/packages/capwire/capwire.pdf the website to answer all of your questions.

Deer = read.table("DeerScat_S1-CH12-5.txt") #Make your data frame from a txt file
Deer #Does that look right? Cool
Deer1 = c(1,1,1,1,1,1,1,1,2,3) #You can do it by hand too by creating a vector of capture counts and using the following command:
Deer1 = buildClassTable(Deer1) #This makes a data frame out of your vector. Not a bad idea if you don't have many captures
Deer1 #See? Looks the same.
ECM = fitEcm(Deer, 100) #Now fit the Equal Capture Model using your data (here, Deer or Deer1) and a max.pop (here, 100)
ECM #Gives you the output of ECM
TIRM = fitTirm(Deer, 100) #If you want to fit the Two Innate Rates Model, do that. Depends on the biology of your study system and your sampling scheme.
TIRM #Gives you the output of TIRM
lrtCapwire(ECM, TIRM, bootstraps = 100) #Likelihood ratio test to see which of the two models fit better
bootstrapCapwire(ECM, bootstraps = 1000, CI = c(0.025, 0.975)) #Bootstrap your estimates with 95% CI. Since ECM fits my data better, I used that.

###########################################################################
#Now for my stuff:
Deer = read.table("CH12-3.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("CH12-5.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PM12-5.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-CS11-1A.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-PM11-5A.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-PM11-7A.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 

####################################################################
#Now for my stuff using relaxed (6+ locus matching) criteria for ID
Deer = read.table("CH12-3 - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("CH12-5 - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PM12-5 - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 200) 
TIRM = fitTirm(Deer, 200)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(TIRM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-CS11-1A - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100)
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-PM11-5A - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(TIRM, bootstraps = 500, CI = c(0.025, 0.975)) 

Deer = read.table("PT-PM11-7A - Relaxed.txt")
Deer = indToClass(Deer)
Deer
ECM = fitEcm(Deer, 100) 
TIRM = fitTirm(Deer, 100)
lrtCapwire(ECM, TIRM, bootstraps = 100) 
bootstrapCapwire(ECM, bootstraps = 500, CI = c(0.025, 0.975)) 
