# R code for ecosystem monitoring by remote sensing
# install raster package
# https://cran.r-project.org/web/packages/raster/index.html

install.packages("raster")

# set wd

setwd("/Users/viktoriasitnik/Documents/R/lab")

library(raster)
#No quotes needed as package is already in R

# install package terra
 install.packages("terra")

# objects can not be numbers
brick("p224r63_2011.grd")

# name the file l2011
l2011<- brick("p224r63_2011.grd")

# obtain information about the data by entering the object name + enter
l2011

# 30x30 m quadrats, 7 layers, more than 4mln pixels in each, 1 is a max reflectance 0 is min
# plot data
plot(l2011)

# b1- reflectance of blue wavelenghth, b2- green, b3- red, the higher the reflectance the higher the value
# plot only blue reflectance
plot(l2011$B1_sre)

# change colours you want to use to represent the differences between bands
# use colorRampPalette
colorRampPalette(c("black","grey","light grey"))

# give these colour preferences a name 
cl<-colorRampPalette(c("black","grey","light grey"))(100)

# plot the bands with new colour preferences
plot(l2011, col=cl)

# absorbing objects in blac, reflecting objects in grey

#  Three layers are combined such that they represent the red, green and blue channel. This function can be used to make 'true (or false) color images' from Landsat and other multi-band satellite images
plotRGB(l2011,r=3, g=2, b=1, stretch="Lin")

# R_code_vegetation_indices.r

library(raster) # require(raster)
library(RStoolbox) # for vegetation indices calculation 
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwide NDVI
# install.packages("rasterVis")
library(rasterVis)


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

defor1

# difference vegetation index

# time 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2

# dev.off()
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi1, col=cl, main="DVI at time 1")

# time 2
dvi2 <- defor2$defor2.1 - defor2$defor2.2

plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1 - dvi2

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)


# ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# ndvi1 <- dvi2 / (defor2$defor2.1 + defor1$defor2.2)
# plot(ndvi2, col=cl)

difndvi <- ndvi1 - ndvi2

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)


# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# worldwide NDVI
plot(copNDVI)


# Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

# rasterVis package needed:
levelplot(copNDVI)

# R_code_vegetation_indices.r

library(raster) # require(raster)
library(RStoolbox) # for vegetation indices calculation 
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwide NDVI
# install.packages("rasterVis")
library(rasterVis)


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

defor1

# difference vegetation index

# time 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2

# dev.off()
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi1, col=cl, main="DVI at time 1")

# time 2
dvi2 <- defor2$defor2.1 - defor2$defor2.2

plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1 - dvi2

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)


# ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# ndvi1 <- dvi2 / (defor2$defor2.1 + defor1$defor2.2)
# plot(ndvi2, col=cl)

difndvi <- ndvi1 - ndvi2

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)


# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# worldwide NDVI
plot(copNDVI)


# Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

# rasterVis package needed:
levelplot(copNDVI)

library(raster)

# set wd
setwd("/Users/viktoriasitnik/Documents/R/lab")

# import satellite data 
# projects can't be numbers
# put name to a file 

l2011 <- brick("p224r63_2011.grd")

plotRGB(l2011, r=4, g=2, b=2, )
# stretch possible reflectance 0-1, for visualisation you can stretch into the range you are interested in.


plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# importing past data
brick("p224r63_1988.gri")
l1988 <- brick("p224r63_1988.grd")


par(mfrbw=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# put the NIR in the blue channel
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin")
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")  








