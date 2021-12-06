
# lecture 06.12.21
library(raster)
library(RStoolbox) # package for classification process
library(ggplot2)

setwd("/Users/viktoriasitnik/Documents/R/lab/")
rlist <- list.files(pattern="defor")

# brick function because a file conatins 3 bands, single layer files use raster
list_rast <- lapply(rlist, brick)

# lapply (x, FUNCTION)
list_rast

plot(list_rast[[1]])

# create object 
l1992 <- list_rast[[1]]

l2006 <- list_rast[[2]]

# RGB NIR1, red 2, green 3
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# unsupervised classification = software is doing the analysis
# supervised classification the user is doing the analysis

l1992c <- unsuperClass(l1992, nClasses = 2) # unsuperClass (x, nClasses)

# nClasses = the amount of classes you want to use, in our class 2 (forest&agriculture)
# what class the value number represents
plot(l1992c$map)
# 1 forest, 2 bare soil

# create frequency table
freq(l1992c$map)
# forest (class 1) has 306 221 pixels and agriculture&water (class 2) has 35 071

# find total amount of pixels
total <- c(341292)
propagri <- 35071/total
propforest <- 306221/total

# build a dataframe 

cover <-c("forest", "agriculture")
proportions1992 <-c("0.8972405",0.1027595 )

# but what if we use variables instead of valeus #IT WORKS
proportions <-c(propforest,propagri)

propforest
propagri

proportions1992 <- data.frame(cover, proportions)
proportions1992

ggplot(proportions1992, aes(x=cover, y=proportions, color=cover)) + geom_bar(stat="identity", fill="white")

# classification of 2006
# unsupervised classification

l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses) 
l2006c
plot(l2006c$map)
# agriculture & water (class1), forest (class2)

total <- 341292
propagri <- 34710/total
propforest <- 306582/total
prop2006 <-c(propagri, propforest)

proportion <- data.frame(cover, prop1992, prop2006)

install.packages("gridExtra")
library(gridExtra)
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# plotting altogether

p1 <- ggplot(proportions1992, aes(x=cover, y=proportions, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

library(gridExtra)
# grid.arrange (p1, p2, nrows=1)
grid.arrange(p1, p2, ncol=2)
