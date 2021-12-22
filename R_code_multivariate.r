# R code for measuring community interactions 

install.packages("vegan")
library("vegan")

setwd("/Users/viktoriasitnik/Documents/R/lab")

load("biomes_multivar.RData")

# ls and objects return a vector of character strings giving the names of the objects in the specified environment. 
ls()

biomes  # flora and fauna observed

biomes_types
rm(snow2000)

# list all the files containing multivariate
# trended correspondance analysis is used for species data

multivar <-decorana(biomes)
multivar 
# decorana returns an object of class "decorana", which has print, summary and plot methods.
# eigenvalues- amount of values explained by different axs

# as no inner obsects, can plot directly
plot(multivar)

# data is squeezed into two axis (two dimensions)
# One can also plot “spider graphs” using the function orderspider, ellipses using the function ordiellipse, or a minimum spanning tree (MST) using ordicluster which connects similar communities (useful to see if treatments are effective in controlling community structure).

decorana(veg=biomes)
# 1st is passing through the wide range of the data

# ordihull : Functions to add convex hulls, `spider' graphs, ellipses or cluster dendrogram to ordination diagrams. The ordination diagrams can be produced by vegan plot.cca, plot.decorana or ordiplot.
# attach data set 
# lets see if species are in the same biomes

# 1.x= object to which we associated multivariance, so in this case multivar
# 2. define biome to make an ellipse, ellipse will represent it
# 3. choose colours
# 4. type of graph we want to use
# 5. choose the line thickness
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3, label=TRUE)

# label= TRUE, to label the biomes

ordispider(multivar, type, col=c("black","red","green","blue"), label=T)

# now we can see species that are linked and occur in the same biome


install.packages("sdm")
library("sdm")
install.packages("rgdal")
# An extensible framework for developing species distribution models using individual and community-based approaches, generate ensembles of models, evaluate the models, and predict species potential distributions in space and time.
library(rgdal) # GDAL is a translator library for raster and vector geospatial data formats
library(raster) # predictors
library(rgdal) # species


system.file("external/species.shp")
file <-system.file("external/species.shp", package="sdm") # name of the object to which system file is associated
file # you get the path to the data

# recreate .shp file in R
species <-shapefile(file)

plot(species, pch=19, col="red") # pch is for character, in this case 19= round
