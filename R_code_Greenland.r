## working with greenland .tif land surface temperature (LST) data ##
# once a project with raster files is saved in R it is a temporary file and therefore can't be opened again on another computer

setwd("/Users/viktoriasitnik/Documents/R/lab/greenland")

# list the files
rlist <-list.files(pattern="lst")
rlist

# these are single layers of lst
library(raster)

# brick function for importing multiple layers
# raster function for single layer files

import <-lapply(rlist, raster)
import

# make a stack of 4 files

tgr <- stack(import)
tgr

# level plot of tgr
cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(tgr, col=cl)

# dark blue = low temperatures
library(ggplot2)
library(RStoolbox) # to put stuff into ggplot
library(patchwork)
library(viridis)
# ggplot of first and final images 2000 vs 2015

p1 <-ggplot() +
  geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
  scale_fill_viridis(option="magma")

# make same thing with lst 2015

p2 <-ggplot() +
  geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
  scale_fill_viridis(option="magma")

# lowest values have decreased in spread, meaning temperature has increased
# plot them together:
# 1. assign plots to objects p1, p2
# plot as p1 + p2
p1+p2

# make histogram (frequency distribution of data)
par(mfrow=c(1,2))
hist(tgr$lst_2000)
hist(tgr$lst_2015)

# separation of two peaks is higher in the 2015 data set, meaning the temperature is rising in certain parts

# for all the data sets
# par(mfrow=c(rows, colums)) thats how plots will be arranged

par(mfrow=c(2,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)

dev.off()
plot(tgr$lst_2010, tgr$lst_2015)

# y= bx + a 
# in our case b(slope)=1, a(intercept)= 0

abline(0,1, col="red")

# add xlim, ylim
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

# points over red line, all od these values are higher than in 2010
# make a plot with all the histograms and all the lines for all the variables

par(mfrow=c(4,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
plot(tgr$lst_2000,tgr$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000))
 abline(0,1,col="red")
plot(tgr$lst_2000,tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000))
 abline(0,1,col="red")
plot(tgr$lst_2000,tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
 abline(0,1,col="red")

# not the smartest way tho, its better to use stack
# pairs function creates scatterplot matrixes
  pairs(tgr)

# these are the histograms made before
# raise in the lowest temperatures
  
