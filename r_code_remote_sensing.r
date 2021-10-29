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
