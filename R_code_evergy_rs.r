# R code for estimating energy in ecosystem

# set wd
setwd("~/Documents/R/lab")

#import the data 
brick("defor1.png")
l1992 <-brick("defor1.png")

l1992 <-brick("defor1.png") #image of 1992

#Bands: defor1_.1, defor1_.2, defor1_.3
#plot RGB

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")
