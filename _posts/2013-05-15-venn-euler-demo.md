---
title:      Venn and Euler diagrams
layout:     post
categories: exercises
comments:   true
duedate:    2013-05-23
author:     Stacey Harmer
related:    2013-05-23-venn-euler-exercise-key
---

Venn and Euler Diagrams
========================================================

Venn and Euler diagrams are powerful ways to display data, but use them with care - who among us hasn't suffered from Venn overload?  That said, it's very likely that sooner or later you will want to use them to analyze your data.

There are a number of up-to-date packages in R that allow you to make Venn and Euler diagrams.  They include:

- [venneuler](http://cran.r-project.org/web/packages/venneuler/index.html)
- [bvenn](http://cran.r-project.org/web/packages/bvenn/index.html)
- [colorfulVennPlot](http://cran.r-project.org/web/packages/colorfulVennPlot/)
- [eVenn](http://cran.r-project.org/web/packages/eVenn/index.html)
- [VennDiagram](http://cran.r-project.org/web/packages/VennDiagram/index.html)

I'm not entirely happy with any of these packages, but of these five choices I like VennDiagram the best.

Load the VennDiagram package now.


```r
library(VennDiagram)
```



It's quite easy to make very simple Venn diagrams with this package.

**Exercise 1:**  Run the below code and see for yourself.



```r
grid.newpage()
venn.plot <- draw.pairwise.venn(100, 70, 30, c("First", "Second"))
grid.draw(venn.plot)
```



But let's say you want more control over how your plot looks.  Well, VennDiagram can do that.

**Exercise 2:**  Run the below code and see what you get. Then change the settings for cat.pos, cat.dist, and scaled.  What do these options specify?



```r
grid.newpage()
venn.plot <- draw.pairwise.venn(area1        = 100,
                                area2        = 70,
                                cross.area   = 68,
                                scaled       = F,
                                category     = c("First", "Second"),
                                fill         = c("blue", "red"),
                                alpha        = 0.3,
                                lty          = "blank",
                                cex          = 2,
                                cat.cex      = 2,
                                cat.pos      = c(285, 105),
                                cat.dist     = 0.09,
                                cat.just     = list(c(-1, -1), c(1, 1)),
                                ext.pos      = 30,
                                ext.dist     = -0.05,
                                ext.length   = 0.85,
                                ext.line.lwd = 2,
                                ext.line.lty = "dashed")
grid.draw(venn.plot)
```



But wait, you say you want to compare three different groups?  VennDiagram can do that, too.

**Exercise 3:** Run the below code to make a simple three-way Venn.



```r
grid.newpage()
venn.plot <- draw.triple.venn(65, 75, 85, 35, 15, 25, 5, c("First", "Second", "Third"))
grid.draw(venn.plot)
```



**Exercise 4:**  Run the below to generate a more complex, prettier, three-way Venn.



```r
grid.newpage()
venn.plot <- draw.triple.venn(area1    = 65,
                              area2    = 75,
                              area3    = 85,
                              n12      = 35,
                              n23      = 15,
                              n13      = 25,
                              n123     = 5,
                              category = c("First", "Second", "Third"),
                              cat.pos  = c(0, 40, 250),
                              cat.dist = c(0.05, 0.05, 0.05),
                              fill     = c("blue", "red", "green"),
                              alpha    = 0.3,
                              lty      = "blank",
                              cex      = 2,
                              cat.cex  = 2,
                              cat.col  = c("blue", "red", "green"))
grid.draw(venn.plot)
```



*VennDiagram can deal with up to five separate groups; see the VennDiagram vignette (posted under 'Resources') for examples of how to make four- and five-group graphs.*


**Exercise 5:**
Now that you have a sense for how the package works, load the 'mtcars' dataset from the ggplot2 package.  Generate at least one two-way and one three-way Venn diagram comparing different automobile traits.


#### *What is tedious about this process?*


Yes, having to determine the sizes of the different groups and the sizes of the intersecting regions is painful, especially  when you are working with more than two groups.  Let's do something about that.


**Exercise 6:**
Write a function that allows you to generate a three-way Venn diagram without first manually calculating the sizes of the various groups and overlaps.


*Hint:  You will likely need to use functions described in the setdiff help page to do this.*

**_Bonus point_:** If you can figure out how to write the function so that you don't have to manually input the category names each time you run it, you get a gold star for the day.



####  Let's work with a larger dataset now.
Load the 'movies' dataset from the ggplot2 package.

**Exercise 7:**
Make what you think will be some interesting comparisons.  Generate Venn diagrams to visualize the overlaps between different groups.  Find two groups that have an overlap that you suspect is either greater than or less than you'd expect to happen by chance.


We can test the statistical significance of this overlap using Fisher's exact test.  The below example is taken from the 'movies' dataset; I compared the ratings of low budget movies


```r
ratings.budget.matrix <- matrix(c(243, (1064 - 243), (4072 - 243), (58788 - 4072 - 1064 + 243)),
                                2, 2,
                                dimnames = list(set=c("low.budget", "not.low.budget"),
                                class = c("high.rated", "not.high.rated")))
fisher.test(ratings.budget.matrix)
```



#### You can now make Venn diagrams to your heart's content. But be careful: with great power comes great responsibility!!  Use your new powers wisely.
