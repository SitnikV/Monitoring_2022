## This project uses satellite data collected for EU's Earth Monitoring Programm Copernicus. ##
## The aim of the project is to  use grassland and imperviousness data from 2015 & 2018 in the UK to monitor whether artificial areas have expanded (and if so) was it at the expense of grasslands ##
## Tile ID: 	E30N30 (United Kingdom)  ##
## 100m resolution ##

## grassland 2015 data:  	GRA-2015-100m-E30N30 ##
## grassland 2018 data:   GRA-2018-010m-United Kingdom  ##
## imperviousness 2015 data:  	IMD-2015-100m-E30N30  ##
## imperviousness 2018 data:    IMD-2018-010m-United Kingdom ##

setwd("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam")
library(raster)
library(rgdal)

## I am interested in Southeast England and next I will make according spatial selections with the data ##

## 2015 grassland data ##
grass15<- raster("/Users/viktoriasitnik/Documents/R/lab/copernicus/monitoring_exam/grass2015/GRA_2015_100m_eu_03035_V1_2_E30N30.tif")

# remove unwanted data
rm(r)

ext <- extent(c(3400000, 3800000, 3000000, 3400000))
SEgrass15 <- crop(grass15, ext)
plot(SEgrass15)
