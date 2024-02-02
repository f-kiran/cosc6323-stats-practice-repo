# Sources
# https://www.r-bloggers.com/2021/06/how-to-find-z-score-in-r-easy-calculation-quick-guide/
# https://bookdown.org/mrenna/statbook/statistical-inference.html#hypothesis-testing
# https://sphweb.bumc.bu.edu/otlt/MPH-Modules/BS/R/R-Manual/R-Manual10.html

# Plan:
# 1. Sampling distribution
# 2. Sampling size and Sampling distribution
# 3. Z score
# 4. Hypothesis testing


# SAMPLING DISTRIBUTION
library(dplyr)

# It is a real estate data from the city of Ames, Iowa, USA. 
# The details of every real estate transaction in Ames is recorded by the City Assessor’s office. 
# Our particular focus for this lab will be all residential home sales in Ames between 2006 and 2010. 
# This collection represents our population of interest.

ames <- read.csv("http://bit.ly/315N5R5") 
dplyr::glimpse(ames) # you need dplyr to use this function

area <- ames$Gr.Liv.Area
price <- ames$SalePrice

head(area, n=10) # show first 10 observations 
head(price, n=10) # show first 10 observations 

length(area) # how many observations in the vector?

any(is.na(area)) #is there any NA in the vector area?
sd(area) # Population standard deviation

summary(area) # Population mean
summary(area)[[4]] # Population mean

hist(area,
     main = bquote(paste("Above ground living area (sq.ft.) |", ~italic("n"),  " = ", 
                         .(length(area)), ", ", ~mu, " = ", .(round(mean(area))), ", ",
                         ~sigma, " = ", .(round(sd(area), 2))),
                         )
     )
     



area <- ames$Gr.Liv.Area # create new dataset containing only variable 'Gr.Liv.Area' from dataset 'ames'
samp1 <- sample(area, 10) # take a random sample of 10 observations from the dataset 'area'
mean(samp1) # mean of the sample distribution for area. Note difference from population mean.


# Exercise (sampling, comparing means)
# 1. make two samples n1 = 50, n2 = 1000
# compare means

area <- ames$Gr.Liv.Area # create new dataset containing only variable 'Gr.Liv.Area' from dataset 'ames'
samp1 <- sample(area, 50) # take a random sample of 50 observations from the dataset 'area'
mean(samp1) #

samp2 <- sample(area, 1000) # take a random sample of 1000 observations from the dataset 'area'
mean(samp2) #


# 2. suppose we have samples n3 = 1500, n4 = 2000. 
# which is more accurate?



area <- ames$Gr.Liv.Area 
sample_means50 <- rep(NA, 500) # initialise a vector

for (i in 1:500) { # use of a loop function to draw a random sample 5000 times
    samp <- sample(area, 50)
    sample_means50[i] <- mean(samp)
}

hist(sample_means50, breaks = 25, 
     main = bquote(paste("sample_means50 living area (sq.ft.) |", ~italic("n"),  " = ", 
                         .(length(sample_means50)), ", ", ~mu, " = ", .(round(mean(sample_means50), 2)), ", ",
                         ~sigma, " = ", .(round(sd(sample_means50), 2))),
     ),
     
     xlab = "Means (sq.ft.)") #Histogram of the 500 samples (sampling distribution of the samples mean)





# SAMPLING SIZE AND DISTRIBUTION

# To get a sense of the effect that sample size has on 
# our distribution, let’s build up two more sampling 
# distributions: one based on a sample size of 10 and 
# another based on a sample size of 50 
# another based on a sample size of 100 from a 
# population size of 5000.


# Lets plot data to see the differences


area <- ames$Gr.Liv.Area 
sample_means10 <- rep(NA, 5000)
sample_means50 <- rep(NA, 5000)
sample_means100 <- rep(NA, 5000)

for(i in 1:5000){
    samp <- sample(area, 10)
    sample_means10[i] <- mean(samp)
    samp <- sample(area, 50)
    sample_means50[i] <- mean(samp)
    samp <- sample(area, 100)
    sample_means100[i] <- mean(samp)
}

