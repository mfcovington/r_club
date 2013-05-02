---
title: Strings and Regular Expressions Answers
layout: post
categories: solutions
comments: true
duedate:
related: 2013-04-21-Text-Searches-Regular-Expressions
author: Julin Maloof
---
String Searching and Manipulation
========================================================
R has extensive tools for searching for text (string) patterns and performing substitutions.  These can be very helpful in manipulation of large data sets.  

These functions can search for exact matches or can make use of an extensive syntax for wildcards, known as *regular expressions*.  I will first describe the search functions and then explain regular expressions.

In this excercise, type all of the code blocks into your computer to see what happens!  Experiment as you go!

Search Functions
----------------

### `grep()`
Use *`grep()`* when you want to search for a single pattern in a vector of strings.

```r
# for example: which state names have 'i' in them?
data(state)
state.name
```

```
##  [1] "Alabama"        "Alaska"         "Arizona"        "Arkansas"      
##  [5] "California"     "Colorado"       "Connecticut"    "Delaware"      
##  [9] "Florida"        "Georgia"        "Hawaii"         "Idaho"         
## [13] "Illinois"       "Indiana"        "Iowa"           "Kansas"        
## [17] "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
## [21] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"   
## [25] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
## [29] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
## [33] "North Carolina" "North Dakota"   "Ohio"           "Oklahoma"      
## [37] "Oregon"         "Pennsylvania"   "Rhode Island"   "South Carolina"
## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
## [45] "Vermont"        "Virginia"       "Washington"     "West Virginia" 
## [49] "Wisconsin"      "Wyoming"
```

```r
# in its basic form, grep returns the position (index) of the items that
# match the pattern.
grep(pattern = "i", x = state.name, ignore.case = T)
```

```
##  [1]  3  5  7  9 10 11 12 13 14 15 18 19 22 23 24 25 29 31 33 35 38 39 40
## [24] 46 47 48 49 50
```

```r
# you can also ask grep to return the values that match
grep(pattern = "i", x = state.name, ignore.case = T, value = T)
```

```
##  [1] "Arizona"        "California"     "Connecticut"    "Florida"       
##  [5] "Georgia"        "Hawaii"         "Idaho"          "Illinois"      
##  [9] "Indiana"        "Iowa"           "Louisiana"      "Maine"         
## [13] "Michigan"       "Minnesota"      "Mississippi"    "Missouri"      
## [17] "New Hampshire"  "New Mexico"     "North Carolina" "Ohio"          
## [21] "Pennsylvania"   "Rhode Island"   "South Carolina" "Virginia"      
## [25] "Washington"     "West Virginia"  "Wisconsin"      "Wyoming"
```

The variant *`grepl()`* returns a logical vector of TRUE and FALSE indicating whether or not a match occurred.

```r
grepl(pattern = "i", x = state.name, ignore.case = T)
```

```
##  [1] FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE
## [12]  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE
## [23]  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE
## [34] FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
## [45] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
```

```r
# recalling that TRUE = 1 and FALSE = 0, when can use grepl to quickly
# determine the number of states that have 'i' in them.
sum(grepl(pattern = "i", x = state.name, ignore.case = T))
```

```
## [1] 28
```

**Exercise 1:** Can you figure out how to count the number of states that do not have an "i" in their name (without changing the search pattern)?  There are at least two easy ways.

```r
sum(!grepl(pattern = "i", x = state.name, ignore.case = T))
```

```
## [1] 22
```

```r
length(grep(pattern = "i", x = state.name, ignore.case = T, invert = T))
```

```
## [1] 22
```



### `match()`
Use *`match()`* when you have two sets of values (lets call them Set A and Set B) and you want to know the (first) positions in Set B that match something that is in Set A.  Match only finds exact matches and can not be used with regular expressions.

```r
# we have a list of favorite fruits and a list of citrus.  Which of the
# favorites are citrus?
favorites <- c("peach", "bannana", "blueberry", "orange", "plum", "strawberry", 
    "mandarin")
citrus <- c("kumquat", "grapefruit", "orange", "mandarin", "orange", "tangerine", 
    "tangelo", "lemon", "lime")
match(favorites, citrus)  #what do the numbers returned refer to?
```

