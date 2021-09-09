# basic math on "scalars"
    2 + 3
    6 * 7
    log(exp(10)) #natural log, as in "ln"!
    sqrt(81)
    abs(-41)

# saving a value in a variable
    x <- 10    # <--- (alt minus shortcut)
    y = 9.1
    x * y

    My_result91 <- x * y
    My_result91

# mode / typeof / class / structure
    mode("me")
    mode(4.1)
    typeof(4.1)
    typeof(4L)
    class(as.Date("2010-01-13"))

    str("me")
    str(TRUE)
    str(4L)
    str(4.1)
    str(as.Date("2010-01-13"))
    
# checking / casting
    is.numeric(4.1)    
    is.character("2010-01-13") 
    is.character("4")
    as.numeric("4")
    as.numeric(FALSE)
    as.numeric(TRUE)
    is.logical(1)
    is.logical(TRUE)
    TRUE + 4
    
# vectors (row or column, no difference)
    # sequences
    c(2, 4, 6, 8)
    seq(from=2, to=8, by=2)
    1:4*2
    
    # rep
    rep(4, times=3)
    rep(6:8, 2)
    rep(6:8, each=2)
    
    # must be the same type
    rm(x)
    x <- c(1, 3, "Q")
    y <- 4:10
    c(x, y)
    
    # MANY funcitons are "vectorized"
    x <- 1:3
    y <- 7:9
    x + y
    sqrt(x)
    log(y)
    as.character(x+y)
    
    # vector recycling
    x <- 1:10
    y <- c(10, 100)
    x+y
    cbind(x, y, sum=x+y)
    1:10 + 1
    1:10 + 1:2
    1:10 + 1:3
    
    # subsetting
    rm(list=ls())
    x <- 10:20
    x[1]
    x[4]
    x[c(1,4)]
    x[1,4] # error!
    x[1:4]
    x
    x[-1]
    x[-(1:8)]
    
    # logical operators
    x <- 1:3
    x == 1
    x != 2
    x<3
    x>=2
    !(x>=2)
    x>0 & x<=2
    any(x==2)
    all(x<2)
    
    # logical vectors and subsetting
    y <- x %in% c(10,13)
    x[y]
    x[c(TRUE, FALSE)] #watch out for recycling!
    
    # everything is a function
    `>`(x,2)
    x>2
    
    # handy functions: length, seq_along, which, paste
    x <- letters[1:10]
    length(x)
    seq_along(x)
    which(x %in% c("d", "a", "n"))
    
    sentence <- c("I'm", "learning", "R")
    paste(sentence)
    paste("hi", "there", sep=" | ")
    paste0("path/to/folder/", "myfile.csv")
    
    # replacing elements
    x <- 1:10; rm(y)
    x[2] <- 250; x
    x[2:4] <- 100; x
    x[1:4] <- c(50, 30); x
    x[x<50] <- NA
    
    # naming elements
    myvec <- c(one=1, two=2, three=3, dan=100)
    urvec <- c(why=2, "so"=3, inconsistent="4") #or is it?
    
# NULL, NA, NaN, Inf
    x <- 5:8
    x[2] <- NA
    length(x)
    x[5]
    x[is.na(x)] <- 0

    y <- NULL
    length(y)
    
    400/0
    0/0

    print(pi, digits=20)
    letters
    LETTERS
    month.abb
    month.name
    exp(1)
    colors()    

# math functions for vectors
    x <- 1:100
    mean(x)
    sd(x)
    max(x)
    summary(x)
    sum(x)
    cumsum(x)
    cumsum(x)[c(99, 100)]
    
    x[30:40] <- NA
    mean(x)
    mean(x, na.rm=TRUE)

    
    
# PROBLEM SET 1 -----
    
# Use "which" and "letters" to find the position in the alphabet of the vowels
    
# Generate the sequence 1^2, 2^2, ... 20^2

# Write code that does the same thing as the "which" function for:
    x <- c(2,4,3,1,0,3)
    which(x==3)
    
# How many english colornames does R recognize that are longer than 8 characters? (use "nchar") 
    
# Thanksgiving is the 4th Thursday of November.  Professor Rossi's birthay is Nov 25.  
# Find all years between (and including) 1950-2050 in which his birthday is on Thanksgiving. 
# (use "seq" and "as.Date")

    
    
    
    
    
    
    