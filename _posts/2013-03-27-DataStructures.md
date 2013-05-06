---
title: Data Structures
layout: post
categories: resources
comments: true
duedate:
related: 2013-03-27-DataTypes
author: Julin Maloof
---

Data Structures
========================================================
This document provides a brief introduciton to *Data Structures*: the different types of objects that R uses for storing data.  See a separate document on *Data Types*

We will cover vectors, matrices, arrays, data frames, and lists.

Vectors
-------
*Vectors* are 1 dimensionsal collections of items of the same data type*.


```r
# construction
a <- 10:20  #a numeric vector
a
```

```
##  [1] 10 11 12 13 14 15 16 17 18 19 20
```

```r
# you can add names
names(a) <- letters[1:11]
a
```

```
##  a  b  c  d  e  f  g  h  i  j  k 
## 10 11 12 13 14 15 16 17 18 19 20
```

```r
b <- c("julin", "siobhan", "stacey")  # a character vector
b
```

```
## [1] "julin"   "siobhan" "stacey"
```

```r
c <- c(T, T, F)  # a logical vector
# testing query an object to see if it is a vector:
is.vector(a)
```

```
## [1] TRUE
```

```r
# subetting by position
a[4]
```

```
##  d 
## 13
```

```r
a[3:6]
```

```
##  c  d  e  f 
## 12 13 14 15
```

```r
a[c(3, 5, 7)]
```

```
##  c  e  g 
## 12 14 16
```

```r
# by name
a["c"]
```

```
##  c 
## 12
```

```r
a[c("b", "d", "e")]
```

```
##  b  d  e 
## 11 13 14
```

*exception: lists are technically vectors and can hold different data types


Matrices
--------
*Matrices* are 2 dimensional collections of items of the same data type.


```r
# you can use the matrix() function to make matrices
m <- matrix(1:25, ncol = 5)
m
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    6   11   16   21
## [2,]    2    7   12   17   22
## [3,]    3    8   13   18   23
## [4,]    4    9   14   19   24
## [5,]    5   10   15   20   25
```

```r
is.matrix(m)
```

```
## [1] TRUE
```

```r
dim(m)
```

```
## [1] 5 5
```

```r
# you can also use rbind() or cbind()
m2 <- rbind(c(1, 2, 3), c(11, 12, 13), c(21, 22, 23))
m2
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]   11   12   13
## [3,]   21   22   23
```


Arrays
------
*Arrays* are like matrices but have have 2 or more dimensions.  (Matrices are arrays but only have 2 dimensions)

```r
# construction
my.array <- array(1:27, dim = c(3, 3, 3))  # a 3D array
my.array
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]   10   13   16
## [2,]   11   14   17
## [3,]   12   15   18
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   19   22   25
## [2,]   20   23   26
## [3,]   21   24   27
```

```r
# testing
is.array(my.array)
```

```
## [1] TRUE
```

```r
# subsetting you can access subsets of the array using square brackets
my.array[1, , ]  # first row, across all columns and the 3rd Dim #note this is now 2 dimensions
```

```
##      [,1] [,2] [,3]
## [1,]    1   10   19
## [2,]    4   13   22
## [3,]    7   16   25
```

```r
my.array[2, 2, 3]  #now 1 dimension
```

```
## [1] 23
```


Data Frames
-----------
*Data Frames* are 2 dimensional objects, like matrices, **but** each column can hold a different data type.  This is an exceptionaly useful data structure.


```r
# construction
df <- data.frame(genotype = c("phyB", "Col", "phyB", "Col"), hyp.length = c(10, 
    3, 9, 2))
df
```

```
##   genotype hyp.length
## 1     phyB         10
## 2      Col          3
## 3     phyB          9
## 4      Col          2
```

```r
# subsetting get an individual column with '$'
df$genotype
```

```
## [1] phyB Col  phyB Col 
## Levels: Col phyB
```

```r
# or get any subset by []
df[3, 2]  #second column, third row
```

```
## [1] 9
```

```r
df["hyp.length"]
```

```
##   hyp.length
## 1         10
## 2          3
## 3          9
## 4          2
```

```r
# testing
is.data.frame(df)
```

```
## [1] TRUE
```

```r
# converting
as.matrix(df)
```

```
##      genotype hyp.length
## [1,] "phyB"   "10"      
## [2,] "Col"    " 3"      
## [3,] "phyB"   " 9"      
## [4,] "Col"    " 2"
```

```r
as.data.frame(m)
```

```
##   V1 V2 V3 V4 V5
## 1  1  6 11 16 21
## 2  2  7 12 17 22
## 3  3  8 13 18 23
## 4  4  9 14 19 24
## 5  5 10 15 20 25
```


Lists
-----
Lists are 1 dimensionsal structures where each item can be any data type.

```r
# here we create a list that holds many of the earlier objects
my.list <- list(my.matrix = m, my.df = df, my.array = my.array, my.first.vector = a, 
    my.second.vector = b)
my.list
```

```
## $my.matrix
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    6   11   16   21
## [2,]    2    7   12   17   22
## [3,]    3    8   13   18   23
## [4,]    4    9   14   19   24
## [5,]    5   10   15   20   25
## 
## $my.df
##   genotype hyp.length
## 1     phyB         10
## 2      Col          3
## 3     phyB          9
## 4      Col          2
## 
## $my.array
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]   10   13   16
## [2,]   11   14   17
## [3,]   12   15   18
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   19   22   25
## [2,]   20   23   26
## [3,]   21   24   27
## 
## 
## $my.first.vector
##  a  b  c  d  e  f  g  h  i  j  k 
## 10 11 12 13 14 15 16 17 18 19 20 
## 
## $my.second.vector
## [1] "julin"   "siobhan" "stacey"
```

```r
# testing
is.list(my.list)
```

```
## [1] TRUE
```

```r
# subsetting you can use the $ extractor
my.list$my.first.vector
```

```
##  a  b  c  d  e  f  g  h  i  j  k 
## 10 11 12 13 14 15 16 17 18 19 20
```

```r
# you can use [], which will return a smaller list
my.list[2]  # the second item
```

```
## $my.df
##   genotype hyp.length
## 1     phyB         10
## 2      Col          3
## 3     phyB          9
## 4      Col          2
```

```r
my.list[2:3]  #second and third item.
```

```
## $my.df
##   genotype hyp.length
## 1     phyB         10
## 2      Col          3
## 3     phyB          9
## 4      Col          2
## 
## $my.array
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]   10   13   16
## [2,]   11   14   17
## [3,]   12   15   18
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   19   22   25
## [2,]   20   23   26
## [3,]   21   24   27
```

```r
my.list["my.second.vector"]
```

```
## $my.second.vector
## [1] "julin"   "siobhan" "stacey"
```

```r
# you can use [[]] which will return the item itself
my.list[[2]]
```

```
##   genotype hyp.length
## 1     phyB         10
## 2      Col          3
## 3     phyB          9
## 4      Col          2
```

```r
is.data.frame(my.list[[2]])
```

```
## [1] TRUE
```

```r
# compare with
is.data.frame(my.list[2])
```

```
## [1] FALSE
```

```r
# unlist() sometimes is helpful
unlist(my.list[2])
```

```
##   my.df.genotype1   my.df.genotype2   my.df.genotype3   my.df.genotype4 
##                 2                 1                 2                 1 
## my.df.hyp.length1 my.df.hyp.length2 my.df.hyp.length3 my.df.hyp.length4 
##                10                 3                 9                 2
```

*Posted by Julin Maloof*
