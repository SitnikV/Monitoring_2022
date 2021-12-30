### project aiming to study relationship between snow cover extent, vegetation and surface albedo ##
## satellite images from https://land.copernicus.eu/global/hsm are used ##
# Data used 1 km Global V1
# FPAR 06/01/2014,26/03/2014, 06/01/2018, 15/03/2018, 06/01/2020, 21/03/2020
# SCE 09/01/2018, 21/03/2018, 09/01/2020, 21/03/2020
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
  scale_fill_viridis(option="viridis") + labs(x = "latitude", y = "longitudel", title ="Snow cover 21.03.2018")
                                              
# subtitle = "Add a subtitle below title", caption = "Add a caption below plot"


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


## export code from .txt file!! ##


## QGIS DATA ##
library(raster)
library(tiff)
# create vector for forest cover 2018
forest_cover18 <-raster("Treecover_2018_merged.tif")
imperviousness18 <-raster("hhhhh.tif")



### Quantifying area of active photosynthesis in Estonian bog ###

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

# read code from .txt (Word) file
setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")


green_capital23 <-read.delim("gc23.txt") 
green_capital23

# works

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
p17 <- plotRGB(tln17, r=1, g=2, b=3, stretch="lin", main= "Tallinn 06.06.2017")

p21 <- plotRGB(tln21, r=1, g=2, b=3, stretch="lin", main= "Tallinn 06.06.2021")

tln17 = stack(list_rast[[1]])  # 4 bands in total 
tln21 = stack(list_rast[[2]])

p17/p21
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

total <- 162642+111039
total
freq_green_17 <- 97962/total    
freq_green_17 #   0.3579423


freq_green_21 <- 111039/total
freq_green_21 # 0.4057242

0.4057242 - 0.3579423

## 0.0477819 ca. 4.8% of green areas have been gained in the period between 2017 and 2021 ##

#  0.4585586 

0.4662966-0.4585586

# ca.0.8% of green areas have been lost between 2017-2021

box(col="white") # add borders # didnt use in the end

### comparison between 2018 and 2021 winter quantify energy and albedo, is it stronger with plot with lower energy? ###
### correlation between vegetation in spring 2018 and 2021 and albedo ###


### done ###
