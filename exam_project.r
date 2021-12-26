### project aiming to study relationship between snow cover extent, vegetation and surface albedo ##
## satellite images from https://land.copernicus.eu/global/hsm are used ##
# Data used 1 km Global V1
# FPAR 06/01/2014,26/03/2014, 06/01/2018, 15/03/2018, 06/01/2020, 21/03/2020
# SCE 09/01/2018, 21/03/2018,, 09/01/2020, 21/03/2020
# ALDH 06/01/2014, 06/01/2018, 06/01/2020

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")
library(raster)
library(RStoolbox) # classification
library(ggplot2) 
library(gridExtra) # for grid.arrange plotting
library(ncdf4) # for working with the copernicus .nc data format
library(rgdal) # to select spatial extension (Estonia)
library(viridisLite)

# start with importing the data into R 
# list. functions produce a character vector of the names of files or directories in the named directory
# snowcover 
snowcover <- list.files(pattern="SCE")
snowcover

# vegetation 
fpar <-list.files(pattern = "FAPAR")
fpar
# surface albedo
albedo <-list.files(pattern="ALBH")
albedo

# now the lists are created within every category I can pick certain layer using square brackets
# lapply allows to apply a function to all files within a list

list_snow <-lapply(snowcover,raster) # raster because it's a single layer file
list_snow


list_fpar <-lapply(fpar, raster)
list_fpar


list_albedo <-lapply(albedo,raster)
list_albedo 


# however I will need to work on each layer separately and to have simpler names I will name them:
# use extent functiong from rgdal package to select spatial extension
# individual plotting of each data set is just outof personal interest
# snowcover


snowjan20 <- raster("c_gls_SCE_202001090000_NHEMI_VIIRS_V1.0.1.nc") 

plot(snowjan20) # plot to choose spatial extent from x and y axis
# may need to play around with numbers until the "perfect" fit is found

e <-extent(21, 28, 57, 60) # x and y axis coordinates for latitude and longitude
ext <- extent(c(21, 28, 57, 60))
sj20_estonia <- crop(snowjan20, ext)
plot(sj20_estonia)


snowmar20 <- raster("c_gls_SCE_202003210000_NHEMI_VIIRS_V1.0.1.nc") 
sm20_estonia <- crop(snowmar20,ext)
plot(sm20_estonia)


snowmar18 <- raster("c_gls_SCE_201803210000_NHEMI_VIIRS_V1.0.1.nc") 
sm18_estonia <-crop(snowmar18,ext)
plot(sm18_estonia)


snowjan18 <-raster("c_gls_SCE_201801090000_NHEMI_VIIRS_V1.0.1.nc")
sj18_estonia <- crop(snowjan18,ext)
plot(sj18_estonia)


# combine cropped snow data
snow_estonia <-c(sm18_estonia,sj18_estonia,sj20_estonia,sm20_estonia)
par(mfrow=c(1,2)) # We can put multiple graphs in a single plot by setting some graphical parameters with the help of par() function
plot(sm18_estonia, xlab="longitude", ylab="latitude")
plot(sm20_estonia, xlab="longitude", ylan="latitude")



sm18_estonia
sm20_estonia

install.packages("cowplot") # for plotting multiple ggplot graphs into a grid 
library(cowplot)
plot_grid(sj18,sm18,sj20,sm20, labels=c("A","B","C","D"))

        
sm18 <-ggplot() + geom_raster(sm18_estonia,mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 21.03.2018")

sm20 <- ggplot() + geom_raster(sm20_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
 scale_fill_viridis(option="viridis") + ggtitle("Snow cover 21.03.2020")

sj18 <- ggplot() + geom_raster(sj18_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 09.01.2018")

sj20 <- ggplot() + geom_raster(sj18_estonia, mapping = aes(x=x ,y=y, fill=Snow.Cover.Extent))+
  scale_fill_viridis(option="viridis") + ggtitle("Snow cover 09.01.2020")

# vegetation
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


fpar_estonia <-c(fparjan14,fparmar14,fparjan18, fparmar18,fparjan20,fparmar20)

# albedo

aldhjan14 <-raster("c_gls_ALBH_201401240000_GLOBE_VGT_V1.4.1.nc")
aj14_estonia <-crop(aldhjan14,ext)
plot(aj14_estonia)

aldhmar14 <-raster("c_gls_ALBH_201404130000_GLOBE_VGT_V1.4.1.nc")
am14_estonia <-crop(aldhmar14,ext)
plot(am14_estonia)



aldhjan18 <-raster("c_gls_ALBH_201801240000_GLOBE_PROBAV_V1.5.1.nc")
aj18_estonia <-crop(aldhjan18, ext)
plot(aj18_estonia)

aldhmar18 <-raster("c_gls_ALBH_201803130000_GLOBE_PROBAV_V1.5.1.nc")
am18_estonia <-crop(aldhmar18,ext)
plot(am18_estonia)


aldhjan20 <-raster("c_gls_ALBH_202001240000_GLOBE_PROBAV_V1.5.1.nc")
aj20_estonia <-crop(aldhjan20,ext)
plot(aj20_estonia)

aldhmar20 <-raster("c_gls_ALBH_202004130000_GLOBE_PROBAV_V1.5.1.nc")
am20_estonia <-crop(aldhmar20,ext)
plot(am20_estonia)

albedo_estonia_winter <-c(aj14_estonia,aj18_estonia,aj20_estonia)
albedo_estonia_spring <-c(am14_estonia, am18_estonia, am20_estonia)


# make a plot for an overview


#### spatial correlation between rasters ###


install.packages("spatialEco")
library(raster)
library(ggplot2)
library(spatialEco)

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

par(mfrow=c(3,2))
plot(cor_jan14, xlab = "latitude", ylab="longitude",col=cl,main="January 2014")
plot(cor_mar14, xlab = "latitude", ylab="longitude",col=cl,main=" March 2014")
plot(cor_jan18, xlab = "latitude", ylab="longitude",col=cl,main=" January 2018")
plot(cor_mar18, xlab = "latitude", ylab="longitude",col=cl,main=" March 2018")
plot(cor_jan20,xlab = "latitude", ylab="longitude",col=cl,main=" January 2020")
plot(cor_mar20,xlab = "latitude", ylab="longitude",col=cl,main=" March 2018")




## IN CASE OF AN ERROR: Error in plot.new() : figure margins too large ##
par("mar")
par(mar=c(1,1,1,1))