```
## [1] NA NA NA  3 NA NA  4
```

Match has an alternative form which I find more convenient: **`%in%`**.  This form returns Trues or Falses indicating whether or not Set A is in Set B.

```r
favorites %in% citrus
```

```
## [1] FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE
```

```r
# most useful is to use this in combination with square brackets to
# extract
favorites[favorites %in% citrus]
```

```
## [1] "orange"   "mandarin"
```

### `sub()`
**`sub()`** performs text substitutions.  Think of it as find and replace.

```r
# lets say that we wanted to replace 'W' with the phrase '_DoubleU_'
sub("w", "_DoubleU_", state.name, ignore.case = T)
```

```
##  [1] "Alabama"               "Alaska"               
##  [3] "Arizona"               "Arkansas"             
##  [5] "California"            "Colorado"             
##  [7] "Connecticut"           "Dela_DoubleU_are"     
##  [9] "Florida"               "Georgia"              
## [11] "Ha_DoubleU_aii"        "Idaho"                
## [13] "Illinois"              "Indiana"              
## [15] "Io_DoubleU_a"          "Kansas"               
## [17] "Kentucky"              "Louisiana"            
## [19] "Maine"                 "Maryland"             
## [21] "Massachusetts"         "Michigan"             
## [23] "Minnesota"             "Mississippi"          
## [25] "Missouri"              "Montana"              
## [27] "Nebraska"              "Nevada"               
## [29] "Ne_DoubleU_ Hampshire" "Ne_DoubleU_ Jersey"   
## [31] "Ne_DoubleU_ Mexico"    "Ne_DoubleU_ York"     
## [33] "North Carolina"        "North Dakota"         
## [35] "Ohio"                  "Oklahoma"             
## [37] "Oregon"                "Pennsylvania"         
## [39] "Rhode Island"          "South Carolina"       
## [41] "South Dakota"          "Tennessee"            
## [43] "Texas"                 "Utah"                 
## [45] "Vermont"               "Virginia"             
## [47] "_DoubleU_ashington"    "_DoubleU_est Virginia"
## [49] "_DoubleU_isconsin"     "_DoubleU_yoming"
```


**Excerise 2:** Try replacing all of the "i"s with "y"s.  Are results what you expected? Why or why not?

```r
sub("i", "y", state.name, ignore.case = T)
```

```
##  [1] "Alabama"        "Alaska"         "Aryzona"        "Arkansas"      
##  [5] "Calyfornia"     "Colorado"       "Connectycut"    "Delaware"      
##  [9] "Floryda"        "Georgya"        "Hawayi"         "ydaho"         
## [13] "yllinois"       "yndiana"        "yowa"           "Kansas"        
## [17] "Kentucky"       "Louysiana"      "Mayne"          "Maryland"      
## [21] "Massachusetts"  "Mychigan"       "Mynnesota"      "Myssissippi"   
## [25] "Myssouri"       "Montana"        "Nebraska"       "Nevada"        
## [29] "New Hampshyre"  "New Jersey"     "New Mexyco"     "New York"      
## [33] "North Carolyna" "North Dakota"   "Ohyo"           "Oklahoma"      
## [37] "Oregon"         "Pennsylvanya"   "Rhode ysland"   "South Carolyna"
## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
## [45] "Vermont"        "Vyrginia"       "Washyngton"     "West Vyrginia" 
## [49] "Wysconsin"      "Wyomyng"
```

```r
# Only the first 'i' in each word is replaced
```



### `gsub()`
`sub()` only replaces the first occurrence of *pattern*.  **`gsub()`** will replace all occurrences.

```r
gsub("i", "y", state.name, ignore.case = T)
```

