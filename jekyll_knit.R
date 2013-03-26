setwd("~/git.repos/r_club")
jekyll.knit <- function(input) {
    library(knitr)
    rel.path = substr(input, 5, nchar(input) - 4)
    output = paste("_posts/", rel.path, ".md", sep = "")
    knit(input = input, output = output)
}
# .Rmd files in _rmd directory
# Usage example:
# jekyll.knit("_rmd/2013-XX-XX-post-name.Rmd")
