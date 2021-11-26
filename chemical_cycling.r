# R code for chemical cycling study
# time-series of NO2 change in Europe during lockdown

# import data
# brick function to import data

library(raster)
setwd("/Users/viktoriasitnik/Documents/R/lab/EN")

en01<- raster("EN_0001.png")

# what is the range of the data?


en02<- raster("EN_0002.png")
en03<- raster("EN_0003.png")
en04<- raster("EN_0004.png")
en05<- raster("EN_0005.png")
en06<- raster("EN_0006.png")
en07<- raster("EN_0007.png")
en08<- raster("EN_0008.png")
en09<- raster("EN_0009.png")
en10<- raster("EN_0010.png")
en11<- raster("EN_0011.png")
en12<- raster("EN_0012.png")
en13<- raster("EN_0013.png")

colorRampPalette("red", "orange", "yellow")
cl <- colorRampPalette(c('red','orange','yellow'))(100)

# plot the NO2 values of January 2020 by thw cl palette

par(mfrow=c(1,2))
plot(en01, col=cl)

# March 2020 NO2 values

plot(en03, col=cl)


plot(en13, col=cl)


# plot in multiframe

par(mfrow=c(2,1))
plot(en03, col=cl)


plot(en13, col=cl)


# plot all the data together
# build a stack of 13 images

par(mfrow= c(4,4))
plot(en01, col=cl)
plot(en02, col=cl)
plot(en03, col=cl)
plot(en04, col=cl)
plot(en05, col=cl)
plot(en06, col=cl)
plot(en07, col=cl)
plot(en08, col=cl)
plot(en09, col=cl)
plot(en10, col=cl)
plot(en11, col=cl)
plot(en12, col=cl)
plot(en13, col=cl)

# smarter way to do it
comben <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)

# plot the stack altogether
plot(comben, col=cl)


# plot only the 1st image from the stack

plot(comben$EN_0001, col=cl)

# rgb
par(mfrow=c(1,1))
plotRGB(comben, r=1, g=7, b=13, stretch="lin") 
