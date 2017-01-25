#Set the working directory
setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")

x <- rnorm(50)
y <- rnorm(x)

#Standard scatterplot
plot(x,y)

# Lists All Objects in R Console. 
# The collection of objects currently stored is called the workspace.
ls()

#Removes objects x, y
rm(w,x,y)

#Removes ALL the objects
rm(list=ls())


#Makes x an object 1-20
x <- 1:20

#Creates a data frame with 2 columns, x and y (where x is
x and y is x + rnorm(x)*x)
dummy <- data.frame(x=x, y=x + rnorm(x)*x)

# Creates a vector of numbers. c() concatenates them.
# This is called an "assignment" statement using the c() "function"
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
# This assignment does the same thing as the above assignment:
assign("x", c(10.4, 5.6, 3.1, 6.4, 21.7)) 

# The logical operators are <, <=, >, >=, 
# == for exact equality and != for inequality

# Character quantities and character vectors are used frequently 
# in R, for example as plot labels. Matching double or single quotes!
# Inside double quotes " is entered as \". For more escapes: ?Quotes

plot(x,y, xlab = "\"dumb\"", ylab = "dumber") #will put quotes around dumb, not dumber

# Bracket things to work within a subset of those data 
# Below: x is 1-15. y is any x greater than 10. z is any y less than 13 (so 11 and 12)
x = 1:15
y <- x[(x)>10]
z <- y[(y)<13]
# excluding is the same deal with a negative sign.
x1 = 1:15
y1 <- x1[-(1:8)]
z1 <- y1[-(2:5)]

# Vectors of character strings (these are of mode 'numeric' b/c it's just putting names on values of object fruit)
fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
lunch <- fruit[c("apple","orange")]

#To convert from one mode to another, use as.whatever like below (converting number to character)
z <- 0:9
digits <- as.character(z)

# Can bypass adding the whole file name by setting a working directory.
setwd("C:\\Users\\Zach\\Desktop\\R Scrip MSAT Finder")
acc = read.table("nuccore_result.txt")
acc
accfix = as.character(unlist(c(acc)))
accfix
mode(accfix)
newtable = edit(acc)
edit(accfix)

#### if/else functions ####

x = 5
if (x > 3) "yep" else "nope" #if/else function for a single variable following if (condition) expr_1 else expr_2 (expr_1 = "yep", 2 = "nope")
v = 1:5
ifelse(v > 3, "Yep", "Nope") #if/else function for a vector following ifelse(condition, expr_1, expr_2) (expr_1 = "Yep", 2 = "Nope")

### Random Number generator ###
randec = runif(10, 5.0, 7.5) # Generates 10 random decimal numbers between 5 and 7.5
randec

randwhole = sample(1:10, 1) # Generates 1 random whole number between 1:10. replace=TRUE with replacement, FALSE without
randwhole 

#### Fun with FUNctions ####

open.account <- function(total) {
list(deposit = function(amount) {
if(amount <= 0)
stop("Deposits must be positive!\n")
total <<- total + amount
cat(amount, "deposited. Your balance is", total, "\n\n")
},
withdraw = function(amount) {
if(amount > total)
stop("You don’t have that much money!\n")
total <<- total - amount
cat(amount, "withdrawn. Your balance is", total, "\n\n")
},
balance = function() {
cat("Your balance is", total, "\n\n")
}
)
}
ross <- open.account(100)
robert <- open.account(200)
ross$withdraw(30)
ross$balance()
robert$balance()
ross$deposit(50)
ross$balance()
ross$withdraw(500)


twosam <- function(y1, y2) {
n1 <- length(y1); n2 <- length(y2)
yb1 <- mean(y1); yb2 <- mean(y2)
s1 <- var(y1); s2 <- var(y2)
s <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
tst <- (yb1 - yb2)/sqrt(s*(1/n1 + 1/n2))
tst
}

twosam(1:10, 5:20)

if (a==1) {b=2; c=3} else {b=0; c=0}

