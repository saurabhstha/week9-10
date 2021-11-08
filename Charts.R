# Import dependencies
library(ggplot2)
library(RColorBrewer)
library(maps)

# set working directory
setwd("C:/Users/Saurabh/Desktop/640/Week 9&10")

#load datasets
costco <- read.csv("C:/Users/Saurabh/Desktop/640/Week 9&10/costcos-geocoded.csv")
nba2008 <- read.csv("C:/Users/Saurabh/Desktop/640/Week 9&10/ppg2008.csv")

#shift the first column over to row names
row.names(nba2008) <- nba2008$Name
ppg <- nba2008[,2:20]

#matrix for uniformity across cells
ppg_matrix <- data.matrix(ppg)

#create heatmap
bball_heatmap <- heatmap(ppg_matrix, Rowv=NA, Colv=NA,
                         col = heat.colors(256), scale="column",
                         margins=c(4,8))

# Spatial Plot

map(database="state", region=c("Maine", "New Hampshire", "Vermont", "Massachusetts",
                               "Rhode Island", "Connecticut", "New York", "New Jersey",
                               "Pennsylvania"), col="#cccccc")
symbols(costco$Longitude, costco$Latitude, bg="#e2373f", fg="#ffffff", lwd=0.5,
        circles=rep(1, length(costco$Longitude)), inches=0.06, add=TRUE)


# Countour plot using field goal made and field goal attempted using ppg2008 dataset

ggplot(nba2008, aes(x=FGM, y=FGA))+
  theme_bw()+
  geom_point(alpha=0.1, col='blue')+
  geom_density2d(color='blue')+
  ggtitle('Contour Plot of field goal made(FGM) and field goal attempted(FGA)')+
  theme(plot.title = element_text(hjust = 0.3))+
  labs(x='FGM', y='FGA')