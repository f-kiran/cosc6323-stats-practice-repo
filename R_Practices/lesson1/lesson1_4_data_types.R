# String Manipulation -----

# 1- Concatenate strings ----
?paste
result <- paste("Hey", "there!", sep = " ")
result

# Format output
?format
formatted_result <- format(12.12123123123, digits = 5)
formatted_result

format("Hello Center", width = 20, justify = "r")

# Count characters
?nchar
char_count <- nchar("How many characters here?")
char_count

# Convert case
?toupper
toupper("you will see upper case here")
tolower("AND LOWER CASE HERE")

# Substring
?substring
substring("Elephant", 3, 5)

# 2- Vector Sequencing ----
1:10
1.5:10.5
1.5:10.3 # Last element out of bound

# Sequence with step
?seq
sequence <- seq(3, 6, by = 0.3)

# Combine different data types in one vector
mixed_vector <- c('black', 'red', 0, TRUE)
mixed_vector
class(mixed_vector)

# Accessing vector elements
myVector <- c("First", "Second", "Third", "Fourth")

# 1. By position
myVector[1]
myVector[c(1, 2)]

# 2. By logical indexing
myVector[c(TRUE, FALSE, FALSE, TRUE)]

# 3. By negative indexing
myVector[c(-1, -3)]
myVector[c(-3, -1)]

# Element recycling
v1 <- c(1, 2, 3, 4, 5, 6)
v2 <- c(1, 2)
v1 + v2
v1 - v2

# Sorting
?sort
sorted_vector <- sort(c(2, 4, 6, 1, 3), decreasing = TRUE)
sorted_vector


# 3- Data Frames ----

# The column names should be non-empty 
# The row names should be unique
# The data stored in a data frame can be of numeric, factor, or character type
# Each column should contain the same number of data items

# Create a data frame
BMI <- data.frame(
  gender = c("Male", "Male", "Female"),
  height = c(152, 171.5, 165),
  weight = c(81, 93, 78),
  age = c(42, NA, 26)
)

# Get the structure of the BMI
str(BMI)

# Get summary
summary(BMI)

# Extract data
# Accessing data frame elements

BMI[1,1] # first row, first column
BMI[1,] # first row
BMI[,1] # first column
BMI$gender # gender column
BMI$height # height column
BMI$weight # weight column
BMI$age # Age column

# Create a new data frame
new_df <- data.frame(Age = BMI$age, height = BMI$height)

# Extract rows and columns
BMI[c(1, 2), ]
BMI[, c(1, 2)]



# Expand data frame
# Add column
BMI$id <- c(21, 22, 23)
BMI

# Combine two data frames
?rbind
DF1 <- data.frame(first = c(1, 2, 3), second = c(4, 5, 6))
DF2 <- data.frame(first = c(7, 8, 9), second = c(10, 11, 12))
combined_DF <- rbind(DF1, DF2)
combined_DF

