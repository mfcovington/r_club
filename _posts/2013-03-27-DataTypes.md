---
title: Data Types
layout: post
categories: resources
comments: true
duedate:
---

Data Types
========================================================
This document provides a brief introduction to *Data Types*: how data is represented in R.  A separate document discusses *Data Structures*: the kinds of objects that data can be stored in.

R categorizes data as different types: numeric, character, factor, boolean/logical, date, etc.

Numeric
-------
The *numeric* data type is for numbers.  Numbers can be used for calculations.  Some relevant functions are:

```r
my.numbers <- c(4, 5)  # a numeric vector
sum(my.numbers)
```

```
## [1] 9
```

```r
is.numeric(my.numbers)
```

```
## [1] TRUE
```

```r
my.text.numbers <- c("4", "5")  # a character vector
sum(my.text.numbers)
```

```
## Error: invalid 'type' (character) of argument
```

```r
is.numeric(my.text.numbers)
```

```
## [1] FALSE
```

```r
as.numeric(my.text.numbers)
```

```
## [1] 4 5
```

```r
sum(as.numeric(my.text.numbers))
```

```
## [1] 9
```


Character
---------
The *character* data type is for representing text.  You can tell if something is a charcter type in R because it will be enclosed in quotes.

```r
my.text <- c("Julin", "Maloof")
my.text
```

```
## [1] "Julin"  "Maloof"
```

```r
is.character(my.text)
```

```
## [1] TRUE
```

```r
# converting numbers to characters
my.numbers
```

```
## [1] 4 5
```

```r
as.character(my.numbers)  # note the quotation marks
```

```
## [1] "4" "5"
```


Factor
------
The *factor* data type is used to designate groups.  Factors have associated levels that represent each possible group available in the factor.

```r
genotypes <- factor(c("wildtype", "mutant1", "mutant2", "wildtype"))
genotypes  #note that the levels are listed and the values are not in quotes
```

```
## [1] wildtype mutant1  mutant2  wildtype
## Levels: mutant1 mutant2 wildtype
```

```r
class(genotypes)
```

```
## [1] "factor"
```

```r
is.factor(genotypes)
```

```
## [1] TRUE
```

```r
is.character(genotypes)
```

```
## [1] FALSE
```

```r
as.character(genotypes)  # note the quotes
```

```
## [1] "wildtype" "mutant1"  "mutant2"  "wildtype"
```

```r
levels(genotypes)  #alpabetical by default
```

```
## [1] "mutant1"  "mutant2"  "wildtype"
```

```r
nlevels(genotypes)
```

```
## [1] 3
```

```r
# often you want wildtype to be the first level
genotypes <- relevel(genotypes, ref = "wildtype")
levels(genotypes)
```

```
## [1] "wildtype" "mutant1"  "mutant2"
```

```r
# or maybe you want to have a custom order for everything
genotypes <- factor(genotypes, levels = c("mutant2", "wildtype", "mutant1"))
genotypes
```

```
## [1] wildtype mutant1  mutant2  wildtype
## Levels: mutant2 wildtype mutant1
```


Logical
-------
The *logical* data type is used for true/false values

```r
my.boolean <- c(F, T, T, F)  #you could also use TRUE and FALSE
my.boolean
```

```
## [1] FALSE  TRUE  TRUE FALSE
```

```r
is.logical(my.boolean)
```

```
## [1] TRUE
```

```r
# The '!' reverses the values (logical NOT)
!my.boolean
```

```
## [1]  TRUE FALSE FALSE  TRUE
```

```r
# logicals can be used in extraction
genotypes[my.boolean]
```

```
## [1] mutant1 mutant2
## Levels: mutant2 wildtype mutant1
```

```r
genotypes[genotypes == "wildtype"]  #here you are creating a logical inside the square brackets.
```

```
## [1] wildtype wildtype
## Levels: mutant2 wildtype mutant1
```

```r
genotypes == "wildtype"
```

```
## [1]  TRUE FALSE FALSE  TRUE
```

```r
# conversions:
as.numeric(my.boolean)  # 1 is true, 0 is false.  This can be useful for summing, ie
```

```
## [1] 0 1 1 0
```

```r
sum(genotypes == "wildtype")
```

```
## [1] 2
```

```r
as.logical(c(1, 0, 1, 0))
```

```
## [1]  TRUE FALSE  TRUE FALSE
```

```r
as.character(my.boolean)
```

```
## [1] "FALSE" "TRUE"  "TRUE"  "FALSE"
```

```r
# converting from text
as.logical(c("T", "True", "true", "TRUE", "F", "False", "FALSE", "false", "not logical"))
```

```
## [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE    NA
```


*Posted by Julin Maloof*