par(mfrow = c(3, 1))  # this creates 3 rows and 1 column for graphs

xlimits <- range(sample_means10)

hist(sample_means10,  breaks = 25, xlim = xlimits)
hist(sample_means50,  breaks = 25, xlim = xlimits)
hist(sample_means100, breaks = 25, xlim = xlimits)

par(mfrow = c(1, 1))  


# HYPOTHESIS TESTING
# Z-score

# How to find? 
# Z-score provides how many standard deviations away a value 
# is from the mean.


# We can use the following formula for z-score calculation.
# Z-score = (x-μ)/σ
# x is a raw score to be standardized;
# μ is the mean of the population;
# σ is the standard deviation of the population.

# Example 1, single vector
data <- c(8, 7, 7, 10, 13, 14, 15, 16, 18) 
z_scores <- (data-mean(data))/sd(data)
z_scores

# The first raw data value of “8” is 0.9701425 standard deviations below the mean.
# The second raw data value of “7” is -1.2126781 standard deviations below the mean.
# The ninth raw data value of “18” is 0.2425356 standard deviations above the mean.

dev.off()
plot(z_scores, type="o", col="red")


# Example 2, Single Column in a DataFrame
data<- data.frame(A = c(2, 5, 6, 7, 9, 13),
                  B = c(24, 20, 13, 15, 19, 20),
                  C = c(15, 5, 7, 18, 14, 10))
z_scores <- (data$B-mean(data$B))/sd(data$B)
z_scores

# The first raw data value of “24” is 1.3970014 standard deviations 
# above the mean.
# The first raw data value of “20” is 0.3810004  standard deviations 
# above the mean.


# In general, the z score tells you how far a value is 
# from the average of the data in terms of standard deviations.

# qnorm in r - function to calculate z score in r
qnorm(0.75, mean = 0, sd = 1)

# Its value being below 1 means that the point that separates the 
# lower 75% observations and upper 25% observations is within one 
# standard deviation of the average, towards the right.


# The standard normal (z) distribution

# The pnorm( ) function gives the area, or probability, 
# below a z-value:
pnorm(1.96)

# To find a two-tailed area 
# (corresponding to a 2-tailed p-value) for a positive z-value:
2*(1-pnorm(1.96))

# The qnorm( ) function gives critical z-values corresponding 
# to a given lower-tailed area:
qnorm(.05)

# To find a critical value for a two-tailed 95% confidence interval:
qnorm(1- .05/2)


# HYPOTHESIS TESTING 2 


# https://statstutorial.com/how-to-perform-a-one-sample-z-test-in-r-with-examples/

# Z-Test in Statistics----



# Example 1: One-sample Z-test
# Null Hypothesis: The mean of a population is equal to a specified value.
# Alternative Hypothesis: The mean of a population is not equal to a specified value.

# Perform one-sample Z-test
#install.packages("BSDA")

# z.test(x,y = NULL,
#        alternative = "two.sided"or"greater", "less" or
#        mu = 0,
#        sigma.x = NULL,
#        sigma.y = NULL,
#        conf.level = 0.95
# )


library(BSDA)
# Define given dataset
dataset <- c(670,730,540,670,480,800,690,560,590,620,700,660,640,710,650,490,800
             ,600,560,700,680,550,580,700,705,690,520,650,660,790)

#Create qqplot for the dataset

qqnorm(dataset)
qqline(dataset)

# Step 1: Define the Null Hypothesis and Alternate Hypothesis.
# 
# let μ be the mean score of the population.
# 
# Null Hypothesis: the mean score is equal to 610
# 
# H0 : μ = 610
# 
# Alternate Hypothesis: the mean score is not equal to 610.
# 
# Ha : μ ≠  610
# 
# Step 2: level of significance (α) = 0.05
# 
# Step 3: Let’s check the assumptions.


# When to use a z-Test: ----

# - Your sample size must be greater than 30.
# - Data points should be independent from each other. 
#     In other words, one data point isn’t related or doesn’t affect another data point.
# - Your data should be normally distributed.
# - Samples should be drawn at random from the population.
# - The standard deviation of the population should be known




