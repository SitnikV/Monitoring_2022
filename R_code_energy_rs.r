# R code for estimating energy in ecosystem

# set wd
setwd("~/Documents/R/lab")

#import the data 
brick("defor1.png")
l1992 <-brick("defor1.png")

l1992 <-brick("defor1.png") #image of 1992

#Bands: defor1_.1, defor1_.2, defor1_.3
#plot RGB

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")

# repeat same for 2006 data 

brick("defor2.png")
l2006 <- brick("defor2.png")

plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# par
par(mfrow=c(2,1))

#both images are shown together 
# DVI = NIR- ΛR

# 3 layers in the inout 1=NIR, 2=Red, 3=Green. We will use NIR and red. 

# calculate energy in 1992

dvi1992 <- l1992$defor1.1 - l1992$defor1.2

dvi1992 <- l1992$defor1.1 - l2006$defor1.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)

# and for 20006

dvi2006 <- l2006$defor2.1 - l2006$defor2.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)

# differencing two images of energy in two different times
dvidif <- dvi1992-dvi2006

#final plot: original images, dvis, final dvi difference

par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)

# save as pdf file
pdf("Energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()
