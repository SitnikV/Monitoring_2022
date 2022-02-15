setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")
library(raster)
library(RStoolbox) # classification
library(ggplot2) # for plots and aesthetics
library(gridExtra) # for grid.arrange plotting
library(ncdf4) # for working with the copernicus .nc data format
library(rgdal) # to select spatial extension (Estonia)


## COPERNICUS DATA ##

# start with importing the data into R 
# list. functions produce a character vector of the names of files or directories in the named directory

# snowcover 
# import
snowcover <- list.files(pattern="SCE")
snowcover

# with list files I created a list of files by using common name in the files names from the folder set into the working directory
# now the lists are created within every category I can pick certain layer using square brackets
# lapply allows to apply a function to all files within a list, in this case i apply "raster" function

list_snow <-lapply(snowcover,raster) # raster because it's a single layer file
list_snow

# however I will need to work on each layer separately and to have shorter names 
# use extent function from rgdal package to select spatial extension
# individual plotting of each dataset is just out of personal interest

snowjan20 <- raster("c_gls_SCE_202001090000_NHEMI_VIIRS_V1.0.1.nc") 
# here the "raster" function is used to create raster layer objects

plot(snowjan20) # plot to choose spatial extent from x and y axis


# crop to the extent of Estonia
# may need to play around with numbers until the "perfect" fit is found
 # x and y axis coordinates for latitude and longitude
ext <- extent(c(21, 28, 57, 60))

# January 2020
sj20_estonia <- crop(snowjan20, ext)
plot(sj20_estonia)

# March 2020

snowmar20 <- raster("c_gls_SCE_202003210000_NHEMI_VIIRS_V1.0.1.nc") 
sm20_estonia <- crop(snowmar20,ext)
plot(sm20_estonia)

# March 2018

snowmar18 <- raster("c_gls_SCE_201803210000_NHEMI_VIIRS_V1.0.1.nc") 
sm18_estonia <-crop(snowmar18,ext)
plot(sm18_estonia)

# January 2018
snowjan18 <-raster("c_gls_SCE_201801090000_NHEMI_VIIRS_V1.0.1.nc")
sj18_estonia <- crop(snowjan18,ext)
plot(sj18_estonia)

# create ggplot plots of snowcover
# assign plots to an object to plot them together later

