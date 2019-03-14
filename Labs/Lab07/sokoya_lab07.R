#1: create a function that calculates the area of a triangle
#goal: i want to calculate the area of a triangle
#result: a scalar variable called triArea
#how to get there: three scalar variables all multiplied together - the constant and the length of two sides 
#of the triangle, the base and the height
#pseudocode:

#write out steps that you need to solve the problem on paper
triangleArea <- function (triBase, triHgt) {
  #take the constant
  triCon <- 0.5
  #multiply it by the triangle base
  #multiply those by the triangle height
  if(triBase > 0 && triHgt > 0) {
      triArea <- triCon * triBase * triHgt
      return(triArea)
    } else {
      cat("Area", "cant", "be", "negative", "sorry!")
    }
}

#try it out:
triangleArea(1, 1)
triangleArea(8, -8)

#2: create a function that gives you the absolute value of a number
#goal: always gives you a postive number even if you type in a negative number
#result: absol (shout out to Gen3 pokeymans!)
#how to get there: if already positive then print, but if negative then make number positive then print

myAbs <- function(absol) {
  ifelse(absol < 0, absol * -1, absol)
}

#2a: try it out with invidual scalars
myAbs(5)
myAbs(-2.3)

#2b: try it out with vectors and NA
myAbs(c(1.1, 2, 0, -4.3, 9, -12))
myAbs(NA)
myAbs(c(NA, -3.4, 0, -8))
x <- c(5, -6, -7)
myAbs(x)

#3: create a function for the Fibonacci sequence
finish <- 20
myFib <- function(o, n) {
  for (i in 1:finish) {
  acci <- sum(o[i] + n[i])
  o[i] <- acci
  n[i] <- o[i]
  }
  return(acci)
}

#try it out
myFib(1, 1)
myFib(0, 1)
#i keep getting NA... =|

#4a: write  function that takes two inputs and squares the difference
squareDif <- function(x, y) {
 sD <- (x - y) ^ 2
  return(sD)
}

#try it out
squareDif(3, 5)
squareDif(c(2, 4, 6), 4)
#why is this function able to handle vectors but the abs function from problem 2 couldn't??

#4b: write a function that calculates mean
myMean <- function(m) {
  allOverTotal <- sum(m) / length(m)
  return(allOverTotal)
}

#try it out
myMean(c(5, 15, 10))
dataLab7 <- read.csv("/Users/blessingsokoya/Desktop/CBS19/SandBox/CompBio_on_git/Labs/Lab07/DataForLab07.csv")
newVec <- dataLab7$x
myMean(newVec)

#4c: write a function that calculates the "sum of squares"
#steps - 1) find mean of all data points (m), 2)individual data point - mean...x <- (d[i] - m) , 3) sum (x ^ 2)
#sum((d-m)^2) 
mySumOfSquares <- function(s) {
  t <- myMean(s)
  u <- squareDif(t, s)
  v <- sum(u)
  return(v)
}

#try it out
mySumOfSquares(newVec) #nice!
