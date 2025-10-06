#!/usr/bin/env Rscript
# Complete Epic In-Basket Analysis
# Master script that runs the entire pipeline
# Author: Nicolas Lescano, MD

cat("==========================================\n")
cat("EPIC IN-BASKET ANALYSIS PIPELINE\n")
cat("==========================================\n")
cat("Starting complete analysis...\n\n")

# Step 1: Run data processing and analysis pipeline
cat("Step 1: Running data processing pipeline...\n")
source("epic_inbasket_pipeline.R")

# Step 2: Generate figures (if not already done)
cat("\nStep 2: Generating figures...\n")
if (!file.exists("Figure1_Provider_Workload_Distribution.png")) {
  cat("Figures not found. Running figure generation...\n")
  source("create_single_plot_figures.R")
} else {
  cat("Figures already exist. Skipping figure generation.\n")
}

# Step 3: Generate final report
cat("\nStep 3: Generating final report...\n")
source("generate_report.R")

# Step 4: Clean up temporary files (optional)
cat("\nStep 4: Cleaning up...\n")
temp_files <- c("processed_time_data.csv", "processed_after_hours_data.csv", 
                "processed_risk_data.csv", "processed_provider_analysis.csv", 
                "summary_statistics.rds")

for (file in temp_files) {
  if (file.exists(file)) {
    cat("Keeping", file, "for reference\n")
  }
}

cat("\n==========================================\n")
cat("ANALYSIS COMPLETED SUCCESSFULLY!\n")
cat("==========================================\n")
cat("Final outputs:\n")
cat("- Project_Summary_Final_Report.pdf\n")
cat("- Figure1_Provider_Workload_Distribution.png\n")
cat("- Figure2_After_Hours_Work_Pattern.png\n")
cat("- Figure3_Risk_Stratification.png\n")
cat("- Table1_Descriptive_Statistics.csv\n")
cat("- Table2_Risk_Stratification.csv\n")
cat("\nAll analysis files are ready for review.\n")
