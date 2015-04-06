# install required packages
install.packages(c("ggmap","mapproj","ggplot2"))
install.packages("scales")
install.packages("reshape2")

# To change working directory, use setwd("<path>")
# To read tsv file into a data.frame, use read.delim("filename")
# R can read tarballs as well (file.tar.gz)


# load packages to workspace
library("ggmap")
library("mapproj")
library("ggplot2")
library("scales")
library("reshape2")


# Set theme of ggplot to black & white
theme_set(theme_bw())


# Check the quakes dataset
head(quakes,n=10)


# Generate your first ggplot
ggplot(quakes,aes(x=long,y=lat)) + geom_point()
## data: quakes
## x of plot: longitude
## y of plot: latitude
## geom_point(): generates a scatter plot


# Build plots using layers
# First, scatter plot
ggplot(women, aes(x=height, y=weight) ) +
  geom_point() 
# Second, line plot
ggplot(women, aes(x=height, y=weight) ) +
  geom_line() +
  geom_hline(yintercept = 140) +
  scale_x_continuous('Height', limits=c(55,75)) +
  scale_y_continuous('Weight')
## data: women
## x of plot: height
## y of plot: weight
## geom_line(): generates a line plot
## scale_*_continuous: edits the axis


# Generate histogram for magnitude of quakes
# Use an object to add layers one by one
p <- ggplot(quakes, aes(x=mag))
p <- p + geom_histogram()
p

# Edit binwidth for histogram
p <- ggplot(quakes, aes(x=mag))
p <- p + geom_histogram(binwidth=0.1)
p

# Update x-axis
p <- ggplot(quakes, aes(x=mag))
p <- p + geom_histogram(binwidth=0.1)
p <- p + scale_x_continuous("Magnitude", limits=c(4,8), breaks=seq(4,8,1))
p


# Plot for location of earthquakes plus depth and magnitude information
# First try
p <- ggplot(quakes, aes(x=long, y=lat) ) 
p <- p + geom_point()
p

# Change point size
p <- ggplot(quakes, aes(x=long, y=lat) ) 
p <- p + geom_point(size = 3, color = "blue")
p

# Use aes() in geometries
p <- ggplot(quakes, aes(x=long, y=lat) ) 
p <- p + geom_point(size = 1, aes(color = depth))
p

# You can even load data layer in geometries
p <- ggplot() 
p <- p + geom_point(data = quakes, size = 1, aes(x=long, y=lat, color = depth))
p

# Complete plot, layer by layer
p <- ggplot(quakes, aes(x=long, y=lat) ) 
p <- p + geom_point(aes(color = depth, size=mag), alpha = 0.5) 
p
p <- p + geom_hline(yintercept=-16.5, linetype=2)
p
p <- p + geom_vline(xintercept=179.5, linetype=2)
p
p <- p + geom_point(x=179.5, y=-16.5, shape=4, color="darkred", size=3)
p

# Save the plot in p
ggsave(plot=p, file='./quakes_scatterplot.pdf', width=5, height=5)

# Advanced: add a map layer to the plot
p <- qmap(location=c(lon=180,lat=-20), zoom = 4, color = "bw", legend = "topleft") 
p
p <- p + geom_point(data=quakes, aes(x=long, y=lat, color=depth, size=mag), alpha=0.5)
p
p <- p + geom_hline(yintercept=-16.5,linetype=2)
p <- p +  geom_vline(xintercept=179.5,linetype=2)
p <- p + geom_point(x=179.5, y=-16.5, shape=4, color="darkred", size=3)
p


# reshape2 library: melt and cast
# ggplot uses every line of the data frame as a data point
# What if each line corresponds to more than one data point?
# Need to reshape the data frame
smiths
# Use melt to convert data frame into long-format
smiths_long <- melt(smiths, id.vars=c("subject"))
smiths_long
# To convert back to wide format, use dcast
smiths_wide <- dcast(smiths_long, subject ~  variable)

