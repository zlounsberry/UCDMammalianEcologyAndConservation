#Here's a decent intro to quick plots ggplot2: http://blog.echen.me/2012/01/17/quick-introduction-to-ggplot2/
#Here is a less user-friendly (but much more indepth) guide to ggplot2: http://docs.ggplot2.org/current/

setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/ggplot2 stuff")
library(ggplot2)
library(plyr)
rm(list=ls()) #I just like to have this handy. Clears all objects...

Labbies = read.table("Labbies.txt", sep = "\t", header = T, row.names="Names") #A table of random lab-mate characteristics that are mostly made up
Labbies

#Some notes: Always use "data = YourData" so R knows where to read your variables from
#The following are quick plot "qplot()" examples. Quick and dirty, but effective in a pinch!

##########Scatterplot qplot() Example
qplot(Height, Study.System, size = No..Pubs, color=Eye.Color, data = Labbies, main = "Made Up Lab Characteristics", 
xlab = "Height (inches)", ylab = "Study Species")
#Plotting two variables (qplot(x, y, data=YourData...)) defaults to geom = "point". You can change geometry to your heart's content
#size = plots the size of a point by the value of that variable. In this case, the number of publications (according to Web of Science) = point size
#color = allows you to assign a group to color code


############Barchart qplot() Example
qplot(Study.System, weight = Height, data = Labbies)

#If you just use one variable (qplot(x, data=YourData ...)), it defaults to a barchart with counts
	#To change this, use "weight = variable"

##############LineChart qplot() Example
qplot(Height, No..Pubs, color=Study.System, data = Labbies, geom = c("point","line"),
main = "Made Up Lab Characteristics", xlab = "Height (inches)", ylab = "Number of Publications")

#Pretty similar to scatterplot... Can control line thickness with "size = variable"
#Also, geom = "line" is a line chart and geom = c("line","point") is a line chart with points. 

###############Now for the harder stuff...#######################
#So here's how you actually build a ggplot from the ground up (preferred because customizing colours, etc. is easier):
ggplot(YourData, aes(x, y, )) + #If you're using the same x and y from the same data frame
ggplot(YourData) + #If you plan on building multiple layers from the same data drame using different x and y aesthetics
ggplot() + #If you plan on building multiple layers from multiple data frames, use this most basic one to start
# The " +" after it refers to what's coming in the following line, which is used to build layers.

Labbies = read.table("Labbies.txt", sep = "\t", header = T, row.names="Names") #A table of random lab-mate characteristics that are mostly made up
Labbies
#Plot this stuff using this code:
ggplot(Labbies, aes(x = Height, y = No..Pubs)) + #sets up the data frame and aesthetics
	geom_point(colour = "dodgerblue1") #Tells it what geometry to plot. In this case, points!

##Some random points to screw around with
X=rnorm(203)
Y=rnorm(203)
Z=rnorm(203)
X = as.data.frame(X) #Random data frame of 203 points for screwing around with (X and Y and Z, here)
Y = as.data.frame(Y)
Z = as.data.frame(Z)
Range = (rep.int(c(-3:3), 29)) #A range from -3 to 3 to encompass all of the points from X, Y, and Z
Range = as.data.frame(Range) #But it has to be a data frame...

Xmean=sapply(X, mean) #Mean values for the random variable X (and Y and Z below here)
Ymean=sapply(Y, mean)
Zmean=sapply(Z, mean)
Xm = as.data.frame(Xmean)
Ym = as.data.frame(Ymean)
Zm = as.data.frame(Zmean)

df = data.frame(c(X, Y, Z, Range)) #Took the long way, but made data frame including 3 random sets of 203 values
means= data.frame(c(Xm, Ym, Zm))

#This will plot the values against our range in different colors
ggplot(data = df) + 
	geom_point(aes(Range, X), colour = "red") +
	geom_point(aes(Range, Y), colour = "black") +
	geom_point(aes(Range, Z), colour = "yellow")
	theme(panel.background = element_blank()) #This lovely chunk of code will remove that gray background should you find it offensive!
		# Just stick it in the last line after a plus sign...

	theme_bw(base_size = 12, base_family = "") #Or this one for white background and black gridlines. base_family = "" refers to the font.
	#Some more themes: https://github.com/hadley/ggplot2/wiki/Themes

#This will plot values and the means we calculated earlier at positions -1, 0, and 1, respectively.
ggplot(data = df) + 
	geom_point(aes(Range, X), colour = "red") +
	geom_point(aes(Range, Y), colour = "black") +
	geom_point(aes(Range, Z), colour = "yellow") +
	geom_point(aes(-1, means$Xm), colour = "red", size = 4) + 
	geom_point(aes(0, means$Ym), colour = "black", size = 4) +	
	geom_point(aes(1, means$Zm), colour = "yellow", size = 4)

##Stacked bars, modified from the internets:
##This is showing the number of extractions from me, Kat, and Tori that succeeded or failed:

library(RColorBrewer)
library(ggplot2)

names <- c("KM","KM","VK","VK","ZL","ZL")
result <- c("Worked", "Failed")
numbers <- c(14, 16, 47, 62, 195, 208)

df <- data.frame(names, result, numbers)
df

#plot the stacked bar plot
ggplot(df, aes(x = names)) + geom_bar(aes(weight=numbers, fill = result), position = 'fill') +
scale_y_continuous("", breaks=NULL) +
scale_fill_manual(values = rev(brewer.pal(6, "Reds"))) +
theme(panel.background = element_blank()) 

#plot the stacked bar plot with polar coordinates (Totally superfluous cool way of presenting your data)
ggplot(df, aes(x = names)) + 
geom_bar(aes(weight=numbers, fill = result), position = 'fill') + 
scale_y_continuous("", breaks=NULL) + 
scale_fill_manual(values = rev(brewer.pal(6, "Greens"))) +
coord_polar() +
theme(panel.background = element_blank()) 


#Here is the Original stacked barplot script, stolen from the internet. Gives an idea of how to construct my data frame in excel to use these stacked bars.
project <- c('ArgoUML','ArgoUML','ArgoUML','ArgoUML','ArgoUML','GWT','GWT','GWT','GWT','GWT','Jaxen','Jaxen','Jaxen','Jaxen','Jaxen','JRuby','JRuby','JRuby','JRuby','JRuby')
component <- c('FileDistance','PackageDistance','DataDependency','CallGraphDistance','ChangeCouplings','FileDistance','PackageDistance','DataDependency','CallGraphDistance','ChangeCouplings','FileDistance','PackageDistance','DataDependency','CallGraphDistance','ChangeCouplings','FileDistance','PackageDistance','DataDependency','CallGraphDistance','ChangeCouplings')
numbers <- c(16,22,46,10,6,46,22,10,12,10,20,20,20,20,20,0,36,33,20,11)
df1 <- data.frame(project,component,numbers)
#plot the stacked bar plot
ggplot(df1, aes(x = project)) + geom_bar(aes(weight=numbers, fill = component), position = 'fill') + scale_y_continuous("", breaks=NULL) + scale_fill_manual(values = rev(brewer.pal(6, "Purples")))

#plot the stacked bar plot with polar coordinates
ggplot(df, aes(x = project)) + geom_bar(aes(weight=numbers, fill = component), position = 'fill') + scale_y_continuous("", breaks=NA) + scale_fill_manual(values = rev(brewer.pal(6, "Purples"))) + coord_polar()



##Test scatterplot by groups:
Test = read.table("Test.txt", sep = "\t", header = F, row.names=NULL) 
Test

