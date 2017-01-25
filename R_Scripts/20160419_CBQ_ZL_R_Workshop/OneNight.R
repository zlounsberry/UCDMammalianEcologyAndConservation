

############################################
###########LET'S PLAY ONE NIGHT!############

#Damn, Zach forgot the cards again...
#No worries, we can use R instead to assign roles

###### 1. whose playing?######
#We can store player names in a vector of characters

players <- c("cate", "zach", "luis", "preston", "jen", "tom", "sophie", "ben", "amanda", "mark")
players


#we can alphabetize the players...
sort(players)
#we can single out players by their number in the vector
players[4]
#or by their name...
players=="jen"
which(players=="jen")
#and we can ask how many players we have
length(players)


##### 2. let's store all of the possible roles in a vector#####

roles <- c(rep("werewolf", 2), "minion", rep("villager", 4), "seer", "troublemaker", "hunter",
           "insomniac", rep("mason", 2), "drunk", "doppleganger")
roles
length(roles)
#too many, lets get rid of doppleganger and drunk
roles <- roles[-(14:15)]
roles

#We'll make a third vector indicating which team each role is on
team <- as.factor(c(rep("WEREWOLf", 3), rep("VILLAGER", 10)))
team

#and then combine these into a data frame (like a matrix, but can store things besides numbers)
cards <- data.frame(roles=roles, team=team, stringsAsFactors = F)

head(cards)
dim(cards)
str(cards)

###### 3. Deal out the cards#####

#shuffle
deal1 <- sample(roles, size=length(players), replace = FALSE)
deal1
#deal out to players
game1 <- rbind(players=players, deal1=deal1)
colnames(game1) <- paste("card", 1:length(players), sep="_")
game1

#5 minutes pass: We decide to kill Zach.
#But which team was he on?  Everyone needs to flip over their cards

which(players=="zach")
game1[2,which(players=="zach")]

#and what team is that?
losingteam <- cards[which(cards$roles==game1[2,players=="zach"]),2][1]
losingteam

#so the winners are...
winningcards <- cards[which(cards$team!=losingteam),1]
winningcards

#which means these people win the game!
players[deal1 %in% winningcards]

#and these people lose
players[!(deal1 %in% winningcards)]

######Let's play 100 games to see who's the overall winner for the month#####
ngames <- 100

# initialize a blank data frame that we will populate with a loop
deals <- data.frame(matrix(NA, nrow=ngames, ncol=length(players)))
colnames(deals) <- players
head(deals)
#...and a blank vector for who gets killed each game
killed <- rep(NA,ngames)

#create a loop for dealing cards
for (i in 1:ngames) {
  deals[i,] <- sample(x = cards$roles, size=length(players), replace = FALSE)
  killed[i] <- sample(players,1)
}

deals

#create empty winner matrix
winners <- matrix(0, nrow=ngames, ncol=length(players))
colnames(winners) <- players
rownames(winners) <- 1:ngames

for (i in 1:ngames) {
  #what role was the person who was killed
  tmprole <- deals[i,colnames(deals)==killed[i]]
  #what team was that?
  losingteam <- cards[which(cards$roles==tmprole), 2][1]
  winningcards <- cards[which(cards$team!=losingteam),1]
  winners[i,players[deals[i,] %in% winningcards]] <- 1
  }

head(winners)

#how many games did each person win?
total <- apply(winners, 2, sum)
total

#graphically
barplot(total, main="Total Number of Games Won", las=3, col="orange")

#ultimate winner is...
names(which.max(total))




