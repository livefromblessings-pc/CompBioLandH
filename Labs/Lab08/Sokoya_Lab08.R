#Create a for loop to figure out the abundance of a population at time step [t] & turn it into a function
#previous abundance = n[t-1] = n
#intrisic growth rate = r
#environmental carrying capacity = K
#new abundance at new time step = n[t]
#n[t] = n[t-1] + (r * n[t-1] * (K - n[t-1]) / K)
#new n = n + (r * n * (K - n) / K)
logGrowMod <- function(n, r, K, t) {
  timeStep <- seq(1, t)
  abundance <- rep(0, t)
  for (i in 2:t) {
    nAtT <- n + (r * n * (K-n) / K)
    n <- nAtT
    abundance[i] <- nAtT
  }
  #generate a plot of your generation time (aka time step) vs population abundance
  plot(timeStep, abundance)
  #you cannot have multi-argument returns, so combine them and return only one argument
  tVsA <- cbind(timeStep, abundance)
  return(tVsA)
}
#call the function with specified parameters and save it to a new vector
results <- logGrowMod(2500, 0.8, 10000, 12)
#change column names in result from function vector names to appropriate given names
colnames(results) <- c("generation", "abundance")
#save your data as a csv file, and remove empty row names column
write.csv(results, "LogGrowMod_Results.csv", row.names = FALSE)
