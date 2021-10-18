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



