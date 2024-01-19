## PACKAGES ----

# Where are my libraries?
.libPaths()

# List them
library()

# Attached libs and R objects:
?'search'
search()

# install.packages("ggplot2")
library("ggplot2") # load the library
require("ggplot2") # load the library

#install.packages("tidyverse")
library(tidyverse)

sessionInfo()

# Load source code   ----
source("lesson1_3_logic.R") # load functions from the file


# File system
getwd()
setwd('/Users/fkiran/Documents/GitHub/cosc6323-stats-r-practice/R_Practices/lesson1/')
getwd()

# Load Data from file ----
# CSV
data <- read.csv("timezone.csv")
class(data)



file.path <-file.choose()
data <- read.csv(file.path)
str(data) # structure of the data frame

# filter Europe timezones and save data to the file
dataEA <- subset(data, Group=="Europe")

View(dataEA)

# if dir not exist create it
dir.create("processed_data")
write.csv(dataEA,"processed_data/output.csv")

# In the same manner R works with:

# EXCEL
install.packages("xlsx")
library("xlsx")
?'read.xlsx'

# XML
install.packages("XML")
library("XML")
??'xmlParse'

# And much more... JSON, web data, Databases....

# Built-in datasets
data(mtcars)
?mtcars

str(mtcars)
colnames(mtcars)

# Couple words about plotting

# Pie chart
pie(mtcars$mpg[1:5], rownames(mtcars)[1:5])

# Bar chart
barplot(mtcars$mpg[1:5], ylim = c(0,26))
?barplot

# Boxplot
boxplot(mpg ~ cyl, data = mtcars, xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon", main = "Mileage Data")

# Histogram
hist(mtcars$mpg[1:5],xlab = "MPG",col = "yellow",border = "blue")

# Line graphs
plot(mtcars$mpg[1:5])
plot(mtcars$mpg[1:5],type = "o")
plot(mtcars$mpg[1:5],type = "l")

op <- par(mfrow = c(3,3), mar = .1+ c(2,2,3,1))
for (tp in c("p","l","b",  "c","o","h",  "s","S","n")) {
  plot(wt ~ mpg, data = mtcars,type = tp, main = paste0("plot(type = \"", tp, "\")"))
  if(tp == "S") {
    lines(x, y, type = "s", col = "red", lty = 2)
    mtext("lines(*, type = \"s\", ...)", col = "red", cex = 0.8)
  }
}

dev.off()


# Scatterplots
input <- mtcars[,c('wt','mpg')]

plot(x = input$wt,y = input$mpg,
     xlab = "Weight",
     ylab = "Milage",
     xlim = c(2.5,5),
     ylim = c(15,30),		 
     main = "Weight vs Milage"
)


