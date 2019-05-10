###################################################################
#*~*~*~*~*~*~*~*~*~*~*~*~*DEFROSTED SUGAR*~*~*~*~*~*~*~*~*~*~*~*~*#
###################################################################
# Microbial ecology reanalysis of a permafrost thawing effect on microbe community changes using
# Deng et al's dataset from "Shifts of tundra bacterial and archaeal communities along a permafrost
# thaw gradient in Alaska."
# Deng et al = Deng+



###############################################################################
# ------------------- Part1: Wrangle The Data Preliminary ------------------- #
###############################################################################
# Transform the given data into structures that will help answer the questions asked.


#1: Load the data into R from downloaded files
myMetadata <- read.csv("/Users/blessingsokoya/Desktop/CBS19/L_and_H/Project/soil_metadata.csv")
myOTUTAB <- read.table("/Users/blessingsokoya/Desktop/CBS19/L_and_H/Project/OTU_table_classified_by_RDP.txt.txt")
#2: Check out the data. Ask yourself
# (a) Does this data look workable or wonky? 
# (b) Does it match how it's described in the paper? 
str(myMetadata)
head(myMetadata, 10)
str(myOTUTAB)
head(myOTUTAB, 10)
# (c) How many samples are present in the metadata and the OTU table?
unique(myMetadata$ID)

#2: The rows aren't named so make the sample IDs also the rownames
row.names(myMetadata) <- myMetadata$ID



###################################################################
# ------------------- Part2: Explore The Data ------------------- #
###################################################################
# Exploratory analysis is the first step to understanding a dataset. 
# For this analysis this means looking at how samples cluster, for instance based on dissimarity, and 
# which individual taxa make up the microbial community of each sample. 

# For this part we will be using a packaged called "ampvis2" to explore how the OTUs and metadata 
# influence each other. The goal of this part of a reanalysis is to see if the
# output we get from our analysis resembles the original analysis done by Deng+.


#1: Install and load the package
install.packages("remotes")
remotes::install_github("MadsAlbertsen/ampvis2")
library(ampvis2)

#2: To create the amp object (a specific type of dataframe) used for this package, the otutab needs
# some rearranging. The first columns should be the reads counts for samples and the last columns 
# should be the taxonomic level columns (name of organism each OTU represents).
str(myOTUTAB)
# (a) Make an otutab with just samples, no taxa ids
library(dplyr)
otutabSamples <- myOTUTAB %>% select(-c("Domain", "Phylum", "Family", "Order", "Class", "Genus"))
# (b) Make an otutb for just the taxa ids
otutabTaxa <- myOTUTAB %>% select(c("Domain", "Phylum", "Class", "Order", "Family", "Genus"))
# 97 + 6 = 103 OK!
# (c) This otutab doesn't have a species column (which is not a big deal, Deng+ probably only
# had a couple OTUs with species identification and thus took out the column. Adding a place holder
# column will not mess up any analysis.
otutabTaxa["Species"] <- ""
# (d) Change the name of the "Domain" column to "Kingdom": again this is just so our otutab is
# formatted correctly to work with amp object; the classificatin level stays the same just named diff
colnames(otutabTaxa) [1] <- "Kingdom"
# (e) Combine your two otutabs in the new order: samples first, taxonomy second
otutabNew <- cbind(otutabSamples, otutabTaxa)
# our new otutab has an extra variable which is our placeholder "Species" column
# (f) Our metadata also needs some rearranging: the number of samples is different from the OTU table.
# Make a new metadata df that only includes the same samples as the OTU table
matchMandO <- colnames(otutabSamples)
metadataNew <- myMetadata[matchMandO, ]
# (g) Finally! Create the amp object with your otutab and metadata
myData <- amp_load(otutable = otutabNew, metadata = metadataNew)
myData
# Viewing the amp object to make sure it still looks correct. Also looking at it gives you stats and
# summary about the object/your data. 
# The Read count stats are all the same, suggesting that this Deng+ normalized the read counts 
# already. If the Min#Reads and Max#Reads were vastly different, it would probably be best to 
# normalize the reads via rarefaction (simplest method) or another method.

#3: How do samples cluster? One way to check is with a ordination plot based on a dissimilary matrix. 
# This package is handy because it does the dissimilary calculations for you! Yay! And from that makes 
# plots. First make a PCoA plot and see how it compares to Deng+'s. Deng+ made another column 
# for their PCoA: "Level". This column subsets samples by both the SoilType and ThawDepth properties.
# Use this for the PCoA. We can then just reload the amp object with this metadata instead.
####CHANGE NAMES LATER####
# (b) Would like to keep the original 97meta data file and work on an alternative one
metaTest <- metadataNew
# (a) First, we need to make a new Level column with data for both SoilType and ThawDepth
metadataNew$Level <- paste(metadataNew$SoilType, metadataNew$ThawDepth)
# (c) Change the different column combos into the same level names from paper "L1:L4": see Deng+ 
# paper for schematic of levels
metaTest$Level <- ifelse(metaTest$Level == "O Above", "L1", metaTest$Level)
metaTest$Level <- ifelse(metaTest$Level == "O Below", "L2", metaTest$Level)
metaTest$Level <- ifelse(metaTest$Level == "M Above", "L3", metaTest$Level)
metaTest$Level <- ifelse(metaTest$Level == "M Below", "L4", metaTest$Level)
# (d) Rename the dataframe that we are working with, not necessary but helpful for understanding
metadataAlt <- metaTest
# (e) Reload our amp object
myData <- amp_load(otutable = otutabNew, metadata = metadataAlt)
myData
# (f) Make a PCoA ordination plot where samples are colored by Level
levelPCoA <- amp_ordinate(myData,
             type = "pcoa",
             distmeasure = "bray",
             sample_color_by = "Level") +
  scale_color_viridis_d(option = "plasma")
