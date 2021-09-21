# create a matrix
    mat <- matrix(1:50, nrow=10, ncol=5, byrow=F)
    mat
    
    mat2 <- matrix(1:50, nrow=10, ncol=5, byrow=T)
    mat2    

# matrix is a vector with attributes
    typeof(1:5)
    typeof(mat)
    mode(mat)
    class(mat)
    str(mat)
    
    attributes(1:5) # << no atts for a vector
    attributes(mat) # << dim att for a matrix
    
    attributes(mat)$dim <- NULL
    mat
    class(mat)

    vec <- 1:50
    attributes(vec)
    
    attributes(vec) <- list(dim=c(10,5))
    vec    
    
# matrix math
    rm(list=ls())
    x <- matrix(1:10, 5, 2)
    x
    
    y <- x
    x + y
    
    # vector recycling is still a thing
    x + 3    
    x + c(10, 100)
    
    # element-wise versus matrix multiplication
    x*y
    t(x) %*% y
    x %*% t(y)
    
    # matrix operations you would expect
    t(x)
    z <- crossprod(x, y); z
    diag(z)
    iden <- diag(10); iden
    
    mat <- matrix(c(1,2,3,0,1,4,5,6,0), 3, 3); mat
    solve(mat)
    solve(solve(mat))
    
    sqmat <- matrix(c(2,-1,0,-1,2,-1,0,-1,2), 3, 3); sqmat
    chol2inv(chol(sqmat))
    solve(chol2inv(chol(sqmat)))
    
# our first "apply" family function
    mat <- matrix(1:100, 10, 10); mat
    min(mat)
    sum(mat)
    rowSums(mat)
    colSums(mat)
    apply(mat, 1, max)
    apply(mat, 2, max)    
    
# subsetting and element-assignment
    mat <- matrix(1:100, 10, 10); mat
    mat[3,2]
    mat[1:3, 1:2]
    mat[4:5,4] <- 1000; mat
    
    sub <- matrix(c(1,1,4,6, 4, 7), nrow=3, ncol=2, byrow=T); sub
    mat[sub]
    
    



# PROBLEM SET 2 -----

# Write your own code to extract the diagonal of an nxn matrix
    n <- 8
    mat <- matrix(1:(n^2), nrow=n, ncol=n); mat
    
# Write code to extract the first lower off-diagonal band of a matrix
# i.e., for the matrix below, extract values (2, 8, 14, 20)
    n <- 5
    mat <- matrix(1:(n^2), nrow=n, ncol=n); mat
    
# Write code to generate a general matrix (i.e., of any dimension n × n) that follows this pattern
          [,1] [,2] [,3] [,4] [,5] [,6]
    [1,]    2    3    4    5    6    7
    [2,]    3    4    5    6    7    8
    [3,]    4    5    6    7    8    9
    [4,]    5    6    7    8    9   10
    [5,]    6    7    8    9   10   11
    [6,]    7    8    9   10   11   12
    
# use the "rnorm()" function to take 10,000 draws from a normal distribution with mean 3, and sdev 5.
# store these 10,000 draws in a 100x100 matrix and calculate the mean and stdev of each row; 
# then take the average of those 100 means and the average of those 100 sd's