sm18 <-ggplot() + geom_raster(sm18_estonia,mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + labs(x = "latitude", y = "longitude", title ="Snow cover 21.03.2018")

# subtitle = "Add a subtitle below title", caption = "Add a caption below plot"


sm20 <- ggplot() + geom_raster(sm20_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 21.03.2020")

sj18 <- ggplot() + geom_raster(sj18_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 09.01.2018")

sj20 <- ggplot() + geom_raster(sj18_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 09.01.2020")

install.packages("cowplot") # for plotting multiple ggplot graphs into a grid 
library(cowplot)
plot_grid(sj18,sm18,sj20,sm20, labels=c("A","B","C","D"))


# vegetation
#import

fpar <-list.files(pattern = "FAPAR")
list_fpar <-lapply(fpar, raster)

fparjan14 <- raster("c_gls_FAPAR_201401240000_GLOBE_VGT_V1.4.1.nc") 
fj14_estonia <-crop(fparjan14,ext)
plot(fj14_estonia)

fj14 <-ggplot() + geom_raster(fj14_estonia,mapping = aes(x=x ,y=y, fill=Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km))+
  scale_fill_viridis(option="viridis") + ggtitle("Fpar 24.01.2014")
fj14

fparmar14 <- raster("c_gls_FAPAR_201403130000_GLOBE_VGT_V1.4.1.nc") 
fm14_estonia <-crop(fparmar14,ext)
plot(fm14_estonia)

fparjan18 <-raster("c_gls_FAPAR_201801240000_GLOBE_PROBAV_V1.5.1.nc")
fj18_estonia <-crop(fparjan18,ext)
plot(fj18_estonia)

fparmar18 <-raster("c_gls_FAPAR_201803130000_GLOBE_PROBAV_V1.5.1.nc")
fm18_estonia <-crop(fparmar18,ext)
plot(fm18_estonia)

fparjan20 <-raster("c_gls_FAPAR_202001130000_GLOBE_PROBAV_V1.5.1.nc")
fj20_estonia <-crop(fparjan20, ext)
plot(fparjan20)

fparmar20 <-raster("c_gls_FAPAR-RT6_202003100000_GLOBE_PROBAV_V2.0.1.nc ")
fm20_estonia <-crop(fparmar20, ext)
plot(fm20_estonia)


# albedo
# import

albedo <-list.files(pattern="ALBH")
list_albedo <-lapply(albedo,raster)

aldhjan14 <-raster("c_gls_ALBH_201401240000_GLOBE_VGT_V1.4.1.nc")
aj14_estonia <-crop(aldhjan14,ext)

aldhmar14 <-raster("c_gls_ALBH_201404130000_GLOBE_VGT_V1.4.1.nc")
am14_estonia <-crop(aldhmar14,ext)

aldhjan18 <-raster("c_gls_ALBH_201801240000_GLOBE_PROBAV_V1.5.1.nc")
aj18_estonia <-crop(aldhjan18, ext)

aldhmar18 <-raster("c_gls_ALBH_201803130000_GLOBE_PROBAV_V1.5.1.nc")
am18_estonia <-crop(aldhmar18,ext)

aldhjan20 <-raster("c_gls_ALBH_202001240000_GLOBE_PROBAV_V1.5.1.nc")
aj20_estonia <-crop(aldhjan20,ext)

aldhmar20 <-raster("c_gls_ALBH_202004130000_GLOBE_PROBAV_V1.5.1.nc")
am20_estonia <-crop(aldhmar20,ext)

#### spatial correlation between rasters ###


install.packages("spatialEco") # spatial analysis and modelling utilities. Functions include models for species population density, download utilities for climate and global deforestation spatial products etc...
library(raster)
library(spatialEco) # here used for calculating spatial correlation

cl <- colorRampPalette(c("blue","green","pink","yellow"))(100) # colors of the plot

## first lets plot the data to see changes in variables over years ##

cor_jan14 <-rasterCorrelation(fj14_estonia, aj14_estonia,s=3,type = "pearson")


# because areas with vegetation are not present there can be no correlation

cor_mar14 <-rasterCorrelation(fm14_estonia, am14_estonia,s=3,type = "pearson") 

# areas with vegetation show low correlation
plot(fj18_estonia)
cor_jan18 <- rasterCorrelation(fj18_estonia, aj18_estonia,s=3,type = "pearson")


plot(fm18_estonia)
cor_mar18 <- rasterCorrelation(fm18_estonia, am18_estonia,s=3,type = "pearson")

# March of 2018 had a large snow cover extent, also reflected in SCE data set

plot(fj20_estonia)
cor_jan20 <- rasterCorrelation(fj20_estonia, aj20_estonia,s=3,type = "pearson")


plot(fm20_estonia)
cor_mar20 <-rasterCorrelation(fm20_estonia, am20_estonia,s=3,type = "pearson")

par(mfrow=c(3,2)) # organising images into 3 rows and two columns 
plot(cor_jan14, xlab = "latitude", ylab="longitude",col=cl,main="January 2014")
plot(cor_mar14, xlab = "latitude", ylab="longitude",col=cl,main=" March 2014")
plot(cor_jan18, xlab = "latitude", ylab="longitude",col=cl,main=" January 2018")
plot(cor_mar18, xlab = "latitude", ylab="longitude",col=cl,main=" March 2018")
plot(cor_jan20,xlab = "latitude", ylab="longitude",col=cl,main=" January 2020")
plot(cor_mar20,xlab = "latitude", ylab="longitude",col=cl,main=" March 2020")

### Quantifying area of active photosynthesis in Estonian bog ###
### not presented on the oral part of the exam due to time limit ###
setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")
library(raster)
library(RStoolbox) # package for classification process
library(ggplot2) # plotting

rlist <- list.files(pattern="PS")
list_rast <- lapply(rlist, brick) # brick because multiband file
list_rast

# sqd. brackets to specify an object from a list

plot(list_rast[[1]])
plot(list_rast[[2]])

# creating objects 

ps_summer <- list_rast[[1]]
ps_winter <- list_rast[[2]]

plotRGB(ps_summer, r=1, g=2, b=3, stretch="lin")

# (stretch = "lin"), because When the range of pixel brightness values is closer to 0, a darker image is rendered by default...
# (stretch = "lin") ...We can stretch the values to extend to the full 0-255 range of potential values to increase the visual contrast of the image.
# (stretch = "lin") ... When the range of pixel brightness values is closer to 255, a lighter image is rendered by default. 
# ...We can stretch the values to extend to the full 0-255 range of potential values to increase the visual contrast of the image.


# Description

# (about plot RGB) Make a Red-Green-Blue plot based on three layers (in a RasterBrick or RasterStack). 
# (about plot RGB) Three layers (sometimes referred to as "bands" because they may represent different bandwidths in the electromagnetic spectrum) are combined such that they represent the red, green and blue channel.
# (about plot RGB) This function can be used to make 'true (or false) color images' from Landsat and other multi-band satellite images.

# unsupervised to let the software run the analysis
ps_summer_c <- unsuperClass(ps_summer, nClasses = 2) # unsuperClass (x, nClasses)

# nClasses = the amount of classes you want to use, in our class 2 (forest&agriculture)
# what class the value number represents
plot(ps_summer_c$map) 

# 2 green areas, high photosynthesis 1, no green vegetation
# create frequency table 

freq(ps_summer_c$map) # 1- 760395; 2- 420405 (in pixels)

# find relative frequencies
760395 + 420405
total <- c(1180800)
propveg_summer <- 420405/total # ca. 0.356
propnoveg_summer <- 760395/total  # ca. 0.644

cover <- c("vegetation", "no vegetation")
# use variables instead of values
prop_summer <-c(propveg_summer,propnoveg_summer)
propveg_summer
propnoveg_summer 

proportions_summer <-data.frame(cover, proportions)
proportions_summer

ggplot(proportions_summer, aes(x=cover, y=proportions, color=cover)) + geom_bar(stat="identity", fill="white")

# repeat same for the winter data
plotRGB(ps_winter, r=1, g=2, b=3, stretch="lin")
ps_winter_c <- unsuperClass(ps_winter, nClasses = 2) # computer calculated the proportions of two classes
ps_winter_c
plot(ps_winter_c$map) # oh wow, active ps even during winter
freq(ps_winter_c$map)

773605 + 407195

total <- 1180800
propveg_winter <- 407196/total
propnoveg_winter <- 773605/total
prop_winter <-c(propveg_winter, propnoveg_winter)


proportion <- data.frame(cover,prop_summer, prop_winter)

library(gridExtra)
ggplot(proportion, aes(x=cover, y=prop_winter, color=cover)) + geom_bar(stat="identity", fill="white")

# plotting altogether

s <- ggplot(proportions_summer, aes(x=cover, y=proportions, color=cover)) + geom_bar(stat="identity", fill="white")
w <- ggplot(proportion, aes(x=cover, y=prop_winter, color=cover)) + geom_bar(stat="identity", fill="white")

# gridExtra provides a number of user-level functions to work with "grid" graphics, notably to arrange multiple grid-based plots on a page, and draw tables.
# grid.arrange (p1, p2, nrows=1)
grid.arrange(s, w, ncol=2) # no significant changes in vegetation can be seen


### amount of green areas in tallinn city centre 2017- 2021 ###
# tallinn is the green capital of europe 2023 lets find out whether it is maintaining its green areas ###
### ADD CODE THROUGH WORD FILE AND MODIFY GRAPHS ###

library(raster)
library(RStoolbox) 
library(ggplot2)

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")
rlist <- list.files(pattern="Sentinel")

list_rast <- lapply(rlist, brick) # multilayer file
list_rast  # [[1]] 06.06..2017, [[2]] 06.06/2021

# create objects

tln17 = stack(list_rast[[1]])  # 4 bands in total 
tln21 = stack(list_rast[[2]])
tln17
plot(tln17)


# create a map of pixels where green is greater than red or blue
par(mfrow=c(2,1))

# for 2017 and assign it to an object gtln17
gtln17 <- plot(tln17[[2]]>tln17[[1]]) & (tln17[[2]] > tln17[[3]]) 

# and for 2021 and assign it to an object gtln21

gtln21 <- plot(tln21[[2]]>tln21[[1]]) & (tln21[[2]] > tln21[[3]])


# plotRGB can be used to create true/false colour images 
library(patchwork)
par(mfrow=c(2,1))
plotRGB(tln17, r=1, g=2, b=3, stretch="lin", main= "Tallinn 06.06.2017")

plotRGB(tln21, r=1, g=2, b=3, stretch="lin", main= "Tallinn 06.06.2021")


# quantify 
rlist <- list.files(pattern = "BUBA")
list_rast <- lapply(rlist, brick)
list_rast # [[1]] 2017, [[2]] 2021

tln17 <- list_rast[[1]]
tln17_c
tln21 <- list_rast[[2]]

tln17_c <- unsuperClass(tln17, nClasses = 2)
plot(tln17_c$map) #  1 no green, 2 green (NB!)
freq(tln17_c$map)


tln21_c <- unsuperClass(tln21, nClasses = 2)
plot(tln21_c$map) # 1 no green, 2 green (NB)
freq(tln21_c$map) 


total <- 175719+97962
total
freq_green_17 <- 97962/total    
freq_green_17 #   0.3579423

total <- 162635+111046
freq_green_21 <- 111039/total
freq_green_21  # 0.4057242

0.4057242 - 0.3579423

## 0.0477819 ca. 4.8% of green areas have been gained in the period between 2017 and 2021 ##

### LST AND NDVI DATA ANALYSIS ###

install.packages("gdalUtils") # for geospatial data abstraction

library(raster) # because .hdf is a raster format 
library(gdalUtils)

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam/LST")

# need to convert .hdf files into .tif format
# import them first 

files <- dir(pattern = ".hdf")
files
# dir R function returns a character vector of file and/or folder names within a directory
filename <- substr(files,10,13)
# substr used to extract the required characters from a string and also replace the values in a string

filename <- paste0("year", filename, ".tif")
# paste 0 is used to concatenate all elements without separator
filename

## didn't manage to work with a loop and therefore will convert each of the files manually as they are only 5 ##

# 2000 
sds <- get_subdatasets("MOD11C3.A2000153.006.2015064110836.hdf")
# get_subdatasets returns HDF4, HDF5, and NetCDF subdataset names for standardized files. In this case used to extract a subdataset.
sds
gdal_translate(sds[1], dst_dataset = "year2000.tif")
# gdal_translate converts raster data between different formats.

# 2005
sds <- get_subdatasets("MOD11C3.A2005152.006.2015254220416.hdf")
sds
gdal_translate(sds[1], dst_dataset = "year2005.tif")

# 2010 

sds <- get_subdatasets("MOD11C3.A2010152.006.2016041073454.hdf")
sds
gdal_translate(sds[1], dst_dataset = "year2010.tif")

# 2015 

sds <- get_subdatasets("MOD11C3.A2015152.006.2016223171353.hdf")
sds
gdal_translate(sds[1], dst_dataset = "year2015.tif")

# 2020 

sds <- get_subdatasets("MOD11C3.A2020153.006.2020183164401.hdf")
sds
gdal_translate(sds[1], dst_dataset = "year2020.tif")


# import the tiff data
lstoveryears <- list.files(pattern="year")
importlst <- lapply(rlistlst,raster) 
LSTstack <- stack(importlst)

# cropping the stack to the extent of Estonia
ext <- c(21, 28, 57, 60)
LSTstackcrop <- crop(LSTstack, ext)
plot(LSTstackcrop)

# change colours, blue- high temperatures, green - low
cl <- colorRampPalette(c('green','red','blue'))(100)
plot(LSTstackcrop, col=cl)

hist(LSTstackcrop,
     main = "Temperature on 7th June over years",
     xlab = "temperature", ylab = "frequency",
     col = "springgreen")

# import NDVI data from another folder

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam/NDVI")

# import data, assing it to an object
vegetation <- dir(pattern = "MOD")
vegetation
# 
veg_name <- substr(vegetation,10,13)
veg_name <- paste0("year", veg_name, ".tif")

veg_name

sds <- get_subdatasets(filesdvi[i])
gdal_translate(sds[1], dst_dataset = filenamedvi[i])

# 2000
sds <- get_subdatasets("MOD13C2.A2000153.061.2020048051851.hdf")
gdal_translate(sds[1], dst_dataset = "year2000.tif")

# 2005
sds <- get_subdatasets("MOD13C2.A2005152.061.2020237103511.hdf")
gdal_translate(sds[1], dst_dataset = "year2005.tif")

# 2010
sds <- get_subdatasets("MOD13C2.A2010152.061.2021168210043.hdf")
gdal_translate(sds[1], dst_dataset = "year2010.tif")

# 2015
sds <- get_subdatasets("MOD13C2.A2015152.061.2021328013520.hdf")
gdal_translate(sds[1], dst_dataset = "year2015.tif")

# 2020
sds <- get_subdatasets("MOD13C2.A2020153.061.2020340140629.hdf")
gdal_translate(sds[1], dst_dataset = "year2020.tif")

# import the .tif format data
rlist <- list.files(pattern="year")
import <- lapply(rlist,raster)
vegetation_stack <- stack(import)

# crop the stack to the extent of Estonia

ext <- c(21, 28, 57, 60)
vegetation_stack_crop <- crop(vegetation_stack, ext)
plot(vegetation_stack_crop)

# change colours
cl <- colorRampPalette(c("red","purple","dark green", "green"))(100)
plot(vegetation_stack_crop, col=cl)

summary(LSTstackcrop)
summary(vegetation_stack_crop)

# checking summaries to see whether there is an correlation between median temperature and vegetation values
# yes- years with higher median values of temperature have higher median values of NDVI

#plot the LST and NDVI data in the same colourscheme for comparison
library(rasterVis) #  visualisation
library(ggplot2) # for titles and aesthetics
library(viridis) # to modify colours

# land surface temperature
 gplot(LSTstackcrop)  + 
  geom_tile(aes(fill = value))  +
  facet_wrap(~ variable)  +  scale_fill_viridis(option="inferno")+
  ggtitle("temperature in Estonia in June over years")  +
  coord_equal() 


 # facet_wrap() is a ribbon of plots that arranges panels into rows and columns and chooses a layout that best fits the number of panels
# coord_equal ensures the units are equally scaled on the x-axis and on the y-axis

# NDVI 
gplot(vegetation_stack_crop)  + 
  geom_tile(aes(fill = value))  +
  facet_wrap(~ variable)  +  scale_fill_viridis(option="inferno")  +
  ggtitle("vegetation in Estonia in June over years")  +
  coord_equal()


