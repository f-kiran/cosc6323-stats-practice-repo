
# ---- LOGIC ----
# CONTROL FLOW

# if
if (TRUE) {
    "It is true!"
}

if (FALSE) {
    "You should not see me in the console output :)"
}

# if ... else

if (FALSE) {
    "You should not see me in the console output :)"
} else {
    "Here I am!"
}

# switch
?switch


# ---- LOOPS

# repeat
?"repeat"

# while

# for 

# Control statements
# transfer control within the loop
#break 
#next

# ---- FUNCTIONS
# Built-in
# User-defined

?"function"

# Create a function to print squares of numbers in sequence.
my.function <- function(a,b,c) {
    for(i in 1:a) {
        result <<- i^2
        print(result)
        #print(c)
    }
    #print(b)
}

# Call the function supplying 6 as an argument for a
my.function(6, 0, 1) # position of arguments

my.function(b = 0, a = 6, c =1) # name of arguments

my.function(6) # what will happen here? :)
# This is called lazy evaluation (evaluated when needed)



