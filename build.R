rstudioapi::restartSession(command = "print('Welcome back!')")

# if (!requireNamespace("rmarkdown", quietly = TRUE)) {
#   install.packages("rmarkdown")
# }
# library(rmarkdown)
# 
# rmarkdown::clean_site(input = "webBuild", preview = FALSE)
# rmarkdown::render_site(input = "webBuild", output_format = "all", envir = parent.frame(), quiet = FALSE, encoding = "UTF-8")

if (!requireNamespace("rstudioapi", quietly = TRUE)) {
  install.packages("rstudioapi")
}
if (!requireNamespace("servr", quietly = TRUE)) {
  install.packages("servr")
}
if (!requireNamespace("here", quietly = TRUE)) {
  install.packages("here")
}

library(rstudioapi)
library(servr)
library(here)

input_dir <- "webBuild"
output_dir <- "docs"
json_crack_dir <- ".next"

relative_path <- paste(input_dir, json_crack_dir, sep = "/")
full_path <- here(relative_path)
relative_path_new <- paste(output_dir, sep = "/")
full_path_new <- here(relative_path_new)

if (!file.exists(full_path)) {
  dir.create(full_path, recursive = TRUE)
  print(paste("Directory", full_path, "created"))
}

if (!file.exists(full_path_new)) {
  dir.create(full_path_new, recursive = TRUE)
  print(paste("Directory", full_path_new, "created"))
}

file.copy(from = full_path, to = full_path_new, recursive = TRUE)
message <- paste("Copying", relative_path, "to", relative_path_new)
print(message)
print(getwd())

# Set the working directory to 'docs'
# setwd(output_dir)

# Start a simple web server
full_path_new <- gsub("\"", "", full_path_new)
command <- paste0('Rscript -e "servr::httd(dir = \'', full_path_new, '\', port = 9005, daemon = FALSE)"')
print(command)
# system(command)
# terminalExecute(command)

# servr::httd(dir = "./docs", port = 9005, daemon = TRUE)
# Construct the URL to the index.html file
index_html_url <- paste0("http://127.0.0.1:9005/", "index.html")

# Load the rstudioapi package
if (requireNamespace("rstudioapi", quietly = TRUE)) {
  
  # Check if running in RStudio
  if (rstudioapi::isAvailable()) {
    cat("RStudio is running.\n")
    
    # Check if there is an active RStudio session
    if (rstudioapi::isRunningRStudio()) {
      cat("An RStudio session is active.\n")
    } else {
      cat("No active RStudio session.\n")
    }
    
  } else {
    cat("Not running in RStudio.\n")
  }
  
} else {
  cat("rstudioapi package is not installed.\n")
}

# Open the site in the RStudio Viewer
Sys.sleep(2)
# rstudioapi::verifyAvailable()
if (rstudioapi::hasFun("viewer")) {
  rstudioapi::callFun("viewer", index_html_url)
} else {
  browseURL(index_html_url)
}
