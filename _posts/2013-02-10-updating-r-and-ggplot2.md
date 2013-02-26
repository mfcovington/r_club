---
title: Updating R and ggplot2
layout: post
categories: resources
comments: true
duedate:
---

# Check your current version of R and ggplot2

Run the following:

```r
library(ggplot2)
sessionInfo()
```

The output should look something like this:

    R version 2.15.2 (2012-10-26)
    Platform: x86_64-apple-darwin9.8.0/x86_64 (64-bit)

    locale:
    [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base

    other attached packages:
    [1] ggplot2_0.9.3

    loaded via a namespace (and not attached):
     [1] colorspace_1.2-1   dichromat_2.0-0    digest_0.6.2       grid_2.15.2        gtable_0.1.2       labeling_0.1       MASS_7.3-23        munsell_0.4
     [9] plyr_1.8           proto_0.3-10       RColorBrewer_1.0-5 reshape2_1.2.2     scales_0.2.3       stringr_0.6.2

As of February 10, 2013, the current version of R is `2.15.2` and the current version of ggplot is `ggplot2_0.9.3` (found under 'other attached packages').

If you have the most recent version of R, but your ggplot2 is somehow out of date, run: `update.packages("ggplot2")`. (Or if you don't have ggplot2 installed, run `install.packages("ggplot2")`)

If both R and ggplot2 are old, first install the current version of R and then update your packages.

# Installing R

1. Go to <http://cran.r-project.org/>
- Install the current version of R by clicking the the appropriate "Download R for[insert your OS here]" and following the prompts

# Updating your R packages

1. Open R (If you use RStudio, open the actual R program, not the RStudio interface)
- In your menus, navigate to Packages & Data / Package Installer (or, in OS X, press `alt+cmd+i`)
- Select a repository [CRAN (binaries), BioConductor (binaries), etc.]
- Click 'Get List'
- Click magnifying glass icon next to Package Search box
    - In drop-down menu, click 'Select packages from R 2.XX' (should be the version from which you just updated)
- Click 'install dependencies' checkbox
- Click 'Install Selected' button
- Depending on how many packages you have installed (and how many dependencies each has), you may want to go eat a sammich
- Go back to step 2 and repeat for other repositories (this is only necessary if you've manually added repositories, such as when installing BioConductor)

If you had BioConductor installed, running the following might update some packages that weren't updated with the previous approach:

```r
source("http://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")
```
