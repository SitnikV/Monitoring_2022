library(raster)
library(RStoolbox) 
library(ggplot2) 
library(gridExtra) 

setwd("/Users/viktoriasitnik/Documents/R/lab")

brick
# 1 list the files available
rlist <- list.files(pattern="defor")
rlist
# 2 lapply: apply a function to a list
list_rast <- lapply(rlist, brick) # lapply(x, FUN)
list_rast

total <- 341292
propagri <- 34710/total
propforest <- 306582/total

# build a dataframe

cover <- c("Forest", "Agriculture")

# prop1992 <- c(0.8982982, 0.1017018)

prop1992 <- c(propforest, propagri) 
proportion1992 <- data.frame(cover, prop1992)

# plot agriculture vs forest
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")

total2006 <- 342726
propagri2006 <- 163352/total2006
propforest2006 <- 179374/total2006


# build a dataframe

cover <- c("Forest", "Agriculture")

prop1992 <- c(propforest, propagri)

prop2006 <- c(propforest2006, propagri2006)
proportion <- data.frame(cover, prop1992, prop2006)
proportion

# assign ggplot to an object

p1 <- ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

# now to plots are stored to objects p1 and p2

grid.arrange(p1, p2, nrow=1)

# beautiful plots

install.packages("patchwork")
library(patchwork)
p1+p2

# to put one graph on top of the other 
p1/p2

# patchwork works with raster package too but should be plotted with ggplot


l1992 <- list_rast[[1]]
l1992

l2006 <-list_rast[[2]]
l2006

list_rast

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# instead of using plotRGBG, we will use ggRGB
ggRGB(l1992, r=1, g=2, b=3)
ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")

# in R log doesn't mean log in base 10 but log(ln)
ggRGB(l1992, r=1, g=2, b=3, stretch="log")

# patchwork
gb1 <-ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
gb2 <-ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gb3 <-ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gb4 <-ggRGB(l1992, r=1, g=2, b=3, stretch="log")

gb1+gb2+gb3+gb4

l2006 <- list_rast[[2]]
ggRGB(l2006, r=1, g=2, b=3)
ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
ggRGB(l2006, r=1, g=2, b=3, stretch="hist")
ggRGB(l2006, r=1, g=2, b=3, stretch="sqrt")
ggRGB(l2006, r=1, g=2, b=3, stretch="log")

gb1a <-ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
gb2b <-ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gb3c <-ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gb4d <-ggRGB(l1992, r=1, g=2, b=3, stretch="log")

gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)

gp1 + gp5
