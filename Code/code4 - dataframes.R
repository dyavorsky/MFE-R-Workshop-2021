# Data Frame (like an Excel spreadsheet)
    # make a list, convert to dataframe
    set.seed(1234)
    mylist <- list(
        col1 = 1:10,
        col2 = round(runif(n=10, min=25, max=75), 2),
        col3 = sample(x=letters[23:26], size=10, replace=TRUE)
    )

    mylist

    df1 <- as.data.frame(mylist)
    df1

    # exact same dataframe, but this time directly
    set.seed(1234)
    df2 <- data.frame(
        col1 = 1:10,
        col2 = round(runif(10, 25, 75), 2),
        col3 = sample(letters[23:26], 10, replace=T),
        stringsAsFactors = T
    )
    df2

# dataframe basics
    length(df1)
    ncol(df1)
    nrow(df1)
    dim(df1)
    names(df1)
    colnames(df1)
    rownames(df1)
    head(df1)
    tail(df1)
    str(df1)
    summary(df1)
    View(df1) # <-- new window!

# Factors -- "categorical" variables
    
    df1$col3 <- as.factor(df1$col3)
    
    df1
    str(df1)
    
    model.matrix( ~ 0 + df1$col3)

    levels(df1$col3)

    as.integer(df1$col3)

    table(df1$col3)

    # the old days!
    df3 <- data.frame(
        col1 = 1:10,
        col2 = round(runif(10, 25, 75), 2),
        col3 = sample(letters[1:4], 10, replace=T),
        stringsAsFactors = TRUE       # <-- default use to be true, is now false
    )
    str(df3)

# subset - extract columns like they're list elements
    # dollar sign
    df1$col1

    # double brackets
    df1[[2]]
    class(df1[[2]])
    df1[["col2"]]
    df1[[col2]] # error -- what is the object 'col2'? it doesn't exist

    # single brackets (returns a data.frame!)
    df1["col3"]
    class(df1["col3"])

    lapply(df1[ , c("col1", "col2")], mean)
    sapply(df1[ , c("col1", "col2")], sum)

# extract subset of rows (like rows of a matrix)
    df1[df1$col2 < 50, "col1"]

# subset of rows and cols (just put row and col subsetting together)
    df1[1:3, c("col2", "col3")]
    df1[c("col2", "col3")][1:3, ]
    df1[1:3, 2:3]

    colnamevec <- c("col2", "col3")
    df1[1:3, colnamevec]

    df1[df1$col2 < 50, ]

# create a new column
    df1$newcol <- df1$col1 + df1$col2
    df1$newcol
    df1

    # same name overwrites the column
    df1$newcol <- df1$newcol * 2
    df1

    df1$newcol <- NULL
    df1

    # replace just some values
    df1[df1$col1<5, "col1"] <- 96:99
    df1

# sort the dataframe
    sort(df1$col1)
    order(df1$col1)

    df1[order(df1$col1), ]
    df1 <- df1[order(df1$col1), ]

# reorder columns
    new_ord <- sort(names(df1), decreasing = TRUE)
    df1 <- df1[ , new_ord]
    df1

# ------------------
rm(list=ls())
# ------------------


# Combining dataframes

    df1 <- data.frame(
        aa = 1:4,
        bb = c("a", "b", "c", "d"),
        cc = LETTERS[1:4]
    )

    df2 <- data.frame(
        aa = 2:5,
        bb = c("w", "x", "y", "z"),
        cc = LETTERS[23:26]
    )

    df1
    df2

    # stack on top, must have same rownames
    rbind(df1, df2)

    # align side-by-side, not usually what you want to do
    names(df2)[2:3] <- c("pp", "qq")
    df2
    cbind(df1, df2)

    # merge (aka "join")
    merge(df1, df2, by="aa")          # inner join
    merge(df1, df2, by="aa", all.x=T) # left join
    merge(df1, df2, by="aa", all.y=T) # right join
    merge(df1, df2, by="aa", all=T)   # outer join


# summarizing (collapsing / aggregating) a dataframe
    set.seed(9898)
    df <- data.frame(
        ints = sample(1:100, 100, T),
        lets = sample(letters, 100, T),
        caps = sample(LETTERS, 100, T),
        stringsAsFactors = TRUE
    )

    str(df)
    summary(df)

    # aggregate -- args take lists
    aggregate(df$ints, by=df["lets"], mean)
    aggregate(df$ints, by=df[, c("lets", "caps")], length)

    # aggregate -- args take a formula
    aggregate(ints ~ lets, data=df, mean)
    aggregate(ints ~ lets + caps, data=df, length)


# reshaping a dataframe
    rm(list=ls())
    set.seed(567)
    df_wide <- data.frame(
        student_id = 1:10,
        male = sample(60:100, 10, T),
        female = sample(60:100, 10, T)
    )
    df_wide

    df_long <- reshape(
            data      = df_wide,             #<-- the dataframe to reshape
            direction = "long",              #<-- from wide to LONG, so put "long"
            idvar     = "student_id",        #<-- what uniquely identifies a row right now in wide format
            varying   = c("male", "female"), #<-- the colnames that we want to group into one col
            timevar   = "gender",            #<-- the name of the new column with the group ids (male, female)
            v.names   = "test_score")        #<-- the name of the new column with the values
    df_long

    df_wide2 <- reshape(
            data = df_long,
            direction = "wide",
            idvar = "student_id",
            timevar = "gender")
    df_wide2

    # reshaping made better with the "tidyr" package
    library(tidyr)
    gather(data  = df_wide,     # specify the dataframe
           key   = gender,      # new name for column made up of wide colnames
           value = test_score,  # new name for column of values
           -student_id)         # all the cols to reshape (or minus those NOT to reshape)

    df_long2 <- gather(df_wide, gender, test_score, male, female) # same thing!
    df_long2

    spread(df_long2, key=gender, value=test_score) # SOOO MUCH BETTER!


# getting data in/out of R (the super-short version)

    # very common
    my_df <- read.csv("path/to/file/filename.extension", stringsAsFactors = FALSE)

    # save a file
    save(my_df, file="path/to/file/filename.RData")

    # read R Data back in
    load("path/to/file/filename.RData") # it will be called "my_df"



# PROBLEM SET 4

# 1. load the "mtcars" dataset like this:
    data(mtcars)

    # 1a) Are any variables factors?

    

    # 1b) calculate the average miles per gallon of cars in the mtcars dataset

   

    # 1c) how many cars (ie, observations or rows) have each number of cylinders? (use "table")

    

    # 1d) make a new variable called "carname".  Populate that column with the rownames of the mtcars dataframe

    

    # 1e) create a dummy (0/1) variable to indicate which cars are Mercedes:
            # hint: use grepl("Merc", ...) where you fill in the ...
            # aside: the name grep comes from a command line tool 
            #        g/re/p (globally search for a regular expression and print matching lines)
            #        the "l" in grepl is because this R function returns logical values 

    

    # 1f) calculate the correlation between the miles per gallon and the weight of the Mercedes cars




# 2. Load the "iris" dataset

    data(iris)

    # 2a) use "aggregate" find the maximum of each of the numeric values by "species",
    #     then store this aggregated dataset as a dataframe named "iris2"

    

    # 2b) merge iris2 onto iris by species
    # 2c) take the original iris dataset and reshape it to be long; the resulting dataset
    #     should have 3 columns: species, measurement_name, and measurement_value


