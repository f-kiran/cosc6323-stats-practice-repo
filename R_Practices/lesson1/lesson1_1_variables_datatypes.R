# R - statistical analysis, graphics representation and reporting

# ---- HELP ----
# Use '?' for help and 'help()' function
help("print")
?print
?help # help for the help :)

# VARIABLES ----
# Name may include: letters, numbers, and dot or underline characters
# Should start from a letter or dot (not followed by a number)

# Types of assignment
# Prefer using '<-' for assignment
?"<-"
# Examples: '<-', '->', '=', '<<-', '->>'

# Examples of valid variable names
my_String. = "Hello, World!"
"Hello, World!" -> my_String.2
my_String.3 <- "Hello, World!"
my_String.4 <<- "Hello, World!"
my_String.5 = "Hello, World!"
my_String.6 <<- "Hello, World!"


output_summary <- "my analysis"
output.summary <- "my analysis"

a <- b <- c <- 6

# Example of safe assignment
x <- 1:10 # sequence of numbers from 1 to 10
median(x)
?median
x

# Accessing variables
print(my_String.)
class(my_String.)

# R is dynamically typed language
# No need to specify the type of the variable
# R will automatically assign the type based on the value

x.1 <- "Healthy"
x.2 <- 36.6
x.3 <- 36L
.secretHidden <- "COSC6323"
cat("Here are my variables classes: ", class(x.1), ", ", class(x.2), ", ", class(x.3))

# Checking existing variables in the environment
?ls()
ls()

# Apply pattern matching
ls(pattern = "x.")

# all variables including hidden
print(ls(all.name = TRUE))

# Deleting variables
?rm(); ?remove()
rm(x.1)

# Check if variable is deleted
# x.1  # Uncommenting this line will result in an error


# Deleting all variables
# Good practice to use it at the beginning of the script to clear the environment
rm(list = ls()) 


# DATA TYPES ----

# Most frequently used data types in R:
# Vectors, Lists, Matrices, Arrays, Factors, Data Frames

# 1. VECTORS ----
# Simplest atomic objects! Others are built on top of vectors.

# Logical
logicalVector <- TRUE
print(class(logicalVector))
logicalVector

# Numeric
numericVector <- 23.5
print(class(numericVector))
numericVector

# Integer
integerVector <- 2L
print(class(integerVector))
integerVector

# Complex
complexVector <- 2+5i
print(class(complexVector))
complexVector

# Character
characterVector <- "Char"
print(class(characterVector))
characterVector

# Raw
?charToRaw()
rawVector <- charToRaw("Char")
print(class(rawVector))
rawVector

# COMBINE function c()
?c()

# Create a new vector:
colorSchemeVector <- c('r','g','b')
colorSchemeVector
class(colorSchemeVector)

# Get the class of the vector.
print(class(colorSchemeVector))

# 2. LISTS ----
# List can store different types of objects in a single variable 

# Create a list
?list
myList <- list(c(1,2,3), 21.3, "RGB")

# Print the list
print(myList)
class(myList)

# 3. MATRICES ----
# Two-dimensional rectangular data set
#   - All elements are of the same type
#   - Indexed by a vector of positive integers
#   - Have a dimension attribute - rows and columns
#   - Can be created by combining vectors with the matrix() function

?matrix
matrix1 <- matrix(c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(matrix1)

matrix2 <- matrix(c('a','a','b','c','b','a'), nrow = 3, ncol = 2, byrow = TRUE)
print(matrix2)

# 4. ARRAYS ----
# Any-dimensional data set
#   - All elements are of the same type
#   - Indexed by a vector of positive integers
#   - Have a dimension attribute - rows and columns
#   - Can be created by combining vectors with the array() function
?array
multiDimArray <- array(c('r','g', 'b'), dim = c(3,3,3))
print(multiDimArray)

# 5. FACTORS ----
?factor

# Create a vector
?rep() # replicate elements of vectors and lists

flagColorsVector <- c(rep('White',13),'Glory Red','Glory Blue')
flagColorsVector

# Create a factor object
factorFlag <- factor(flagColorsVector)

# Print the factor object
print(factorFlag)
print(nlevels(factorFlag))

# 6. DATA FRAMES ----
?data.frame
# Here comes the most important data type in R
# Data frame is a table or a two-dimensional array-like structure in which each column contains values of one variable and each row contains one set of values from each column.
# Data frame is a list of vectors of equal length
# Data frame has the attributes:
#   - row.names
#   - names
#   - class
#   - data.frame

# Create the data frame
BMI <- data.frame(
  gender = c("Male", "Male", "Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81, 93, 78),
  age = c(42, 38, 26)
)
print(BMI)
colnames(BMI)
row.names(BMI)
class(BMI)



