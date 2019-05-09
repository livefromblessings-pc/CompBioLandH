###################################################################
#*~*~*~*~*~*~*~*~*~*~*~*~*DEFROSTED SUGAR*~*~*~*~*~*~*~*~*~*~*~*~*#
###################################################################
#     Microbial ecology reanalysis of a permafrost thawing effect on microbe community changes.

###################################################################
# ------------------- Part1: Wrangle The Data ------------------- #
###################################################################
#Transform the given data into structures that will help answer the questions asked.
#1: Load the data into R from downloaded files
theMeta <- read.csv("/Users/blessingsokoya/Desktop/CBS19/L_and_H/Project/soil_metadata.csv")
theOTUs <- read.table("/Users/blessingsokoya/Desktop/CBS19/L_and_H/Project/OTU_table_classified_by_RDP.txt.txt")
#2: Check out the data. Ask yourself
# (a) Does this data look workable or wonky? 
# (b) Does it match how it's described in the paper? 
str(theMeta)
head(theMeta, 10) 
unique(theMeta$ID)
str(theOTUs)
head(theOTUs, 10)
#3: Make the OTU table easier to work with by having separate read counts and taxanomy idenfication tables
#library(dplyr)
#justTaxaID <- select(theOTUs, Domain, Phylum, Class, Order, Family, Genus) #the taxonomic classifiers table (taxa_loaded)
#justReads <- theOTUs[ , 7:103] #the OTU counts per sample table (data_loaded)
# Since some of the columns in the OTU table are sample IDs, subtracting the taxa columns from total columns (103-6 = 97) 
# you get the same number of samples mentioned in the paper. Math adds up to original # of columns.
#4: Make the samples IDs the row names for your meta data
row.names(theMeta) <- theMeta$ID
#5: Use only sample IDs found in both the metadata AND OTU table for analysis: this takes care of the row descrepancy
# between the metadata and the otu data
# First switch the rows and columns so that OTUs are now variables and samples now observations
newReads <- t(justReads)
newReads2 <- as.data.frame(newReads)
# Then use the samples from the OTU table to look only at matching samples also present in the metadata
rowsForMeta <- row.names(newReads2)
newMeta <- theMeta[rowsForMeta, ]
#4: For this partial reanalysis of the Deng et al. dataset we need to make two new data structures
#     A) OTUs + metadata for an Exploratory Analysis ordination plot & stacked bar chart(?)


# B) taxa + % C of each of the 3 sites For and Inference Analysis 
onlyCandSite <-newMeta[c("Site", "perC")] 
diversity(newReads2, index = simpson)

###################################################################
# ------------------- Part2: Explore The Data ------------------- #
###################################################################
# Exploratory analysis is the first step to understanding the dataset. For this analysis this means looking at how
# samples cluster based on dissimarity and which individual taxa make up the microbial community of each sample 
#1: Load the library suite of features common packages microbial ecologist use for data analysis 
# with plenty of special functions for exactly what you need.
library(mctoolsr)
library(vegan)
library(ggplot2)
library(GGally)
library(ecodist)
#2: Use the OTUtable and the Metadata from Part1 to calculate a dissimilarity matrix. 
dm <- calc_dm(justReads)
ord <- calc_ordination(dm, 'nmds')
plot_ordination(justReads, ord, color_cat = 'newMeta$ID')

myNMDS <- metaMDS(newReads2, )
plot(myNMDS)

ordiplot(newReads2)
#2:   Use original OTU table from Part1 to plot stacked bar charts of taxa composition in each sample

###################################################################
# ----------------- Part3: Answer The Questions ----------------- #
###################################################################
#     Inference analysis asks who's there, what are they doing, how will biotic & abiotic factors influence community
#     changes and vice versa. The question for this analysis is...
#     "Does the amount of soil carbon differ across a thaw progression gradient & correlate with beta diversity 
#     across sites?"
#1:   Use data structure B from Part1 to plot a scatterplot where xaxis is site and yaxis is %c and each point is individual
#     taxa

#seperate taxa from otus per sample
library(dplyr)
#just OTUs per sample
myTaxa <- select(taxTable, -c(1:6))
#just OTU taxa identification
#see with mctoolrs what is map loaded and data loaded and taxa loaded files

#look at a small chunk of the data
#change to long format with rows = samples & columns = OTU counts per sample
#mash mapping file and otu table together

#ordination pcoa/pca
library(vegan)

#taxa in each sample stacked bar chart
#how does %N differ above and below thaw gradient, how does this correlate with microbes communities
#3b: For the read counts 
newReads <- t(justReads)
newReads2 <- as.data.frame(newReads)
#which

class(justReads)
class(justTaxaID)
matotu <- as.matrix(justReads)
mattax <- as.matrix(justTaxaID)
phyOTU <- otu_table(matotu, taxa_are_rows = TRUE)
phyTax <- tax_table(mattax)
phyOTU
phyTax
phySeq <- phyloseq(phyOTU, phyTax)
phySeq <- phySeq(tax_gl)
phySeq
myAbundance <- plot_bar(phlyum10, phyOTU)
myAbundance
phyMeta <- sample_data(newMeta)
phyMeta
phySeq <- phyloseq(phyOTU, phyTax, phyMeta)
phySeq
class(newMeta)

library(mctoolsr)
topTaxa <- tax_glom(phySeq, taxrank = "Phylum")
phlyum10 <- names(sort(taxa_sums(topTaxa), TRUE)[1:10])
  names(sort(taxa_sums(b1_genus), TRUE)[1:10])
phlyum10
# ----------------------------
#vegan works with samples as rows and OTUs as columns, but phyloseq works with OTUs as rows and 
#samples as columns

#when you look at your otu table, see if the values are in relative abundances (all genera add up to 1)
#or if they give direct counts/reads

otuMeans <- as.data.frame((rowMeans(justReads)))

#wish these stupid tutorials showed you what to do if your imput doesn't look exactly like theirs...

newOTU <- theOTUs %>% select(-c("Domain", "Phylum", "Class", "Order", "Genus", "Family"))
taxonomyOnly <- theOTUs %>% select("Domain", "Phylum", "Class", "Order", "Family", "Genus")
taxonomyOnly["Species"] = ""
colnames(taxonomyOnly) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

row.names(theMeta) <- theMeta$ID
randcmatch <- colnames(newOTU)
newMeta <- theMeta[randcmatch, ]

taxaAndSamples <- cbind(newOTU, taxonomyOnly)
library(viridis)
#phlyumAndSamples <- cbind(newOTU, phylumOnly$Phylum)
library(ampvis2)
myData <- amp_load(taxaAndSamples, newMeta)
as_tibble(newMeta)
myData
amp_heatmap(myData, group_by = "Site")
amp_ordinate(myData,
             type = "nmds",
             distmeasure = "bray",
             sample_color_by = "perC",
             color_vector = scale_color_viridis(),
             transform = "none")

siteAndC <- amp_subset_samples(myData, Site = "Ex" & perC <= 10 )
