
# PROBLEM SET 1 -----

    # Use "which" and "letters" to find the position in the alphabet of the vowels
    
        which(letters %in% c("a", "e", "i", "o", "u", "y"))
    
    # Generate the sequence 1^2, 2^2, ... 20^2
    
        (1:20)^2
    
    # Write code that does the same thing as the "which" function for:
    x <- c(2,4,3,1,0,3)
    which(x==3)
    
        seq_along(x)[x==3]
    
    # How many english colornames does R recognize that are longer than 8 characters? (use "nchar") 
    
        sum(nchar(colors()) > 8)
        
    # Thanksgiving is the 4th Thursday of November.  Professor Rossi's birthay is Nov 25.  
    # Find all years between (and including) 1950-2050 in which his birthday is on Thanksgiving. 
    # (use "seq" and "as.Date")
    
        # get all november 25ths
        twofives <- seq(from=as.Date("1950-11-25"), to=as.Date("2050-11-25"), by="year")
        bdays <- which(weekdays(twofives) == "Thursday")
        
        length(bdays)
        twofives[bdays]





# PROBLEM SET 2 -----

    # Write your own code to extract the diagonal of an nxn matrix
    n <- 8
    mat <- matrix(1:(n^2), nrow=n, ncol=n); mat
    
        mat[cbind(1:n, 1:n)]
    
    # Write code to extract the first lower off-diagonal band of a matrix
    # i.e., for the matrix below, extract values (2, 8, 14, 20)
    n <- 5
    mat <- matrix(1:(n^2), nrow=n, ncol=n); mat
    
        mat[cbind(2:n, 1:(n-1))]
    
    # Write code to generate a general matrix (i.e., of any dimension n × n) that follows this pattern
          [,1] [,2] [,3] [,4] [,5] [,6]
    [1,]    2    3    4    5    6    7
    [2,]    3    4    5    6    7    8
    [3,]    4    5    6    7    8    9
    [4,]    5    6    7    8    9   10
    [5,]    6    7    8    9   10   11
    [6,]    7    8    9   10   11   12
        
        n <- 6
        matrix(1:n, nrow=n, ncol=n) + 
        matrix(1:n, nrow=n, ncol=n, byrow=T)
    
    # use the "rnorm()" function to take 10,000 draws from a normal distribution with mean 3, and sdev 5.
    # store these 10,000 draws in a 100x100 matrix and calculate the mean and stdev of each row; 
    # then take the average of those 100 means and the average of those 100 sd's
    
        draws <- rnorm(10000, mean=3, sd=5)
        mat <- matrix(draws, nrow=100, ncol=100)
        
        means <- apply(mat, 1, mean)
        sds   <- apply(mat, 1, sd)
        
        mean(means)
        mean(sds)





## PROBLEM SET 3

    # Consider two families: the SSS family and the YYY family. Here's a list that has two
    # elements (SSS and YYY), each is a (sub)list.  These sublists each have two vectors.
    # Write code to "extract" the 'Alison' element (bonus points if you do this multiple ways).
    
    fams <- list(
        SSS = list(parents = c("Ron", "Su"), kids = c("Alison", "Elisabeth")),
        YYY = list(parents = c("Lorie", "Bill"), children = c("Dan", "Nick", "Matt"))
    )
    
        fams$SSS$kids[1]
        fams[["SSS"]][["kids"]][1]
        fams[[1]][[2]][1]
    
    # I use split to make a list below.
    # Use an `apply` function to find the mean of each list element of xx
    xx <- split(matrix(1:100, 10, 10), 1:10)
    
        lapply(xx, mean)
        sapply(xx, mean)





# PROBLEM SET 4

    # 1. load the "mtcars" dataset like this:
    data(mtcars)
    
        # 1a) Are any variables factors?
        
            str(mtcars)  #no
        
        # 1b) calculate the average miles per gallon of cars in the mtcars dataset
        
            mean(mtcars$mpg)
        
        # 1c) how many cars (ie, observations or rows) have each number of cylinders? (use "table")
        
            table(mtcars$cyl)
        
        # 1d) make a new variable called "carname".  Populate that column with the rownames of the mtcars dataframe
        
            mtcars$carname <- rownames(mtcars)
        
        # 1e) create a dummy (0/1) variable to indicate which cars are Mercedes:
        # hint: use grepl("Merc", ...) where you fill in the ...
        # aside: the name grep comes from a command line tool 
        #        g/re/p (globally search for a regular expression and print matching lines)
        #        the "l" in grepl is because this R function returns logical values 
        
            mtcars$is_merc_log <- grepl("Merc", mtcars$carname)              # for a col of TRUE/FALSE
            mtcars$is_merc_int <- as.integer(grepl("Merc", mtcars$carname))  # for a col of 0/1
        
        # 1f) calculate the correlation between the miles per gallon and the weight of the Mercedes cars
        
            # base R approach
            cor(mtcars[mtcars$is_merc_log, c("mpg", "wt")])
            
            # another base R approach
            cor(mtcars[is_merc_log == T, "mpg"], mtcars[is_merc_log == T, "wt"])
            
            # using "with"
            with(mtcars[mtcars$is_merc_log==T,], cor(mpg, wt))
            
            # using "data table"
            library(data.table)
            setDT(mtcars)
            mtcars[is_merc_log==T, cor(mpg, wt)]
            
            # using "tidyverse"
            library(tidyverse)
            mtcars %>% summarize(cor(mpg, wt))
    
    
    # 2. Load the "iris" dataset
    
        data(iris)
        
        # 2a) use "aggregate" find the maximum of each of the numeric values by "species",
        #     then store this aggregated dataset as a dataframe named "iris2"
        
            iris2 <- aggregate(. ~ Species, data=iris, FUN="max")
            
        # let's change the names of iris2 to indicate they are maximums
        names(iris2)[-1] <- paste0(names(iris)[-1], ".species.max")
        
        # 2b) merge iris2 onto iris by species
            
            merge(iris, iris2, by="Species")
            
        # 2c) take the original iris dataset and reshape it to be long; the resulting dataset
        #     should have 3 columns: species, measurement_name, and measurement_value
            
            tidyr::pivot_longer(data=iris, !Species, names_to="m_name", values_to="m_value")





