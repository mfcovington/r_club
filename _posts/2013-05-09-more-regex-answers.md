---
title:      More Regex Solutions...
layout:     post
categories: solutions
comments:   true
duedate:
related:    2013-05-02-more-regex
author:     Mike Covington
---


# Exercise 1: Extracting important info from filenames

We need to extract IL name, sun/shade treatment, and replicate number from these filenames:


```r
filename.1 <- "a IL-9.2.4 crazy SH file rep1 name"
filename.2 <- "anotherIL-12.4sillySUfilerep20name"
```


A good approach is to focus on what we want to capture rather than building our regex pattern based on the junk we are trying to avoid. This helps the substitution work correctly on a broader set of filenames. In the regex pattern below, remember that the `(?:` in `(?:\\d|\\.)` makes the parentheses into a 'non-capturing' pair of parentheses that doesn't create a back-reference.


```r
pattern     <- "^.*(IL-(?:\\d|\\.)+).*(S[HU]).*(rep\\d+).*$"
replacement <- "\\1,\\2,\\3"

extract <- sub(pattern, replacement, c(filename.1, filename.2))
extract
```

```
## [1] "IL-9.2.4,SH,rep1" "IL-12.4,SU,rep20"
```


Another regex pattern that also matches:


```r
pattern <- "^.*(IL-[0-9.]+).*(SH|SU).*(rep[0-9]+).*$"
sub(pattern, replacement, c(filename.1, filename.2))
```

```
## [1] "IL-9.2.4,SH,rep1" "IL-12.4,SU,rep20"
```


Next, we need to split the comma-delimited string at every comma:


```r
strsplit(extract, ',')
```

```
## [[1]]
## [1] "IL-9.2.4" "SH"       "rep1"    
## 
## [[2]]
## [1] "IL-12.4" "SU"      "rep20"
```


# Exercise 2: Character conversions

A simple two-step process will convert state names such that All vOwEls ArE uppErcAsE And cOnsOnAnts ArE lOwErcAsE. We can start by converting the names to all lowercase. Then we just need to swap lowercase vowels for their uppercase counterparts.


```r
data(state)
state.lc <- tolower(state.name)
head(state.lc)
```

```
## [1] "alabama"    "alaska"     "arizona"    "arkansas"   "california"
## [6] "colorado"
```

```r

chartr("aeiou", "AEIOU", state.lc)
```

```
##  [1] "AlAbAmA"        "AlAskA"         "ArIzOnA"        "ArkAnsAs"      
##  [5] "cAlIfOrnIA"     "cOlOrAdO"       "cOnnEctIcUt"    "dElAwArE"      
##  [9] "flOrIdA"        "gEOrgIA"        "hAwAII"         "IdAhO"         
## [13] "IllInOIs"       "IndIAnA"        "IOwA"           "kAnsAs"        
## [17] "kEntUcky"       "lOUIsIAnA"      "mAInE"          "mArylAnd"      
## [21] "mAssAchUsEtts"  "mIchIgAn"       "mInnEsOtA"      "mIssIssIppI"   
## [25] "mIssOUrI"       "mOntAnA"        "nEbrAskA"       "nEvAdA"        
## [29] "nEw hAmpshIrE"  "nEw jErsEy"     "nEw mExIcO"     "nEw yOrk"      
## [33] "nOrth cArOlInA" "nOrth dAkOtA"   "OhIO"           "OklAhOmA"      
## [37] "OrEgOn"         "pEnnsylvAnIA"   "rhOdE IslAnd"   "sOUth cArOlInA"
## [41] "sOUth dAkOtA"   "tEnnEssEE"      "tExAs"          "UtAh"          
## [45] "vErmOnt"        "vIrgInIA"       "wAshIngtOn"     "wEst vIrgInIA" 
## [49] "wIscOnsIn"      "wyOmIng"
```





