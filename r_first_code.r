# excited to write my first code on Github

# Constanza input data on streams
 
stream<-c(100,120,300,400,100)

# new set, Marta data on fishes genomes

fishes<-c(10, 50, 60, 100, 200)
 


# first plot in R, plotting correlation stream against fishes diversity

plot(stream, fishes)

# change colour on data points to green

plot(stream, fishes, col=("green"))

# change the shape of data points to squares

plot(stream, fishes, col=("green"), pch=15)

# the data we developed can be stored in a table
# a table in R is called data frame

data.frame(stream, fishes)

# assign created table a name (water)

water <-data.frame(stream, fishes)

# water is a data frame now
# to see the table use View function

View(water)

# from now on we are going to import/export data

setwd("/Users/viktoriasitnik/Documents/R/lab/")

# let's export the table

write.table(water, file = "myfirsttable.txt")

# it's now in the folder, wow
# colleague sent me a dataset, how to import it into R?

read.table("myfirsttable.txt")

# assign table to an object

viktoriatable <-read.table("myfirsttable.txt")

# let's start with statistics for lazy beautiful people (no need to find avg, mean, med etc. separately)
# create object summary 

summary(viktoriatable)

# creating summary of only one variable e.g in our case "fishes"
# $

summary(viktoriatable$fishes)

# create a histogram for fishes data using hist function

hist(fishes)

# do the same for stream

hist(stream)











