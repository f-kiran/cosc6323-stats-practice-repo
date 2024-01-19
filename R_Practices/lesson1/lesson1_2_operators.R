# ---- Operators ------

# Arithmetic Operators
? '+'
# +, -, *, /, %% (remainder), %/% (quotient), ^
# %%: Give the remainder of the first vector with the second
# %/%: The result of division of the first vector with the second (quotient)

# Example:
v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)

v3 <- v1 + v2 # sum of the two vectors
v3 <- v3 - v2 # subtract v2 from v3
v3 <- v1 * v2 # multiply the two vectors
v3 <- v1 ^ v2 # v1 to the power of v2

# Relational Operators
# >, <, ==, ,<=, >=, !=
# Example:
v1 > v2 # Compare elemnts 
v3 == c(1, 32, 729)

# Logical Operators 
# &, |, ! (AND, OR, NOT)

# Example:
?"&"
c(TRUE, FALSE, TRUE) & c(TRUE, TRUE, FALSE)

c(FALSE, FALSE, FALSE) | c(FALSE, TRUE, TRUE)
c(FALSE) || c(FALSE, TRUE, TRUE)

c(FALSE) & c(FALSE, TRUE, TRUE)
c(FALSE) && c(FALSE, TRUE, TRUE)

# Assignment Operators
# Already discussed in Lesson1_1variables.R
# a <- c(1)
# a <- 1
# a = 1
# 1 -> a
# a <<- c(1)
# 1 ->> a

# Other Operators
# %in%: Identify if an element is present in a vector
# %*%: Matrix multiplication

# Examples:
v <- 1:10
v

2 %in% v # 2 is in v?
32 %in% v # 32 is in v?

M <- matrix( c(1:6), nrow = 2, ncol = 3, byrow = TRUE)
M %*% t(M) # Matrix multiplication
