createCsvTable <- function(path, display_rows = 15) { 
  library(data.table)
  library(knitr)
  library(kableExtra)
  
  x = readLines(path)
  y = gsub('","', "','", x) # replace double quotes for each field
  y = gsub('^"|"$', "'", y) # replace trailing and leading double quotes
  z = paste(y, collapse='\n') # turn it back into a table for fread to read
  
  features = fread(z, quote="'")
  
  kable(head(features, display_rows)) %>%
    kable_styling(bootstrap_options = "bordered", latex_options = "striped", full_width = FALSE)
}

createCsvTableTwo <- function(path, display_rows = 15) { 
  library(data.table)
  library(knitr)
  library(kableExtra)
  
  features <- fread(path, quote = "\"")
  kable(head(features, display_rows), format = "html") %>%
    kable_styling(bootstrap_options = "bordered", latex_options = "striped", full_width = FALSE)
}

printJson <- function(path) { 
  library(jsonlite)
  file_content <- readLines(path)
  json_content <- toJSON(file_content, pretty = TRUE)
  cat("```", file_content, "\n```", sep = "\n")
}