```
##  [1] "Alabama"        "Alaska"         "Aryzona"        "Arkansas"      
##  [5] "Calyfornya"     "Colorado"       "Connectycut"    "Delaware"      
##  [9] "Floryda"        "Georgya"        "Hawayy"         "ydaho"         
## [13] "yllynoys"       "yndyana"        "yowa"           "Kansas"        
## [17] "Kentucky"       "Louysyana"      "Mayne"          "Maryland"      
## [21] "Massachusetts"  "Mychygan"       "Mynnesota"      "Myssyssyppy"   
## [25] "Myssoury"       "Montana"        "Nebraska"       "Nevada"        
## [29] "New Hampshyre"  "New Jersey"     "New Mexyco"     "New York"      
## [33] "North Carolyna" "North Dakota"   "Ohyo"           "Oklahoma"      
## [37] "Oregon"         "Pennsylvanya"   "Rhode ysland"   "South Carolyna"
## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
## [45] "Vermont"        "Vyrgynya"       "Washyngton"     "West Vyrgynya" 
## [49] "Wysconsyn"      "Wyomyng"
```

```r
# compare to just using sub()
```


Regular Expressions
-------------------
Regular expressions (regexp) are a way of specifying wild cards in the search operations described above. The same syntax (with some modifications) is used in many computer languages including Unix/Linux command line tools, Perl, python, and very helpfully SublimeText2.

### Character classes I
Regexp have codes to match certain _classes_ of characters.

* .  Matches any single character
* \w Matches any character that would be found in a "word" including digits (excludes punctuation and white space)
* \W Is the opposite of \w and matches any non-word character
* \d Matches any digit character
* \D Matches any non-digit character
* \s Matches any white space character
* \S Matches any non space character

The following match specific characters or locations but are worth mentioning here:
* ^  Matches the beginning of a line
* $  Matches the end of a line
* \t tab character
* \n return character

Unless you use additional modifications described below, these match a single character.

How would we find state names that have two "a"s separated by a single additional character?

```r
data(state)
grep("a.a", state.name, value = T, ignore.case = T)
```

```
## [1] "Alabama"   "Alaska"    "Delaware"  "Hawaii"    "Indiana"   "Louisiana"
## [7] "Montana"   "Nevada"
```


**Exercise 3:** Find state names that have a space in their names.

```r
grep(" ", state.name, value = T)
```

```
##  [1] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
##  [5] "North Carolina" "North Dakota"   "Rhode Island"   "South Carolina"
##  [9] "South Dakota"   "West Virginia"
```

```r
grep("\\s", state.name, value = T)
```

```
##  [1] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
##  [5] "North Carolina" "North Dakota"   "Rhode Island"   "South Carolina"
##  [9] "South Dakota"   "West Virginia"
```


**Exercise 4:** Find state names that begin with "M"

```r
grep("^M", state.name, value = T)
```

```
## [1] "Maine"         "Maryland"      "Massachusetts" "Michigan"     
## [5] "Minnesota"     "Mississippi"   "Missouri"      "Montana"
```

### Character classes II
An alternative way of specifying character classes is to enclose them in square brackets.

For example, to find all of the state names that end with a vowel:

```r
grep("[aeiou]$", state.name, value = T)
```

```
##  [1] "Alabama"        "Alaska"         "Arizona"        "California"    
##  [5] "Colorado"       "Delaware"       "Florida"        "Georgia"       
##  [9] "Hawaii"         "Idaho"          "Indiana"        "Iowa"          
## [13] "Louisiana"      "Maine"          "Minnesota"      "Mississippi"   
## [17] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
## [21] "New Hampshire"  "New Mexico"     "North Carolina" "North Dakota"  
## [25] "Ohio"           "Oklahoma"       "Pennsylvania"   "South Carolina"
## [29] "South Dakota"   "Tennessee"      "Virginia"       "West Virginia"
```

The ^ sign inside of square brackets inverts the search.

**Exercise 5:** Find state names that begin with non-vowels.

```r
grep("^[^aeiou]", state.name, value = T, ignore.case = T)
```

```
##  [1] "California"     "Colorado"       "Connecticut"    "Delaware"      
##  [5] "Florida"        "Georgia"        "Hawaii"         "Kansas"        
##  [9] "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
## [13] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"   
## [17] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
## [21] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
## [25] "North Carolina" "North Dakota"   "Pennsylvania"   "Rhode Island"  
## [29] "South Carolina" "South Dakota"   "Tennessee"      "Texas"         
## [33] "Vermont"        "Virginia"       "Washington"     "West Virginia" 
## [37] "Wisconsin"      "Wyoming"
```

You can specify ranges of characters inside square brackets:

