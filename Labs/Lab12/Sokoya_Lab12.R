###LAB12###

#01: A bar plot in ggplot
#load the Cru et al data
camData <- read.csv("/Users/blessingsokoya/Desktop/CBS19/SandBox/CompBio_on_git/Datasets/Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = FALSE)
str(camData)
#make a bar plot of counts for each species
library(ggplot2)
myPlot <- ggplot(camData) +
  geom_bar(aes(camData$Species))
#is this code aligned/tabbed correctly?
myPlot

#02: rotate the axis tick labels
myPlot <- ggplot(camData, aes(camData$Species)) +
  geom_bar() + 
#rotate the x axis tick labels so they're readable
#do this by changing the tick label angle to 90 degrees 
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Species")
myPlot

#03: a different orientation, scaling, and sorting
#sort species by count frequency
library(plyr)
sFrequencies <- count(camData$Species)
names(sFrequencies)  <- c("Species", "Frequency")
myPlot2 <- ggplot(sFrequencies, aes(reorder(sFrequencies$Species, -sFrequencies$Frequency), sFrequencies$Frequency)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Species", y = "Count") +
#make count (new x axis) logarithmic  
  scale_y_log10() +
#flip the axes
  coord_flip() +
  theme(axis.text.x = element_text(angle = 0))
myPlot2

