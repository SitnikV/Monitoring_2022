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

# now let's make a model 
