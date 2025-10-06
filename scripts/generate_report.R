#!/usr/bin/env Rscript
# Generate Final Report
# Companion script to epic_inbasket_pipeline.R
# Generates the final PDF report from processed data

# Load required packages
suppressMessages({
  library(rmarkdown)
  library(knitr)
  library(quarto)
})

# Set working directory
setwd(getwd())

# Check if pipeline has been run
if (!file.exists("processed_time_data.csv")) {
  cat("Error: Pipeline data not found. Please run epic_inbasket_pipeline.R first.\n")
  quit(status = 1)
}

# Load processed data
cat("Loading processed data...\n")
time_data <- read.csv("processed_time_data.csv")
after_hours_data <- read.csv("processed_after_hours_data.csv")
risk_data <- read.csv("processed_risk_data.csv")
provider_analysis <- read.csv("processed_provider_analysis.csv")
summary_stats <- readRDS("summary_statistics.rds")

# Generate final PDF report
cat("Generating final PDF report...\n")

# Use pandoc to convert markdown to PDF
system("pandoc Project_Summary.md -o Project_Summary_Final_Report.pdf --pdf-engine=pdflatex --toc --toc-depth=3 --number-sections --variable=geometry:margin=1in --variable=documentclass:article --highlight-style=tango --variable=colorlinks:true --variable=linkcolor:blue --variable=urlcolor:blue --variable=linestretch:1.15 --variable=indent:false --variable=fontfamily:times --variable=mainfont:Times --variable=sansfont:Arial --variable=monofont:Courier --variable=numbersections:true --variable=secnumdepth:1 --variable=titlepage:true --variable=toc:true --variable=toc-depth:3 --variable=section-titles:true")

cat("Final report generated: Project_Summary_Final_Report.pdf\n")
cat("Report generation completed successfully!\n")