# Perform one-sample z-test ----

z_test_result<- z.test(x=dataset,mu=610,alternative = "two.sided",sigma.x = 100)
z_test_result

# Print the results
cat("\nExample 1: One-sample Z-test\n")
cat("Test Statistic:", z_test_result$statistic, "\n")
cat("P-value:", format(z_test_result$p.value,4), "\n")
cat("Hypothesis Test Result:", ifelse(z_test_result$p.value < 0.05, "Reject Null Hypothesis", "Fail to Reject Null Hypothesis"), "\n\n")


# Conclusion: ----
#   
# Since the p-value[0.0476] is less than the level of significance (α) = 0.05, we reject the null hypothesis.
# 
# This means we have sufficient evidence to say that the mean score for the students is not equal to 610.




# Example 2: Two-sample Z-test ----
# Null Hypothesis: The means of two populations are equal.
# Alternative Hypothesis: The means of two populations are not equal.



# Perform two-sample Z-test

# Null Hypothesis (H0): The means of two populations are equal.
# Alternative Hypothesis (H1): The means of two populations are not equal.

set.seed(456)
group1 <- rnorm(25, mean = 35, sd = 6)  # Group 1 data with mean 35
group2 <- rnorm(30, mean = 40, sd = 6)  # Group 2 data with mean 40

qqnorm(group1)
qqnorm(group2)

# Assuming known population standard deviations for illustration
z_test_result <- z.test(group1, group2, alternative = "two.sided", sigma.x = 6, sigma.y = 6)
z_test_result

# Print the results
cat("\nExample 2: Two-sample Z-test\n")
cat("Test Statistic:", z_test_result$statistic, "\n")
cat("P-value:", format(z_test_result$p.value,4), "\n")
cat("Hypothesis Test Result:", ifelse(z_test_result$p.value < 0.05, "Reject Null Hypothesis", "Fail to Reject Null Hypothesis"), "\n\n")





## Now if we have time
## CENTRAL LIMIT THEOREM EXAMPLE
# https://www.analyticsvidhya.com/blog/2019/05/statistics-101-introduction-central-limit-theorem/
data<-read.csv("../lesson2/Clt-data.csv")
dim(data)
head(data,3)

# Calculate the population mean
mean(data$Wall.Thickness)

# Plot all the observations in the data
hist(data$Wall.Thickness,col = "pink",main = "Histogram for Wall Thickness",xlab = "wall thickness")
abline(v=12.8,col="red",lty=1)

# We will take sample size=10, samples=9000
# Calculate the arithmetic mean and plot the mean of sample 9000 times
# draw sufficient samples of size 10, calculate their means, and plot them in R. 
# We know that the minimum sample size taken should be 30 but let’s just see what happens when we draw 10

s10 <- c()

n = 9000

for (i in 1:n) {
  s10[i] = mean(sample(data$Wall.Thickness,10, replace = TRUE)) }
hist(s10, col ="lightgreen", main="Sample size =10",xlab = "wall thickness")
abline(v = mean(s10), col = "Red")

# Now lets increase the sample size from 10 to 30, 50 and 500:
s30 <- c()
s50 <- c()
s500 <- c()

n = 9000

for ( i in 1:n){
  s30[i] = mean(sample(data$Wall.Thickness,30, replace = TRUE))
  s50[i] = mean(sample(data$Wall.Thickness,50, replace = TRUE))
  s500[i] = mean(sample(data$Wall.Thickness,500, replace = TRUE))
}
par(mfrow=c(1,3))
hist(s30, col ="lightblue",main="Sample size=30",xlab ="wall thickness")
abline(v = mean(s30), col = "red")

hist(s50, col ="lightgreen", main="Sample size=50",xlab ="wall thickness")
abline(v = mean(s50), col = "red")

hist(s500, col ="orange",main="Sample size=500",xlab ="wall thickness")
abline(v = mean(s500), col = "red")
par(mfrow=c(1,1))

