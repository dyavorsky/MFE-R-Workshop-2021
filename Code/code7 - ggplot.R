# ggplot2

library(ggplot2)



ggplot(mtcars) + 
    geom_point(aes(x=wt, y=mpg), color="firebrick")

ggplot(mtcars) + 
    geom_point(aes(x=wt, y=mpg, color=as.factor(cyl)))

ggplot(mtcars, aes(wt, mpg)) + 
    geom_point() + 
    theme_bw()

ggplot(mtcars) + geom_histogram(aes(wt))




## PRACTICE QUESTION

    # 1. # Use the 'diamonds' dataset in the 'ggplot2' to make the following plot:
        # x is 'log(carat)'
        # y is 'log(price)'
        # color the points with a different color for each level of 'clarity'
        # add a title (you'll probably have to google how to do this)
