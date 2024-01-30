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

createCsvGraph <- function(path, title_name, x_name, y_name, y_value, line_color) {
  library(ggplot2)
  
  data <- read.csv(path)
  ggplot(data, aes(x = 1:nrow(data), y = !!as.name(y_value), color = line_color)) +
    geom_line() +
    labs(title = title_name, x = x_name, y = y_name) +
    scale_color_manual(values = line_color) +  # Set the line color manually
    theme(legend.position = "none")  # Remove the legend for color
}

createImageGalery <- function(path) {
  library(shiny)
  
  image_files <- list.files(path, pattern = "\\.(jpg|jpeg|png|gif)$", full.names = TRUE)
  
  # Generate HTML code for the table dynamically
  htmlTable <- "<table id='table-gallery' align='center' style='width: 100%; max-width: 1200px; border-collapse: collapse; border: 3px solid grey;'>"
  for (i in seq_along(image_files)) {
    if ((i - 1) %% 3 == 0) {
      htmlTable <- paste0(htmlTable, "\n<tr'>")
    }
    htmlTable <- paste0(
      htmlTable,"\n<td id='cell", i, "' style='text-align: center; vertical-align: middle; border: 1px solid grey; padding: 5px;'><img src='", image_files[i], "' style='width: 260px; max-width: 100%; height: auto; cursor: pointer;' onclick='openPopup(\"", image_files[i], "\")' /></td>"
    )
    if (i %% 3 == 0 || i == length(image_files)) {
      htmlTable <- paste0(htmlTable, "\n</tr>")
    }
  }
  htmlTable <- paste0(htmlTable, "\n</table>")
  
  # Create JavaScript code for opening popup
  jsCode <- "
    <script>
      function openPopup(imageSrc) {
        var popupWindow = window.open('', 'ImagePopup', '');
        popupWindow.document.write('<html><head><title>Image Popup</title><style>body { margin: 0; display: flex; align-items: center; justify-content: center; height: 100vh; }</style></head><body><img src=\"' + imageSrc + '\" style=\"max-width: 100%; max-height: 100%;\" onclick=\"window.close();\"></body></html>');
        popupWindow.document.close();
      }
    </script>
  "
  
  # Combine HTML and JavaScript code
  combinedCode <- paste0(jsCode, htmlTable)
  
  # Create Shiny tags$div with HTML code
  shiny::tags$div(
    HTML(combinedCode)
  )
}
