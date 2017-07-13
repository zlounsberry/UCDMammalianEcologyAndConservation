library(capwire) #Load capwire
#http://cran.r-project.org/web/packages/capwire/capwire.pdf the website to answer all of your questions.

#Example_Input
Deer1 = c(1,1,1,1,1,1,1,1,2,3) #You can do it by hand by creating a vector of capture counts (or you can read.table() a file)
Deer1 = buildClassTable(Deer1) #This makes a data frame out of your vector. Not a bad idea if you don't have many captures
Deer1 #Does that look right?
ECM = fitEcm(Deer, 100) #Now fit the Equal Capture Model using your data and a max.pop (here, 100)
ECM #Gives you the output of ECM
TIRM = fitTirm(Deer, 100) #If you want to fit the Two Innate Rates Model, do that. Depends on the biology of your study system and your sampling scheme.
TIRM #Gives you the output of TIRM
lrtCapwire(ECM, TIRM, bootstraps = 100) #Likelihood ratio test to see which of the two models fit better
bootstrapCapwire(ECM, bootstraps = 1000, CI = c(0.025, 0.975)) #Bootstrap your estimates with 95% CI. Since ECM fits my data better, I used that.

