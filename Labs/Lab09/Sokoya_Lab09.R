####LAB09####

#prelim: import data
camData <- read.csv("/Users/blessingsokoya/Desktop/CBS19/SandBox/CompBio_on_git/Datasets/Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = FALSE)
str(camData)
#when do we want string as factors vs characters?
#does it matter when we use "" vs ''? " for commands, ' for strings??

#problem 1: data and time in the same column, split it up into two seperate columns
dateAndTime <- camData$DateTime
str(dateAndTime)
dateAndTime <- as.factor(dateAndTime)
str(dateAndTime)
camDate <- as.Date(dateAndTime)
#this didn't work

dtimes <- camData$DateTime
dtparts <- t(as.data.frame(strsplit(dtimes,' ')))
row.names(dtparts) = NULL
theTimes <- chron(date(dtparts[, 1]), time(dtparts[, 2]), format(c('y-m-d', 'h:m:s'))
#this didn't work either, also the functions don't run all the way through, it keeps getting stuck and
#i have to hit escapte

myDay <- strptime(camData$DateTime, "19/09/2013 16:29", format = "%d/%m/%Y %H:%M")
#i got this from the projector and i think it is taking the column from camData and changing the format
#but it made it a new data frame and i don't know what to do with that data frame

#assign this to a vaiable
smallVec <- camData$DateTime[1:5]
#read using strptime function
?strptime
#i don't i actually understand what this function is doing
parseSmallVec <- strptime(smallVec, "%d/%m/%Y %H:%M")
class(parseSmallVec) #they are all "POSITlt", and i don't know what these are, is this what we want? Am i done?
str(parseSmallVec)
#now run these command on all the data in the large dataframe
myDateTime <- strptime(camData$DateTime, "%d/%m/%Y %H:%M")
str(myDateTime)
#problem 2: find out which entries have the yr as two instead of four
twoDigit <- which(parseSmallVec == "%d/%m/%y") #ERROR chr string is not in a standard unambigious format
              