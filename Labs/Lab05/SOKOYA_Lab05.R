###Lab 05###

#1: assign a value to x and write a conditional to test if that variable is greater than 5 and print the result
x <- 6
if (x > 5) {
  print("yasss")
} else {
  print("nope")
}

#2a: import Sam's data file and replace all negative values with NA
#R imports csv as a data frame. Is this always the case?
vec1 <- read.csv("/Users/blessingsokoya/Desktop/CBS19/SandBox/CompBio_on_git/Labs/Lab05/Vector1.csv")
#so we changed the data frame to be just a vector by making a single column its own vector
newVec <- vec1$x
n <- 2024
for (i in 1:n) {
  if (newVec[i] < 0) {
    newVec[i] <- NA
  }
}

#2b: replace all NA values with NaN using vectorized code and not a for loop
# == does not work on NA
#how am i supposed to know == doesn't work on NA and i have to use is.na, Amy got an error message but I
#didn't get the same message
newVecJustNA <- which(is.na(newVec)) 
#this vector is made up of the positions from the original vector that are NA
newVec[newVecJustNA] <- NaN 
#so we made a vector of just the positions that are NA, then we used this vector for indexing those positions
#in our original vector and changed those to NaN

#2c: replace all NaN values with zeros using a vectorized code and not a for loop
newVecJustNaN <- which(is.nan(newVec))
newVec[newVecJustNaN] <- 0

#2d & 2e: determine which values are 50 >= and <= 100 and create a vector of your threshold values
fiftyToOneHundred <- subset(newVec,newVec >= 50, newVec <= 100)

#2f: save your Ft1H vector as a csv data file
getwd()
setwd("Desktop/CBS19/L_and_H/Labs/Lab05/")
write.csv(fiftyToOneHundred, "FiftytoOneHundred.csv")

#3: use code to answer the following questions about CO2 emissions data
carbon <- read.csv("/Users/blessingsokoya/Desktop/CBS19/SandBox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv")
str(carbon)
#what was the first year where gas emissions were not zero?
gasEmission <- which(carbon$Gas > 0)
carbon$Year[gasEmission]
#which years were total emissions between 200-300 metric tons C?
totalEmissions <- which(carbon$Total >= 200 & carbon$Total <= 300)
carbon$Year[totalEmissions]

##part2##
#first: set up parameters
totalGenerations <- 1000
initPrey <- 100 	# initial prey abundance at time t = 1, aka n[t-1]
initPred <- 10		# initial predator abundance at time t = 1, aka p[t-1]
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

#second: pre-allocate vectors 
t <- totalGenerations #time vector
preyAbun <- rep(0, t) #prey abundance vector
predAbun <- rep(0, t) #pred abundance vector

#third: write a for loop that implements the "L-V" pred-prey dicrete time model.
#prey abundance -n- = initprey + (r * initprey) - (a * initprey * initpred)
#pred abundance -p- = initpred + (k * a * initprey * initpred) - (m * initpred)
for (i in 1:t) {
  n <- initPrey + (r * initPrey) - (a * initPrey * initPred)
  initPrey <- n
  p <- initPred + (k * a * initPrey * initPred) - (m * initPred) 
  initPred <- p
  preyAbun[i] <- n
  predAbun[i] <- p
}

#fourth: add if statement that if the prey abundance is -, then set prey value to 0
for (i in 1:t) {
  n <- initPrey + (r * initPrey) - (a * initPrey * initPred)
  initPrey <- n
  if (n < 0) {
    n = 0
  }
  p <- initPred + (k * a * initPrey * initPred) - (m * initPred) 
  initPred <- p
  preyAbun[i] <- n
  predAbun[i] <- p
}

#fifth: create a plot of prey vs pred over time
#I didn't understand how to use line to put a second plot on top of this one, but this is what the internet
#gave me...i don't even think the plot itself is correct though, because pred and pred should be inversely
#related
generation <- seq(1, t)
#set up margins, I think each # is a side of the plot, started from the bottom (hehe)/the xaxis
par(mar = c(4, 4, 3, 4))
plot(generation, preyAbun, type = "l", ylab = "prey abundance",
     main = "L-V Model", col = "red")
par(new = TRUE)
#i don't know what some of these mean but lty = 2 makes the plot line dotted
plot(generation, predAbun, type = "l", xaxt = "n", yaxt = "n",
     ylab = "", xlab = "", col = "blue", lty = 2)
#this gave me an axis for the pred values
axis(side = 4)
mtext("predator abundance", side = 4, line = 3)
#cex changes the size of the legend box
legend("topleft", c("prey", "predator"),
       col = c("red", "blue"), lty = c(1, 2),
       cex = .5)

#sixth: create a matrix of abundances and generation time
myResults <- cbind(generation, preyAbun, predAbun)
names <- c("TimeStep", "PreyAbundance", "PredatorAbundance")
colnames(myResults) <- names
write.csv(myResults, "PredPreyResults.csv")

