# exercise with downloading and visualising data from Copernicus

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus")
# for opening data from copernicus ncdf4 package is needed

library(ncdf4)

# since data is in a raster format we will aslo need to recall the raster package
library(raster)

snow20211214 <-raster("snowcover14.12.21")
snow20211214

plot(snow20211214)
