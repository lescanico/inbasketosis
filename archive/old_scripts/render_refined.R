#!/usr/bin/env Rscript
# render_refined.R
# Script to render the refined Epic In-Basket Analysis report

# Load only essential packages
suppressMessages({
  library(readxl)
  library(knitr)
})

# Check if Quarto is available
if (!requireNamespace("quarto", quietly = TRUE)) {
  cat("Quarto package not found. Attempting to install...\n")
  tryCatch({
    install.packages("quarto", repos = "https://cloud.r-project.org")
    library(quarto)
  }, error = function(e) {
    cat("Error installing Quarto:", e$message, "\n")
    cat("Please install Quarto manually: https://quarto.org/docs/get-started/\n")
    stop("Quarto package is required but could not be installed.")
  })
}

# Set working directory
cat("Working directory:", getwd(), "\n")

# Check if files exist
data_file <- "PEP Data - Lescano N 07_2024-06_2025 v2.xlsx"
qmd_file <- "epic_inbasket_analysis_refined.qmd"

if (!file.exists(data_file)) {
  stop("Data file not found: ", data_file)
}

if (!file.exists(qmd_file)) {
  stop("Quarto document not found: ", qmd_file)
}

# Render the document
cat("Rendering Epic In-Basket Analysis report (refined version)...\n")
cat("Data file:", data_file, "\n")
cat("Quarto document:", qmd_file, "\n")

# Render with progress and error handling
result <- tryCatch({
  cat("Attempting to render HTML output...\n")
  quarto::quarto_render(
    input = qmd_file,
    output_format = "html",
    quiet = FALSE
  )
  cat("HTML report rendered successfully!\n")
  cat("Output: epic_inbasket_analysis_refined.html\n")
  
}, error = function(e) {
  cat("Error rendering report:", e$message, "\n")
  cat("This might be due to missing system dependencies.\n")
  cat("Please check the error message and install any missing dependencies.\n")
  stop(e)
})

# Check if output file was created
html_output <- "epic_inbasket_analysis_refined.html"

if (file.exists(html_output)) {
  file_size <- file.info(html_output)$size
  cat("HTML output file size:", round(file_size / 1024 / 1024, 2), "MB\n")
} else {
  cat("Warning: HTML output file not found\n")
}

cat("Render complete!\n")
cat("Check the output file in the current directory.\n")
