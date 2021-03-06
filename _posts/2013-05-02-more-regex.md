---
title:      More Regular Expressions...
layout:     post
categories: exercises
comments:   true
duedate:    2013-05-09
related:    2013-05-09-more-regex-answers
author:     Mike Covington
---

# Exercise 1: Extracting important info from filenames

You have a dataset and need to extract metadata for IL name, sun/shade treatment, and replicate number from the filenames:


```r
filename.1 <- "a IL-9.2.4 crazy SH file rep1 name"
filename.2 <- "anotherIL-12.4sillySUfilerep20name"
```


You'd like to convert the filenames into `IL-9.2.4,SH,rep1` and `IL-12.4,SU,rep20`, which can easily be split on the delimiting comma with `strsplit()`.

Extract this metadata using `sub()` followed by `strsplit` to split the resulting string. You will need to make use of three capture groups.

# Exercise 2: Character conversions

In last week's exercise #2, you were asked to replace all of the "i"s in state names with "y"s. Using `gsub("i", "y", state.name, ignore.case = T)` accomplished that task, but resulted in state names beginning with lower case "y"s.

There is another (non-regex) function that can be used instead: `chartr()` does character translations from one characer to another. To convert all "i"s to "y"s and all "I"s to "Y"s in the state names, we can use the following:


```r
data(state)
chartr("Ii", "Yy", state.name)
```

```
##  [1] "Alabama"        "Alaska"         "Aryzona"        "Arkansas"      
##  [5] "Calyfornya"     "Colorado"       "Connectycut"    "Delaware"      
##  [9] "Floryda"        "Georgya"        "Hawayy"         "Ydaho"         
## [13] "Yllynoys"       "Yndyana"        "Yowa"           "Kansas"        
## [17] "Kentucky"       "Louysyana"      "Mayne"          "Maryland"      
## [21] "Massachusetts"  "Mychygan"       "Mynnesota"      "Myssyssyppy"   
## [25] "Myssoury"       "Montana"        "Nebraska"       "Nevada"        
## [29] "New Hampshyre"  "New Jersey"     "New Mexyco"     "New York"      
## [33] "North Carolyna" "North Dakota"   "Ohyo"           "Oklahoma"      
## [37] "Oregon"         "Pennsylvanya"   "Rhode Ysland"   "South Carolyna"
## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
## [45] "Vermont"        "Vyrgynya"       "Washyngton"     "West Vyrgynya" 
## [49] "Wysconsyn"      "Wyomyng"
```


Sidenote: two other non-regex functions used to convert text are `tolower()` and `toupper()`:


```r
x <- "Oh my.... Look over there!"
tolower(x)
```

```
## [1] "oh my.... look over there!"
```

```r
toupper(x)
```

```
## [1] "OH MY.... LOOK OVER THERE!"
```


**Your task**: You want to look cool, so use two of these functions to convert the state names such that all vowells are uppercase and all consonants are lower case.




