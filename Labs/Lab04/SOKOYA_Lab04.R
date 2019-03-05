##### LAB04 #####

#1: Create a 'for loop' that prints "hi" 10x
for (i in 1:10) {
  print("hi")
}

#2: Create a 'for loop' that shows how much money Tim will have after 8 weeks with a $10 stash
#that increases $5 each week and is spent on two packs of gum that are $1.34 each 
#so each week it goes up by $5 but also decreases by 2 * 1.34, but the amount from last week has to be the new
#amount for the following week.
#you need an update step that incorporates time and makes it an actual loop
piggyBankInitial <- 10
allowance <- 5
gumPrice <- 1.34
howMuchGum <- 2
cashOnHand <- piggyBankInitial 

for (i in 1:8) {
  cashLeft <- cashOnHand + allowance  - (howMuchGum * gumPrice)
  cashOnHand <- cashLeft
  print(cashLeft)
}

#3: Create a 'for loop' that will show the population size after 7 years that shinks 5% each year
#and has 2000 individuals intially.
initialPop <- 2000
percShrinkage <- .05

for (i in 1:7) {
  newPop <- initialPop - (initialPop * percShrinkage)
  initialPop <- newPop
  print(newPop)
}

#4: Create a 'for loop' that can figure out the abundance of a population at time step 12 
#previous abundance = n[t-1] = n
#intrisic growth rate = r
#environmental carrying capacity = K
#new abundance at new time step = n[t]
#n[t] = n[t-1] + (r * n[t-1] * (K - n[t-1]) / K)
#new n = n + (r * n * (K - n) / K)
#at n[1], values below apply
t <- 12
timeStep <- seq(1, t)
abundance <- rep(0, t)
n <- 2500
r <- 0.8
K <- 10000
for (i in 1:12) {
  nAtT <- n + (r * n * (K-n) / K)
  n <- nAtT
  abundance[i] <- nAtT
}

#5a: Use rep() to make a vector of 18 zeros
zeros <- rep(0, 18)

#5b: Create a 'for loop' that will add 3 to the previous value and store it as the following value, 18 times
#no numbers in for loops, these are considered magic #s so make them variables
x <- 0
add3 <- 3
for (i in seq(zeros)) {
  y <- x + add3
  x <- y
  print(y)
}

#5c: Make a vector of 18 zeros but the starting value is 1
zeros[1] <- 1

#Question: why do we use seq(1, 8) vs 1:8?

#5d: Create a 'for loop' that takes previous value and adds 1 + 2 * (that value) to 
#that value and makes it the following value using the vector from 5c starting at the seconding value 
#Why does it keep printing like this?
#Question: is there a way to print it in console as a horizontal line and not a vertical line?
zerosAfter1 <- rep(0, 18)
zerosAfter1[1] <- 1
addAndMulti <- 1 + 2 * zerosAfter1
for (i in seq(zerosAfter1)) {
  newVec <- addAndMulti[i]
  zerosAfter1 <- newVec
  print(newVec)
}

#6: Create a for loop that generates the Fibonacci sequence, where the following value is the sum of the previous
#two values
startValue <- i[1]
nextValue <- i[2]
for (i in seq(0, 20)) {
  summedValue <- startValue + nextValue
  startValue <- nextValue
  nextValue <- summedValue
  print(summedValue)
}

#7: make a plot of time vs abundance of output from for loop in question 5
plot(timeStep, abundance)
