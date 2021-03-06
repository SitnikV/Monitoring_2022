## 01.10.22 lecture ##
library(sdm)
library(raster) # predictors
library(rgdal)  # species 

# species data 
# system file function When system. file is called from the R console (the global envrironment), this function detects if the target package was loaded with load_all , and if so, it uses a customized method of searching for the file

file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file)   # exatcly as the raster function for raster files
typeof(file)
species
plot(species) # in shp (graphical) file the species were represented as points and this is the plot of them 

# looking at the occurrences
species$Occurrence # 1 presence, 0 absence
# sql in this case it is used to deal with data sets


# how many occurences are there?
species[species$Occurrence == 1,] # comma is used to stop the command here!

presence <- species[species$Occurrence == 1,]
plot(presence)

absence <- species[species$Occurrence == 0,]
absence

# plot all
plot(species, pch=19) # pch is the type of symbol

# plot instead of all occurences only the presence of that species
plot(presence, pch=19, col="blue")

# out of 200 data points 94 presence , 106 absences

# we want to add a plot, without removing the previous plot
# use points function
# points is a generic function to draw a sequence of points at the specified coordinates. The specified character(s) are plotted, centered at the coordinates.
# now we can plot presences and absence together 
points(absence, pch=19, col="red")

# now we have a graph that shows both presences and absences 
# predictors: look at the path

path <- system.file("external", package="sdm") # external i.e not speciefying a specific file
# lets look at the predictors
# predictors are environmental variables 

lst <- list.files(path=path,pattern='asc$',full.names = T)
# put all files together using stack (lapply could also be used but the files are internal for the software)
preds <- stack(lst)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)  

plot(preds$elevation, col=cl) 
# high values yellow/red, low values blue
points(presence)
# using points function to maintain the previous graph 
# not i can see where the species was presence in regards to elevation
# low presence on low elevations or the researcher didn't go to high elevations

# repeat with other predictors 

plot(preds$temperature, col= cl)
points(presence)
# species prefers higher temperatures

plot(preds$precipitation, col=cl)
points(presence)
# intermediate percipitation

## 11.01.22 lecture: making a model ## 

# model will calculate the probability of finding the species in an area without going in the field
# data used is inside the sdm package

setwd("/Users/viktoriasitnik/Documents/R/lab")
# source function: source causes R to accept its input from the named file or URL or connection or expressions directly. 

source("R_code_source_sdm.r")

# graphs from past lectures appear

preds # our predictories: elevation, precipitation, temperature, vegetation 
# explain to the software the data used 
# sdmData: creates a sdmdata objects that holds species (single or multiple) and explanatory variates. 
# train- species
sdmData(train=species, predictors=preds)
data.sdm <-sdmData(train=species, predictors=preds)
data.sdm

# sdm: Fits sdm for single or multiple species using single or multiple methods specified by a user in methods argument, and evaluates their performance.
library(sdm)

# formula = is actually default, no need to add it 
model1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=data.sdm, methods="glm")
m1
# the model is based on linear function y= bx+ a

## 12.01.2022 lecture ##
# predict - model you are using + data 

p1 <-predict(model1, newdata=preds) # predictions 1
plot(p1, col=cl)
# values 0 (low probability) -1 (high probability)
# test goodness of fit by plotting the presences on the map 
points(presences, pch=17)

# most of the points are located in the areas with higher probability
# in eastern part it is not so accurate
# might be due to predictor that is not considered in this model 

# make final stack to summarise everything
# stack: Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated. Unstacking reverses this operation.

s1 <-stack(preds, p1)
s1 <- stack(preds, p1)
plot(s1, col=cl)

# change all the graph titles/names (of s1)
names(s1) <- c('Elevation', 'Precipitation', 'Temperature', 'Vegetation', 'Model')
plot(s1, col=cl)




