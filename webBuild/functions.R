printTxt <- function(path) { 
  file_content = readLines(path)
  cat( file_content, sep = "\n")
}

createCsvTable <- function(path, display_rows = 100) { 
  library(data.table)
  library(knitr)
  library(kableExtra)
  
  table_color = "#158CBA"
  
  # Read CSV file
  file_content <- fread(path, quote = "\"")
  
  # Create HTML table with kable
  tbl <- kable(head(file_content, display_rows), format = "html")
  
  # Identify rows with empty cells
  empty_rows <- apply(file_content, 1, function(row) all(row == "" | row == " "))
  
  # Apply styling to make the first row cells grey with white text
  tbl <- tbl %>%
    kable_styling(bootstrap_options = "bordered", latex_options = "striped", full_width = FALSE) %>%
    row_spec(0, background = table_color, color = "white") %>%
    row_spec(which(empty_rows), background = table_color)
  
  return(tbl)
}

printJson <- function(path) { 
  library(jsonlite)
  file_content <- readLines(path)
  json_content <- toJSON(file_content, pretty = TRUE)
  cat("```", file_content, "\n```", sep = "\n")
}