* [0-9] : all digits
* [a-j] : the first 10 (lowercase) letters of the alphabet

There are also a number of predefined character classes.  For example:

[:punct:]
Punctuation characters:
! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.

See `?regex` for additional classes.

Perhaps confusingly these classes must themselves be placed within square brackets

```r
grep("[[:space:]]", state.name, value = T)
```

```
##  [1] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
##  [5] "North Carolina" "North Dakota"   "Rhode Island"   "South Carolina"
##  [9] "South Dakota"   "West Virginia"
```


### Specifying repeats
You can specify the number of times that a character or character class is repeated.

* ?     The preceding item is optional and will be matched at most once.
* *     The preceding item will be matched zero or more times.
* +     The preceding item will be matched one or more times.
* {n}   The preceding item is matched exactly n times.
* {n,}  The preceding item is matched n or more times.
* {n,m} The preceding item is matched at least n times, but not more than m times.

**Exercise 6:** Find the state names that have two consecutive vowels in them.


```r
grep("[aeiou]{2}", state.name, value = T)
```

```
##  [1] "California"     "Georgia"        "Hawaii"         "Illinois"      
##  [5] "Indiana"        "Louisiana"      "Maine"          "Missouri"      
##  [9] "Ohio"           "Pennsylvania"   "South Carolina" "South Dakota"  
## [13] "Tennessee"      "Virginia"       "West Virginia"
```



