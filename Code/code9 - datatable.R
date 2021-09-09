## Data Table

install.packages("data.table") # you only need to do this once
library(data.table)

# example data.table
    set.seed(1234)
    dt <- data.table(
        ints = sample(1:100, 100, T),
        lets = sample(letters[1:4], 100, T),
        caps = sample(LETTERS[1:4], 100, T)
    )
    
    str(dt)
    
# subset rows
    dt[1:4, ]
    dt[1:4]
    dt[dt$ints<10]
    dt[ints<10]
    
# subset cols
    head( dt[ , ints]              )
    head( dt[ , "ints"]            )
    head( dt[ , c("ints", "lets")] )
    head( dt[ , list(ints, lets)]  )
    head( dt[ , .(ints, lets)]     )
    head( dt[ , 2:3]               )
    head( dt[ , ints:caps]         )

# create cols with :=
    dt[ , newvar := 1:nrow(dt)]
    head(dt)
    
# aggregate -- args take lists
    aggregate(dt$ints, by=list(dt$lets), mean)

    aggdt <- dt[ , mean(ints), by=lets]
    aggdt
    
    aggdt <- dt[ , .(avg_ints = mean(ints)), by=.(lets)]
    aggdt
    
# aggregate and merge is just one step
    dt[ , avg_ints := mean(ints), by=lets]
    head(dt[order(lets)])    
    
    dt[ , avg_ints := NULL]
    
    dt[ , .(avg_ints = mean(ints), 
            sum_ints = sum(ints)), by=lets]
    
# merge
    dt1 <- data.table(
        aa = 1:4,
        bb = c("a", "b", "c", "d"),
        cc = LETTERS[1:4],
        stringsAsFactors = F
    )
    
    dt2 <- data.table(
        aa = 2:5,
        pp = c("w", "x", "y", "z"),
        qq = LETTERS[23:26],
        stringsAsFactors = F
    )
    
    dt1
    dt2
    
    merge(dt1, dt2, by="aa", all.x=T)
    
# .N (ie, dot-N)
    
    data(iris)
    setDT(iris)
    class(iris)
    
    data(iris)
    iris <- as.data.table(iris)
    class(iris)
    
    iris[ , index := 1:.N, by=Species]
    iris[c(1:3, 47:53)]
    
# set functions
    names(iris)[which(names(iris) == "Species")] <- "species"
    names(iris)
    
    data(iris)
    setDT(iris)
    names(iris)
    
    setnames(iris, old="Species", new="species")
    names(iris)

# S.ubset of D.atatable (SD and .SDcols)
    twocols <- c("Sepal.Length", "Petal.Length")
    iris[ , lapply(.SD, mean), by=species, .SDcols = twocols]
    
    two_other_cols <- grep("Sepal.", names(iris), value=T)
    iris[ , lapply(.SD, mean), by=species, .SDcols = two_other_cols]

    
    
## PRACTICE QUESTIONS
    
    # use the flights data to answer these questions with data.table syntax
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    #1. Convert the flights data.frame to a data.table.
    
    #2. What is the average airtime per destination?
    
    #3. Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
        #3a. Do this *without* .SDcols
        #3b. Do this *with* .SDcols
    
    #4. Add the variable "tdf" to the data.table, where "tdf" is the total number of daily flights.
    #   That is, "tdf" is a count of the number of flights that departed each day
    #   As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    
    #5. Delete the variable time_hour from the data.table
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
