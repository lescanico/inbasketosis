#!/usr/bin/env Rscript
# render_report.R
# Script to render the Epic In-Basket Analysis report

# Ensure required libraries are installed and loaded
required_packages <- c(
  "tidyverse", "readxl", "here", "knitr", "kableExtra",
  "plotly", "DT", "scales", "patchwork", "ggthemes",
  "corrplot", "psych", "broom", "gt"
)

install_if_missing <- function(pkgs) {
  to_install <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
  if (length(to_install) > 0) {
    cat("Installing missing packages:", paste(to_install, collapse = ", "), "\n")
    tryCatch({
      install.packages(to_install, repos = "https://cloud.r-project.org", dependencies = TRUE)
    }, error = function(e) {
      cat("Warning: Some packages failed to install:", e$message, "\n")
      cat("You may need to install them manually or check system dependencies.\n")
    })
  }
}

install_if_missing(required_packages)

# Load packages with error handling
load_packages <- function(pkgs) {
  failed_packages <- c()
  for (pkg in pkgs) {
    tryCatch({
      suppressMessages(library(pkg, character.only = TRUE))
    }, error = function(e) {
      failed_packages <<- c(failed_packages, pkg)
      cat("Warning: Failed to load package", pkg, ":", e$message, "\n")
    })
  }
  if (length(failed_packages) > 0) {
    cat("Failed to load packages:", paste(failed_packages, collapse = ", "), "\n")
    cat("The report may not render correctly without these packages.\n")
  }
}

load_packages(required_packages)

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

# Set working directory to script location
if (requireNamespace("here", quietly = TRUE)) {
  setwd(here::here())
} else {
  # Fallback if here package is not available
  # Get the directory where this script is located
  script_dir <- dirname(normalizePath(sys.frame(1)$ofile))
  setwd(script_dir)
  cat("Working directory set to:", getwd(), "\n")
}

# Check if data file exists
data_file <- "PEP Data - Lescano N 07_2024-06_2025 v2.xlsx"
if (!file.exists(data_file)) {
  stop("Data file not found: ", data_file)
}

# Check if Quarto document exists
qmd_file <- "epic_inbasket_analysis.qmd"
if (!file.exists(qmd_file)) {
  stop("Quarto document not found: ", qmd_file)
}

# Render the document
cat("Rendering Epic In-Basket Analysis report...\n")
cat("Data file:", data_file, "\n")
cat("Quarto document:", qmd_file, "\n")
cat("Working directory:", getwd(), "\n")

# Render with progress and error handling
result <- tryCatch({
  # Try HTML output first
  cat("Attempting to render HTML output...\n")
  quarto::quarto_render(
    input = qmd_file,
    output_format = "html",
    quiet = FALSE
  )
  cat("HTML report rendered successfully!\n")
  cat("Output: epic_inbasket_analysis.html\n")
  
  # Try PDF output if HTML succeeded
  tryCatch({
    cat("Attempting to render PDF output...\n")
    quarto::quarto_render(
      input = qmd_file,
      output_format = "pdf",
      quiet = FALSE
    )
    cat("PDF report rendered successfully!\n")
    cat("Output: epic_inbasket_analysis.pdf\n")
  }, error = function(e) {
    cat("Warning: PDF rendering failed:", e$message, "\n")
    cat("HTML output is still available.\n")
  })
  
}, error = function(e) {
  cat("Error rendering report:", e$message, "\n")
  cat("This might be due to missing packages or system dependencies.\n")
  cat("Please check the error message and install any missing dependencies.\n")
  stop(e)
})

# Check if output files were created
html_output <- "epic_inbasket_analysis.html"
pdf_output <- "epic_inbasket_analysis.pdf"

if (file.exists(html_output)) {
  file_size <- file.info(html_output)$size
  cat("HTML output file size:", round(file_size / 1024 / 1024, 2), "MB\n")
} else {
  cat("Warning: HTML output file not found\n")
}

if (file.exists(pdf_output)) {
  file_size <- file.info(pdf_output)$size
  cat("PDF output file size:", round(file_size / 1024 / 1024, 2), "MB\n")
} else {
  cat("Note: PDF output file not created (this is normal if PDF rendering failed)\n")
}

cat("Render complete!\n")
cat("Check the output files in the current directory.\n")

