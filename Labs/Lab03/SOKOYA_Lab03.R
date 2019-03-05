#bags of chips you started with
chips <- 5

#lab step 3: number of guests coming to the Star Wars Movie Binge, not including yourself 
guests <- 8
host <- 1

#lab step 5: you and guests will each eat 0.4 bags of chips
chips_eaten <- 0.4 * (guests + host)

#lab step 8: vectors for everybody's rankings of the Star Wars Movies best to frickin worse 
#(so these are my own personal rankings and personally I used to think the JaJa Binks one was the worse, 
# but after I heard how much shit the voice actor got for it, I can't in good conscience list it as the worse, 
# he was kind of annoying but not that bad. I also included The Last Jedi...)
i <- c(7, 3, 2, 4, 5, 1, 8, 6)
dont <- c(5, 7, 6, 3, 1, 2, 4, 8)
have <- c(4, 3, 2, 8, 7, 6, 5, 1)
any <- c(1, 7, 3, 4, 6, 5, 8, 2)
friends <- c(6, 7, 8, 5, 4, 3, 1, 2)

#lab step 9: guests rankings for Episode IV
PennyIV <- dont[4]
LennyIV <- any[4]


#lab step 10: make a data matrix (what does concatenate mean????)
humans_love_ranking_things <- cbind(i, dont, have, any, friends)

#lab step 11: inspect function of PennyIV, Penny, and data matrix
str(PennyIV)
str(dont)
str(humans_love_ranking_things)
#PennyIV is an object a number to be exact, dont/"Penny" is a vector of just numbers, 
#and humans_love_ranking_things is a data matrix with both numbers and characters, which is not the same 
#as a data frame

#lab step 12: make a data frame from our vector rankings
dm_are_not_df <- data.frame(i, dont, have, any, friends)
#OR
as.data.frame(humans_love_ranking_things)
#as.data.frame did not work is when you already have a matrix and want to make it a data frame, data.frame is 
#when you have vectors you want to mash together

#lab step 13: compare you cbind() output vs your data.frame() output
str(humans_love_ranking_things)
str(dm_are_not_df)
dim(humans_love_ranking_things)
dim(dm_are_not_df)
humans_love_ranking_things == dm_are_not_df
all(humans_love_ranking_things == dm_are_not_df)
typeof(humans_love_ranking_things)
typeof(dm_are_not_df)
#so humans_love... is a data matrix while dm_are... is a data frame. The dimensions for both are 8 x 5,
#data frame listed them as 8 observations of 5 variables but data matrix just said they were all numbers.
#when you do == all the observations come out as TRUE so technically all the values are the same, but they 
#aren't the same structurally. Our data matrix is a "double" vector (2d?) and our data frame is a "list" 
#storage mode.Is our data frame still considered a vector?

#lab step 14: make a vector of Star Wars movies
episodes <- c("I", "II", "III", "IV", "V", "VI", "VII", "VIII")

#lab step 15: add episode names as row names to your data frame and data matrix
row.names(dm_are_not_df) <- episodes
row.names(humans_love_ranking_things) <- episodes

#lab step 16: access the third row of the data matrix
humans_love_ranking_things[3,]

#lab step 17: access the fourth column of the data frame
dm_are_not_df[,4]

#lab step 18: access your ranking for The Empire Strikes Back
humans_love_ranking_things[5,1]

#lab step 19: access your imaginary friend Penny's ranking for Attack of the Clones
humans_love_ranking_things[2,2]

#lab step 20: access all rankings for The Classics (Episodes IV-VI)
humans_love_ranking_things [4:6,]

#lab steps 21: access all rankings for II, V, and VII
humans_love_ranking_things [c(2, 5, 7),]

#lab step 22: access rankings for all your imaginary friends for The Classics (except Lenny because nobody
#cares what that person thinks tbqfh)
humans_love_ranking_things [4:6, c(2, 3, 5)]

#lab step 23: switch Lenny's rankings for Episode II and V (see, this is why nobody listens to Lenny! wishywashy! 
#Origininally the rankings were 7 and 6 respectively, so any num [1:8] 1 7 3 4 6 5 8 2)
any <- replace(any, c(2, 5), any[c(5, 2)])
dm_are_not_df <- data.frame(i, dont, have, any, friends)
row.names(dm_are_not_df) <- episodes

#lab step 24: access elements using row and column names for indexing
humans_love_ranking_things ["III", "dont"]
dm_are_not_df ["III","dont"]

#lab step 25: switch 'Lenny's' rankinkings back to original set up using names for indexing instead of numbers
#Yeah i can't figure out how to do this at the data frame level, only at the vector level
#so I can't index with names.
any <- replace(any,)

any <- replace(any, c(2, 5), any[c(5, 2)])
dm_are_not_df <- data.frame(i, dont, have, any, friends)
row.names(dm_are_not_df) <- episodes

#lab step 26: switch 'Lenny's' rankings back to original ones using $ to access a specific part of that 
#data frame
#Yeah I can't figure this one out either, i either get an error 'values missing', 
#or I get two weird extra columns 
#guess I am not a hacker genius after all haha T^T
#i could try making a swap function since I can't seem to find one, maybe I don't have the right
#package installed, but I still am not smart enought to make funtions that actually work 
#(why can't i get a return value ??!?!?!!?)
 swap <- function (x, y){
  x=y
  x=data.frame()
  y=data.frame()
 }
replace(dm_are_not_df$any[2], dm_are_not_df$any[5]) #OR
replace(dm_are_not_df, dm_are_not_df$any[c(2, 5)], dm_are_not_df$any[c(5, 2)])
swap(dm_are_not_df$any[2], dm_are_not_df$any[5])