**Exercise 7:** Using last weeks data set, count the number of babys with the name Stacey or Stacy.  Bonus 1: count Stacey, Stacy, or Staci.  Bonus 2: list the unique set of names that start with "Stac".  The data set can be [downloaded here](http://plyr.had.co.nz/09-user/plyr-tutorial.zip)


```r
bnames <- read.csv("~/Documents/Teaching/RClub/plyr-tutorial/examples/bnames.csv", 
    as.is = T)
# check it first:
unique(grep("Stace?y", bnames$name, value = T))
```

```
## [1] "Stacy"  "Stacey"
```

```r
sum(grepl("Stace?y", bnames$name))
```

```
## [1] 228
```

```r
# Bonus1:
unique(grep("Stace?[iy]$", bnames$name, value = T))
```

```
## [1] "Stacy"  "Stacey" "Staci"
```

```r
sum(grepl("Stace?[iy]$", bnames$name))
```

```
## [1] 262
```

```r
# Bonus2:
unique(grep("Stac", bnames$name, value = T))
```

```
## [1] "Stacy"  "Stacey" "Stacia" "Stacie" "Staci"
```



### Alternates
The "|" character can be read as "or" and can be used to specify alternates.

```r
# Example: change the path below to point to 'bnames.csv' on your computer
bnames <- read.csv("~/Documents/Teaching/RClub/plyr-tutorial/examples/bnames.csv", 
    as.is = T)
bnames[grep("Stac(y|i)", bnames$name), ]
```

```
##        year   name  percent  sex
## 897    1880  Stacy 0.000051  boy
## 5925   1885  Stacy 0.000052  boy
## 11834  1891  Stacy 0.000064  boy
## 12856  1892  Stacy 0.000061  boy
## 13896  1893  Stacy 0.000058  boy
## 14847  1894  Stacy 0.000064  boy
## 18796  1898  Stacy 0.000068  boy
## 23839  1903  Stacy 0.000070  boy
## 27928  1907  Stacy 0.000063  boy
## 28610  1908  Stacy 0.000114  boy
## 31921  1911  Stacy 0.000058  boy
## 39985  1919  Stacy 0.000047  boy
## 40842  1920  Stacy 0.000059  boy
## 55957  1935  Stacy 0.000042  boy
## 56923  1936  Stacy 0.000042  boy
## 59972  1939  Stacy 0.000038  boy
## 60925  1940  Stacy 0.000040  boy
## 61883  1941  Stacy 0.000041  boy
## 63950  1943  Stacy 0.000034  boy
## 64858  1944  Stacy 0.000040  boy
## 65808  1945  Stacy 0.000044  boy
## 66934  1946  Stacy 0.000032  boy
## 67867  1947  Stacy 0.000035  boy
## 68833  1948  Stacy 0.000038  boy
## 69689  1949  Stacy 0.000055  boy
## 70677  1950  Stacy 0.000058  boy
## 71656  1951  Stacy 0.000060  boy
## 72678  1952  Stacy 0.000054  boy
## 73675  1953  Stacy 0.000056  boy
## 74638  1954  Stacy 0.000064  boy
## 75640  1955  Stacy 0.000065  boy
## 76595  1956  Stacy 0.000076  boy
## 77551  1957  Stacy 0.000089  boy
## 78502  1958  Stacy 0.000111  boy
## 79469  1959  Stacy 0.000134  boy
## 80464  1960  Stacy 0.000136  boy
## 81450  1961  Stacy 0.000150  boy
## 82398  1962  Stacy 0.000198  boy
## 83361  1963  Stacy 0.000228  boy
## 84340  1964  Stacy 0.000263  boy
## 85307  1965  Stacy 0.000319  boy
## 86284  1966  Stacy 0.000373  boy
## 87162  1967  Stacy 0.000932  boy
## 88157  1968  Stacy 0.000977  boy
## 89186  1969  Stacy 0.000816  boy
## 90211  1970  Stacy 0.000620  boy
## 91231  1971  Stacy 0.000565  boy
## 92234  1972  Stacy 0.000546  boy
## 93230  1973  Stacy 0.000567  boy
## 94241  1974  Stacy 0.000509  boy
## 95255  1975  Stacy 0.000484  boy
## 96306  1976  Stacy 0.000351  boy
## 97376  1977  Stacy 0.000254  boy
## 98428  1978  Stacy 0.000201  boy
## 99526  1979  Stacy 0.000145  boy
## 100564 1980  Stacy 0.000126  boy
## 101668 1981  Stacy 0.000090  boy
## 102753 1982  Stacy 0.000073  boy
## 103774 1983  Stacy 0.000068  boy
## 104714 1984  Stacy 0.000080  boy
## 105759 1985  Stacy 0.000071  boy
## 106767 1986  Stacy 0.000073  boy
## 107764 1987  Stacy 0.000074  boy
## 108808 1988  Stacy 0.000069  boy
## 109802 1989  Stacy 0.000074  boy
## 110818 1990  Stacy 0.000073  boy
## 111849 1991  Stacy 0.000071  boy
## 112871 1992  Stacy 0.000070  boy
## 113955 1993  Stacy 0.000062  boy
## 162922 1913 Stacia 0.000052 girl
## 165901 1916 Stacia 0.000053 girl
## 166916 1917 Stacia 0.000052 girl
## 167813 1918 Stacia 0.000065 girl
## 168953 1919 Stacia 0.000048 girl
## 198981 1949  Stacy 0.000048 girl
## 200866 1951  Stacy 0.000059 girl
## 201798 1952  Stacy 0.000068 girl
## 202665 1953  Stacy 0.000095 girl
## 203535 1954  Stacy 0.000139 girl
## 204528 1955  Stacy 0.000151 girl
## 205426 1956  Stacy 0.000223 girl
## 205975 1956 Stacie 0.000052 girl
## 206348 1957  Stacy 0.000323 girl
## 206760 1957 Stacie 0.000082 girl
## 207256 1958  Stacy 0.000558 girl
## 207710 1958 Stacie 0.000094 girl
## 208217 1959  Stacy 0.000713 girl
## 208624 1959 Stacie 0.000123 girl
## 209222 1960  Stacy 0.000699 girl
## 209556 1960 Stacie 0.000149 girl
## 210206 1961  Stacy 0.000809 girl
## 210512 1961 Stacie 0.000176 girl
## 211176 1962  Stacy 0.001098 girl
## 211471 1962 Stacie 0.000207 girl
## 211751 1962  Staci 0.000094 girl
## 212129 1963  Stacy 0.001641 girl
## 212389 1963 Stacie 0.000307 girl
## 212580 1963  Staci 0.000145 girl
## 213123 1964  Stacy 0.001768 girl
## 213404 1964 Stacie 0.000299 girl
## 213459 1964  Staci 0.000230 girl
## 213961 1964 Stacia 0.000062 girl
## 214119 1965  Stacy 0.001754 girl
## 214364 1965 Stacie 0.000340 girl
## 214410 1965  Staci 0.000282 girl
## 214851 1965 Stacia 0.000076 girl
## 215091 1966  Stacy 0.002149 girl
## 215359 1966 Stacie 0.000366 girl
## 215380 1966  Staci 0.000331 girl
## 215839 1966 Stacia 0.000081 girl
## 216074 1967  Stacy 0.002678 girl
## 216301 1967 Stacie 0.000486 girl
## 216316 1967  Staci 0.000437 girl
## 216822 1967 Stacia 0.000086 girl
## 217064 1968  Stacy 0.003152 girl
## 217252 1968 Stacie 0.000631 girl
## 217277 1968  Staci 0.000571 girl
## 217737 1968 Stacia 0.000105 girl
## 218053 1969  Stacy 0.003681 girl
## 218209 1969 Stacie 0.000853 girl
## 218264 1969  Staci 0.000624 girl
## 218668 1969 Stacia 0.000125 girl
## 219042 1970  Stacy 0.004245 girl
## 219165 1970 Stacie 0.001105 girl
## 219268 1970  Staci 0.000626 girl
## 219581 1970 Stacia 0.000167 girl
## 220032 1971  Stacy 0.005201 girl
## 220131 1971 Stacie 0.001457 girl
## 220250 1971  Staci 0.000673 girl
## 220577 1971 Stacia 0.000174 girl
## 221033 1972  Stacy 0.004717 girl
## 221159 1972 Stacie 0.001130 girl
## 221253 1972  Staci 0.000659 girl
## 221653 1972 Stacia 0.000145 girl
## 222032 1973  Stacy 0.004723 girl
## 222150 1973 Stacie 0.001182 girl
## 222224 1973  Staci 0.000723 girl
## 222650 1973 Stacia 0.000149 girl
## 223038 1974  Stacy 0.004304 girl
## 223156 1974 Stacie 0.001122 girl
## 223271 1974  Staci 0.000601 girl
## 223646 1974 Stacia 0.000151 girl
## 224034 1975  Stacy 0.004596 girl
## 224146 1975 Stacie 0.001178 girl
## 224253 1975  Staci 0.000621 girl
## 224684 1975 Stacia 0.000141 girl
## 225038 1976  Stacy 0.004152 girl
## 225151 1976 Stacie 0.001098 girl
## 225269 1976  Staci 0.000553 girl
## 225703 1976 Stacia 0.000134 girl
## 226042 1977  Stacy 0.003743 girl
## 226185 1977 Stacie 0.000904 girl
## 226288 1977  Staci 0.000511 girl
## 226633 1977 Stacia 0.000161 girl
## 227044 1978  Stacy 0.003515 girl
## 227177 1978 Stacie 0.000892 girl
## 227304 1978  Staci 0.000464 girl
## 227756 1978 Stacia 0.000124 girl
## 228043 1979  Stacy 0.003316 girl
## 228201 1979 Stacie 0.000769 girl
## 228299 1979  Staci 0.000462 girl
## 228793 1979 Stacia 0.000116 girl
## 229053 1980  Stacy 0.002843 girl
## 229222 1980 Stacie 0.000649 girl
## 229310 1980  Staci 0.000438 girl
## 229833 1980 Stacia 0.000106 girl
## 230065 1981  Stacy 0.002504 girl
## 230235 1981 Stacie 0.000594 girl
## 230363 1981  Staci 0.000362 girl
## 230887 1981 Stacia 0.000096 girl
## 231072 1982  Stacy 0.002261 girl
## 231280 1982 Stacie 0.000479 girl
## 231354 1982  Staci 0.000365 girl
## 231891 1982 Stacia 0.000095 girl
## 232061 1983  Stacy 0.002615 girl
## 232261 1983 Stacie 0.000511 girl
## 232326 1983  Staci 0.000398 girl
## 232836 1983 Stacia 0.000103 girl
## 233067 1984  Stacy 0.002466 girl
## 233253 1984 Stacie 0.000547 girl
## 233327 1984  Staci 0.000399 girl
## 233905 1984 Stacia 0.000092 girl
## 234067 1985  Stacy 0.002228 girl
## 234282 1985 Stacie 0.000479 girl
## 234323 1985  Staci 0.000399 girl
## 234852 1985 Stacia 0.000103 girl
## 235087 1986  Stacy 0.001747 girl
## 235301 1986 Stacie 0.000440 girl
## 235369 1986  Staci 0.000346 girl
## 235835 1986 Stacia 0.000108 girl
## 236101 1987  Stacy 0.001466 girl
## 236330 1987 Stacie 0.000396 girl
## 236338 1987  Staci 0.000388 girl
## 237126 1988  Stacy 0.001180 girl
## 237323 1988  Staci 0.000401 girl
## 237340 1988 Stacie 0.000374 girl
## 237977 1988 Stacia 0.000089 girl
## 238152 1989  Stacy 0.000947 girl
## 238382 1989  Staci 0.000332 girl
## 238399 1989 Stacie 0.000311 girl
## 239173 1990  Stacy 0.000814 girl
## 239420 1990 Stacie 0.000294 girl
## 239439 1990  Staci 0.000278 girl
## 240212 1991  Stacy 0.000693 girl
## 240479 1991  Staci 0.000250 girl
## 240536 1991 Stacie 0.000215 girl
## 241232 1992  Stacy 0.000593 girl
## 241526 1992 Stacie 0.000225 girl
## 241537 1992  Staci 0.000219 girl
## 242288 1993  Stacy 0.000485 girl
## 242577 1993 Stacie 0.000208 girl
## 242636 1993  Staci 0.000179 girl
## 243319 1994  Stacy 0.000436 girl
## 243672 1994 Stacie 0.000163 girl
## 243799 1994  Staci 0.000130 girl
## 244389 1995  Stacy 0.000355 girl
## 244805 1995 Stacie 0.000129 girl
## 244959 1995  Staci 0.000103 girl
## 245420 1996  Stacy 0.000316 girl
## 245882 1996 Stacie 0.000117 girl
## 246471 1997  Stacy 0.000279 girl
## 247517 1998  Stacy 0.000253 girl
## 248554 1999  Stacy 0.000234 girl
## 249597 2000  Stacy 0.000212 girl
## 250603 2001  Stacy 0.000211 girl
## 251660 2002  Stacy 0.000195 girl
## 252663 2003  Stacy 0.000199 girl
## 253632 2004  Stacy 0.000214 girl
## 254650 2005  Stacy 0.000211 girl
## 255674 2006  Stacy 0.000202 girl
## 256691 2007  Stacy 0.000199 girl
## 257725 2008  Stacy 0.000198 girl
```


**Exercise 8:** Pull out the names "Jonathan" "Jonnie" and "Johnathon" but not other Jon names.  Bonus: Only have Jon listed once in your search string.

```r
unique(grep("^(Johnathon)|(Jon(nie)|(athon))", bnames$name, value = T))
```

```
## [1] "Jonnie"    "Jonathon"  "Johnathon"
```

```r

## note that this was harder than intended.  I meant to ask for 'Jonathan'
## 'Jonnie' and 'Jonathon'
unique(grep("^Jon((nie)|(ath[ao]n))", bnames$name, value = T))
```

```
## [1] "Jonathan" "Jonnie"   "Jonathon"
```



### Escapes
What if you want to match a "." or other special character?  The following characters have special meaning in regular expressions: ". \ | ( ) [ { ^ $ * + ?" and if you want to search for them you have to do something special.

```r
# say you want all Chrom one ILs
ILs <- c("IL.1.1", "IL.2.2", "IL.1.3", "IL.2.1", "IL.11.1", "IL.11.3", "IL.12.1", 
    "IL.12.2")
# the following seems logical at first:
grep("IL.1.", ILs, value = T)
```

```
## [1] "IL.1.1"  "IL.1.3"  "IL.11.1" "IL.11.3" "IL.12.1" "IL.12.2"
```

What happened?  Remember that "." matches any character.  We need to tell grep that the "." is just a regular character, not a wildcard. To do this we "escape" it by preceding it with a "\".  However, since "\" itself is a special character it must also be escaped. So we use two backslashes. 

```r
grep("IL\\.1\\.", ILs, value = T)
```

```
## [1] "IL.1.1" "IL.1.3"
```

```r
# an alternative, if you don't need any regex functionality is to use the
# argument 'fixed=T'
grep("IL.1.", ILs, value = T, fixed = T)
```

```
## [1] "IL.1.1" "IL.1.3"
```


### Back references
One of the powerful tools in regexps is the ability to refer back to a previous match.  The item that you want to refer back to is enclosed in parentheses.  You backreference with a backslash and a digit.  A "1" would indicate the first group enclosed in a parentheses, a "2" would refer to the second group, etc.

Suppose we want to find all state names that have letters repeated twice in a row.

```r
grep("(.)\\1", state.name, value = T)
```

```
## [1] "Connecticut"   "Hawaii"        "Illinois"      "Massachusetts"
## [5] "Minnesota"     "Mississippi"   "Missouri"      "Pennsylvania" 
## [9] "Tennessee"
```

```r
# the '.' matches any character.  Enclosing that in parentheses designates
# it as an item that we want to refer back to.  The \\1 refers back to
# it.
```

**Exercise 9:** Find all state names that have two vowels repeated.

```r
grep("([aeiou])\\1", state.name, value = T, ignore.case = T)
```

```
## [1] "Hawaii"    "Tennessee"
```



I find back references particularly helpful in combination with sub(), because you can use them in your replacement string.

**Exercise 10:** For all two-worded state names reverse the order of the two words and add a comma between the words.  ("North Carolina" should become "Carolina, North")

```r
sub("([[:alpha:]]+) ([[:alpha:]]+)", "\\2, \\1", state.name)
```

```
##  [1] "Alabama"         "Alaska"          "Arizona"        
##  [4] "Arkansas"        "California"      "Colorado"       
##  [7] "Connecticut"     "Delaware"        "Florida"        
## [10] "Georgia"         "Hawaii"          "Idaho"          
## [13] "Illinois"        "Indiana"         "Iowa"           
## [16] "Kansas"          "Kentucky"        "Louisiana"      
## [19] "Maine"           "Maryland"        "Massachusetts"  
## [22] "Michigan"        "Minnesota"       "Mississippi"    
## [25] "Missouri"        "Montana"         "Nebraska"       
## [28] "Nevada"          "Hampshire, New"  "Jersey, New"    
## [31] "Mexico, New"     "York, New"       "Carolina, North"
## [34] "Dakota, North"   "Ohio"            "Oklahoma"       
## [37] "Oregon"          "Pennsylvania"    "Island, Rhode"  
## [40] "Carolina, South" "Dakota, South"   "Tennessee"      
## [43] "Texas"           "Utah"            "Vermont"        
## [46] "Virginia"        "Washington"      "Virginia, West" 
## [49] "Wisconsin"       "Wyoming"
```



**Exercise 11:** For all two-worded state names, abbreviate the first word to be the first letter, followed by a "." ("North Carolina" becomes "N. Carolina").

```r
sub("^(\\w)\\w+\\s", "\\1. ", state.name)
```

```
##  [1] "Alabama"       "Alaska"        "Arizona"       "Arkansas"     
##  [5] "California"    "Colorado"      "Connecticut"   "Delaware"     
##  [9] "Florida"       "Georgia"       "Hawaii"        "Idaho"        
## [13] "Illinois"      "Indiana"       "Iowa"          "Kansas"       
## [17] "Kentucky"      "Louisiana"     "Maine"         "Maryland"     
## [21] "Massachusetts" "Michigan"      "Minnesota"     "Mississippi"  
## [25] "Missouri"      "Montana"       "Nebraska"      "Nevada"       
## [29] "N. Hampshire"  "N. Jersey"     "N. Mexico"     "N. York"      
## [33] "N. Carolina"   "N. Dakota"     "Ohio"          "Oklahoma"     
## [37] "Oregon"        "Pennsylvania"  "R. Island"     "S. Carolina"  
## [41] "S. Dakota"     "Tennessee"     "Texas"         "Utah"         
## [45] "Vermont"       "Virginia"      "Washington"    "W. Virginia"  
## [49] "Wisconsin"     "Wyoming"
```

