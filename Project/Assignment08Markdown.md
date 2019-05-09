## Defrosted Sugar: Reanalysis of Thawed Permafrost Influence on Microbial Community Changes
### Introduction
Climate change affects microbial communities belowground. CO2 is a greenhouse gas that contributes to rising global temperatures; it's release is in part a result of carbon respiration by soil microbes. 50% of the carbon on earth is locked in (supposed to be) permanently frozen soil, aka permafrost. As global temperatures increase, this permafrost is thawing and previously inaccessible carbon is now available for microbes to metabolize. Which microbes are present in these thawed soils and their metabolisms influence how much greenhouse gas will be respired and contributed to global emissions. 

My lab studies broadly the many roles microbes occupy in soil ecology. I picked this Deng et al study because it was very straightforward. Their process and analysis is one we often perform in my lab. Being able to reproduce the analysis in this study is **_crucial_** for me because it is the basis of my PhD. Although it's best to have a question before generating data, (because modern ecology experiments often generate big data), using Deng et al's dataset I decided to see if I could answer a question based on an assumption made in the paper "Does the amount of soil carbon differ across a thaw progression gradient and correlate with beta diversity across sites?"
### Summary of Data to be Analyzed
The goal of the Deng et al. study was to determine how belowground microbial communities (microbes in the soil), specifically bacteria and archaea, responded to thawing of their resident permafrost along a thawing time gradient.

The authors of this study had 3 sites that differed in thawing time at the Eight Mile Lake area in Healy, Alaska. 18 soil cores total were obtained from the sites. 97 samples of 4 different types (L1-L4) were extracted from the cores. Sample types differed by soil type and whether they were above or below the thaw horizon. The physiochemical properties of the soil samples were measured and DNA was extracted from the soil. The data used for analysis was generated from 16S amplicon sequencing and the measured soil physiochemical properties.

The type of data in this dataset include:
* An OTU table with taxanomy down to the genus level and read counts of each OTU per sample. This is a 9.738 Mb txt file with 31631 lines/rows and 103 columns.
* A file of metadata for the soil samples. This is a 6.982 Kb csv file with 118 rows and 13 columns.

The data looks pretty clean (luckily:thumbsup:) for the most part, but there are a couple issues. The first is that the authors reported 97 samples, yet there are 118 rows in the metadata. Second, the OTU table is wacky: it's in wide (?) format, so the rows correspond to OTUs and the columns correspond to each level of taxonomy for that OTU PLUS read counts of that OTU per sample. Taxonomy designation and read counts are either 1) separate data frames or 2) OTUs are labeled with the taxa first with the rows as samples and the columns as taxa read counts for each sample. Another problem I had was finding a microbial dataset *in general* that provided an otu table with its associated metadata.

The data represent the microbial community composition of the soils and how physiochemical soil properties influence this composition.
### Analysis
The challenge for me will be to reproduce a figure that was presented in the paper in a slightly different way and create my own visual about microbe community structuring to answer the question posed in the introduction. 

Another challenge is the **#NoCryingWhileCodingChallenge** while I try to finish this project without getting too terribly frustrated!!

Part 1: Data wrangling
> Separate taxonomy and read counts in OTU table then make two new arrays 
>1) Sample as rows with OTUs present as columns and specific soil physiochemical properties as columns
>2) An array to answer question posed in Part 4

Part 2: Normalization of reads
Part 3: Exploratory Analysis
> NMDS ordination plot for sample, similar to the PCoA plot in the paper

Part 4: Inference Analysis
> Create a plot to see "Does the amount of soil carbon differ across a thaw progression gradient and correlate with beta diversity across sites?"
### References
[Deng J, Gu Y, Zhang J, Xue K, Qin Y, Yuan M, Yin H, He Z, Wu L, Schuur E, Tiedje J, Zhou J (2015) Shifts of tundra bacterial and archaeal communities along a permafrost thaw gradient in Alaska. Molecular Ecology 24(1): 222-234.](https://doi.org/10.1111/mec.13015)

[Deng J, Gu Y, Zhang J, Xue K, Qin Y, Yuan M, Yin H, He Z, Wu L, Schuur E, Tiedje J, Zhou J (2014) Data from: Shifts of tundra bacterial and archaeal communities along a permafrost thaw gradient in Alaska. Dryad Digital Repository.](https://doi.org/10.5061/dryad.p1602)

> Written with [StackEdit](https://stackedit.io/).