# So this PcoA doesn't look like dang et al. One reason could be that we don't have any L3 samples!
# This could be a result of the samples we filtered out early that weren't also represented
# in the otutab. Or since we are using a different analysis package they could also ordinate 
# differently (but that shouldnt matter right?). 
# Who knows, ordinations are mostly to get to know the data. What's nice is our samples do cluster 
# by Level! That's reassuring because they did the same on the Deng+ plot.
# Not sure what this means yet "using both transformation AND a distance measure is not recommended
# for distance-based ordination." (From warning message)
# We transform when: ratio scaled variables that must be logarithmically transformed

#4: Now lets see which taxa are present in each sample. Since we have a lot of OTUs, 
# for this analysis we are just looking for top taxa, not rare OTUs.
# You can do this by calculating mean for a specific OTU across all sample (I think......) but
# this package does this for you and lists the top taxa. Yay!
# (a) Make a heatmap too see top taxa present in a sample.
topTaxa19 <- amp_heatmap(myData, group_by = "Level", tax_show = 19) +
  scale_fill_viridis_c(option = "plasma") 
# This heatmap shows which taxa at the Phylum rank are Top 19 in samples at soil types L1, L2, and L3.
# Deng+ have a stacked bar chart, but the Phylum listed in this heat map match exactly!!!! And
# there relative amounts (% of samples) seem to match as well!! 
# What's lame is that all the Proteobacteria are grouped together, there a several types of Proteo,
# such as alpha, gamma, beta, and Deng+ and all seperated these out in their analysis. At the lower 
# amounts I have some that Deng+ grouped together in their "Other" category. Also it seems that
# for their analysis, they have more samples because they have L3 otus even though those were not
# provided with this dataset OR, I filtered incorrectly and there were some L3 with OTUs.



###################################################################
# ----------------- Part3: Answer The Question ----------------- #
###################################################################
# Inference analysis asks who's there, what are they doing, how will biotic & abiotic 
# factors influence community changes and vice versa. 
# The question for this analysis is...
# "Does the amount of soil carbon differ across a thaw progression gradient & 
# correlate with beta diversity across sites?"


#1: A way to look at this is to compare our abundance heatmap to a barplot that displays:
# x = Site, y = perC, and each dot is a sample, colored by Level.
library(ggplot2)
ggplot(metadataAlt, aes(x = metadataAlt$Site, y = metadataAlt$perC, fill = metadataAlt$Level)) +
  geom_boxplot() +
  labs(fill = "Level") +
  xlab("Site") +
  ylab("% Soil Carbon") +
  scale_fill_viridis_d(option = "plasma") 
# In the paper, there are 3 sites with varying that progression. 
# Ex = extensive thawing, Mi = minimal thawing, and Mo = moderate thawing. According 
# to this boxplot, the amount of soil carbon doesn't differ across a
# thaw progression gradient. The amount of soil carbon does differ between sample Levels!
# L4 samples had less carbon than other levels. From the paper, this level is mineral
# soil below the thaw gradient. It probably has less Carbon because mineral layer soil and less
# to do with thawing. L1 and L2 samples had the most soil carbon and this is probably
# because these samples are organic layer soil. O layers are made up of mostly carbon.

#2: Looking at samples indvidual with barcharts, we see a same trend. 
# Thawing doesn't have a strong influence on the amount of soil carbon.
exSamples <- which(metadataAlt$Site == "Ex")
moSamples <- which(metadataAlt$Site == "Mo")
miSamples <- which(metadataAlt$Site == "Mi")
metadataEx <- metadataAlt[exSamples, ]
metadataMo <- metadataAlt[moSamples, ]
metadataMi <- metadataAlt[miSamples, ]
exBar <- ggplot(metadataEx, aes(metadataEx$ID, metadataEx$perC, fill = metadataEx$Level)) +
  geom_bar(stat = "identity", width = .5) +
  labs(fill = "Level") +
  xlab("Sample") +
  ylab ("% Soil Carbon") +
  theme(axis.text.x = element_text(angle = 90)) +
  coord_fixed(ratio = .5) +
  scale_fill_viridis_d(option = "plasma") 

moBar <- ggplot(metadataMo, aes(metadataMo$ID, metadataMo$perC, fill = metadataMo$Level)) +
  geom_bar(stat = "identity", width = .5) +
  labs(fill = "Level") +
  xlab("Sample") +
  ylab ("% Soil Carbon") +
  theme(axis.text.x = element_text(angle = 90)) +
  coord_fixed(ratio = .5) +
  scale_fill_viridis_d(option = "plasma") 

miBar <- ggplot(metadataMi, aes(metadataMi$ID, metadataMi$perC, fill = metadataMi$Level)) +
  geom_bar(stat = "identity", width = .5) +
  labs(fill = "Level") +
  xlab("Sample") +
  ylab ("% Soil Carbon") +
  theme(axis.text.x = element_text(angle = 90)) +
  coord_fixed(ratio = .3) +
  scale_fill_viridis_d(option = "plasma") 
# Thinking back to our heatmap each map looks similar in terms of most abundant
# taxa found in sample grouped by level.

#3: Using a network analysis lets see if certain taxa are associated with samples from 
# certain sites. 
amp_otu_network(myData, color_by = "Site", tax_show = 19, tax_empty = "OTU")
#From the plot this doesn't see to be the case. except for two taxa but this sort of network analysis
# doesn't give their names or OTU IDs. Most Samples had similar taxa compostion. Similar 
# to what was seen with the heatmap.

