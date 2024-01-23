createCsvTable <- function(path) { 
  library(data.table)
  x = readLines(path)
  y = gsub('","', "','", x) # replace double quotes for each field
  y = gsub('^"|"$', "'", y) # replace trailing and leading double quotes
  z = paste(y, collapse='\n') # turn it back into a table for fread to read
  features = fread(z, quote="'")
  library(knitr)
  library(kableExtra)
  kable(head(features)) %>%
    kable_styling(bootstrap_options = "bordered", latex_options = "striped", full_width = FALSE)
}