setwd("~/Documents/Teaching/RClub/website/")
jekyll.knit <- function(input) {
    library(knitr)
    rel.path = substr(input, 5, nchar(input) - 4)
    output = paste("_posts/", rel.path, ".md", sep = "")
    knit(input = input, output = output)
    system(paste("perl -pi -e 's|figure/|{{ site.figurl }}/|gi'", output, sep = " "))
}
# .Rmd files in _rmd directory
# Usage example:
# jekyll.knit("_rmd/2013-XX-XX-post-name.Rmd")
 jekyll.knit("_rmd/2013-05-01-Text-Searches-Regular-Expressions-Answers.Rmd")

