---
title: Homework--Data Types and Reshape
layout: post
categories: homework
comments: true
duedate: 2013-04-04
---

R Homework for April 4, 2013
========================================================

## Section 1: Data Types
Questions 1 to 6 refer to the file [ELF3s\_bolting\_Rclub.csv]({{ site.baseurl }}/downloads/ELF3s_bolting_Rclub.csv). Import it now.

### Q1
What data types are represented in each column?

### Q2
a) Are there any columns that you think have the wrong data type?  

b) Which ones? 

c) Why?

### Q3
How would you change the columns to their correct types?

### Q4
Are there any obvious mistakes in this data frame beyond what you might have found in answering Q3?

### Q5
Make the "Sha" genotype the reference level for the genotype column

### Q6
Change the order of levels in "trasformation" to be Sh1, Sh2, Sh3, Ba1, Ba3

## Section 2: Reshape
The remaining questions deal with the *reshape* package and the tomato dataset.

* Read my post on reshape [on the Rclub website](http://mfcovington.github.com/r_club/resources/2013/03/28/Reshape/)
* Additional information on reshape is in section 9.2 of the ggplot book
* import the standard tomato data set.

### Q7
What are the id variables and measure variables in the Tomato data set?

### Q8
Subset the tomato data set to keep the int1-int4 measurements and the relevant metadata.

### Q9
Without melting or casting your new data frame, calculate the mean of each internode. *Hint: use `apply()`*

### Q10
Melt the new data frame.

### Q11
Use cast to obtain the mean for each internode.

### Q12
Use cast to obtain the mean for each internode for each species.

### Q13
Use cast to obtain the mean for each internode for each species under each treatment.

### Q14
Create a boxplot for each combination of species, internode, and treatment.