## PROBLEM SET 5

    # This function should replace NAs with zeros. Finish it by replacing the ...'s
    na_to_zero <- function(vec_with_nas) {
        stopifnot(is.vector(...))
        fixed_vec <- ifelse(is.na(...), ..., ...)
        return(fixed_vec)
    }
    
        na_to_zero <- function(vec_with_nas) {
            stopifnot(is.vector(vec_with_nas))
            fixed_vec <- ifelse(is.na(vec_with_nas), 0, vec_with_nas)
            return(fixed_vec)
        }
        
        na_to_zero(c(1, 2, NA, NA, 5))
    
    # Write a function that takes in a dataframe and calculates the correlation 
    # between the first column and every other column using a loop.
    set.seed(234)
    example_df <- mapply(function (x) sample(1:100, 10, T), 1:5)
    example_df <- as.data.frame(example_df)
    
        corr_with_col1 <- function(df) {
            N <- ncol(df)
            result <- vector(length=N)
            for(i in 1:N) {
                result[i] <- cor(df[,1], df[,i])
            }
            return(result)
        }
        
        corr_with_col1(example_df)
        cor(example_df)
    
    # Use an apply function and an anonymous function to calculate sum(x^2 - 10) 
    # for each vector in the following list
    testlist <- list(
        x1 = 1:10,
        x2 = 11:20,
        x3 = 21:30
    )
    
        sapply(testlist, function(x) sum(x^2, - 10))





## PROBLEM SET 6

    # Use the 'diamonds' dataset in the 'ggplot2' package to make the following plot:
        # x is 'log(carat)'
        # y is 'log(price)'
        # color the points with a different color for each level of 'clarity'
        # (you may find that transparency is nice addition here)
        # use pch to change the point character to a filled-in circle
        # use cex to make the points small
        # be sure to label the x-axis and y-axis, and add a title
        
        data(diamonds, package="ggplot2")
        
        colvec <- RColorBrewer::brewer.pal(n=8, name="Dark2")
        
        plot(x=log(diamonds$carat),
             y=log(diamonds$price),
             col=colvec[diamonds$clarity],
             pch=19,
             cex=0.5,
             xlab="Log Carat",
             ylab="Log Price",
             main="My Plot")
        
    # Run a regression of log(price) on log(carat) using the diamonds dataset and plot
    # the fitted regression line on the plot. Use lwd to make the line thicker and more noticeable.
        
        reg <- lm(log(price) ~ log(carat), data=diamonds)
        abline(reg, col="black", lwd=3)





## PROBLEM SET 7

    # Use the 'diamonds' dataset in the 'ggplot2' to make the following plot:
        # x is 'log(carat)'
        # y is 'log(price)'
        # color the points with a different color for each level of 'clarity'
        # add a title
        
        ggplot(diamonds) + 
            geom_point(aes(x=log(carat), y=log(price), color=clarity)) +
            ggtitle("Look at my fancy plot!")





## PROBLEM SET 8
        
    # use the flights data to answer these questions
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    # Convert the flights data.frame to a tibble.
    
        library(tidyverse)
        flights <- as_tibble(flights)
    
    # What is the average airtime per destination?
    
        flights %>% group_by(dest) %>% summarize(mean(air_time, na.rm=T))
        
    # Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
        
        flights %>% 
            group_by(year, month, origin) %>% 
            summarize(avg_dd = mean(dep_delay, na.rm=T),
                      avg_ar = mean(arr_delay, na.rm=T))
    
    # Add the variable "tdf" to the data.frame, where "tdf" is the total number of daily flights.
    # That is, "tdf" is a count of the number of flights that departed each day
    # As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    
        flights <- flights %>% 
                        group_by(year, month, day) %>% 
                        mutate(tdf = n())
        
    # Delete the variable time_hour from the data.table        
    
        flights <- flights %>% select(-time_hour)






## PROBLEM SET 9

    # use the flights data to answer these questions with data.table syntax
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    # Convert the flights data.frame to a data.table.
        
        library(data.table)
        setDT(flights)
    
    # What is the average airtime per destination?
    
        flights[ , .(avg_airtime = mean(air_time, na.rm=T)), by=.(dest)]
        
    # Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
    # Do this *without* .SDcols
        
        flights[ , .(avg_ad = mean(arr_delay, na.rm=T),
                     avg_dd = mean(dep_delay, na.rm=T)), by=.(month, year, origin)]
        
    # Do this *with* .SDcols
        
        cols <- grep("delay", names(flights), value=T)
        flights[ , lapply(.SD, mean, na.rm=T), by=.(month, year, origin), .SDcols=cols]
    
    # Add the variable "tdf" to the data.table, where "tdf" is the total number of daily flights.
    # That is, "tdf" is a count of the number of flights that departed each day
    # As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    
        flights[ , tdf := .N, by=.(year, month, day)]
        
    # Delete the variable time_hour from the data.table
        
        flights[ , time_hour := NULL]





