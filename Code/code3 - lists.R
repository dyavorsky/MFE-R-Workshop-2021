# vector recap
myvec <- c(ele1 = 7,
           ele2 = 8,
           ele3 = 9)

myvec[1]
myvec[1:2]
myvec["ele1"]

# lists
mylist <- list(alpha = 1:10,
               beta  = matrix(1:50, 10, 5),
               gamma = c("hi", "there") )

# 3 ways to extract list elements
    mylist$alpha
    mylist[[1]]
    mylist[1]

    class(mylist$alpha) # int
    class(mylist[[1]])  #  <-- double brackets gets you a vector (ie, the list element itself)
    class(mylist[1])    #  <-- single brackets gets you a subset of the list (which is a list) watch out!

    mylist$beta[4,3]
    mylist[["beta"]][4,3]
    mylist["beta"][4,3] #error -- can't subset list with [x,y] (ie, two dimensions)

    length(mylist)
    length(mylist[[1]])
    length(mylist[1])

# lapply and sapply
    newlist <- list(
        a = 1:10,
        b = 20:29,
        c = 100:150
    )

    mean(newlist[[1]])
    mean(newlist[[2]])
    mean(newlist[[3]])

    lapply(newlist, mean)
    sapply(newlist, mean)
    unlist(lapply(newlist, mean))




## PROBLEM SET 3

# Consider two families: the SSS family and the YYY family. Here's a list that has two
# elements (SSS and YYY), each is a (sub)list.  These sublists each have two vectors.
# Write code to "extract" the 'Alison' element (bonus points if you do this multiple ways).

fams <- list(
    SSS = list(parents = c("Ron", "Su"), kids = c("Alison", "Elisabeth")),
    YYY = list(parents = c("Lorie", "Bill"), children = c("Dan", "Nick", "Matt"))
)

# I use split to make a list below.
# Use an `apply` function to find the mean of each list element of xx
    xx <- split(matrix(1:100, 10, 10), 1:10)


