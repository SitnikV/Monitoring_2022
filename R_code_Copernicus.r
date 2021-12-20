# exercise with downloading and visualising data from Copernicus

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus")
# for opening data from copernicus ncdf4 package is needed

library(ncdf4)

# since data is in a raster format we will aslo need to recall the raster package
library(raster)

snow20211214 <-raster("snowcover14.12.21")
snow20211214

plot(snow20211214)


# snow cover data from 14.12.2021 (winter)
snow20121214 <-raster("c_gls_SCE_202111250000_NHEMI_VIIRS_V1.0.1.nc")
plot(snow20121214) 
install.packages("viridis")

library(viridis)
library(ggplot2)
library(RStoolbox)

snow20121214

ggplot() + geom_raster(snow20121214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))
ggplot() +geom_raster(snow20121214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +scale_fill_viridis()

# snow cover data from 29.08.2021 (summer)
snow29082021 <-raster("c_gls_SCE_202108290000_NHEMI_VIIRS_V1.0.1.nc")
plot(snow29082021)

# importing several sets at a time instead of 1 by 1
# first find a common pattern in file names you want to import
rlist <-list.files(pattern = "c_gls_SCE") 
rlist
# all files withing working directory containing SCE are listed

# import the data in a stack (filest together)
list_rast <- lapply(rlist, raster)
list_rast

# [[1]] summer, [[2]] winter

snowstack <- stack(list_rast)
snowstack

# unstack them by creating two different names again, in this case useless but helpful when there is a lot of images
summer <- snowstack$Snow.Cover.Extent.1
winter <- snowstack$Snow.Cover.Extent.2

# plot for summer, yellow = high snow cover
ggplot() + geom_raster(summer, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.1))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 29.08.2021")

# plot for winter = high snow cover
ggplot() + geom_raster(winter, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.2))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 25.11.2021")

# patchwork them together
library(patchwork)
# assign plot to an object, summer- s1, winter-w2

s1 <-ggplot() + geom_raster(summer, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.1))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 29.08.2021")

w2 <- ggplot() + geom_raster(winter, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.2))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 25.11.2021")

# plot them one on top of the other

s1/w2

# to zoom/crop into an area of interest first look at the coordinates
# e.g longitude = 0-20 and latitude = 30-50
# crop the stack to the extent of Sicily

ext <- c(0,20,30,50) # extend in which you want to crop
summer_cropped <-crop(summer, ext)
winter_cropped <- crop(winter, ext)

# plot cropped graphs

summer_cropped <-ggplot() + geom_raster(summer_cropped, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.1))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 29.08.2021")
summer_cropped

winter_cropped <- ggplot() + geom_raster(winter_cropped, mapping = aes(x=x,y=y, fill=Snow.Cover.Extent.2))+
  scale_fill_viridis(option="viridis")+
  ggtitle("Snow cover on 25.11.2021")

winter_cropped

summer_cropped/winter_cropped






