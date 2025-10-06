#!/usr/bin/env Rscript
# Epic In-Basket Analysis Pipeline
# Comprehensive data processing and analysis for invisible work study
# Author: Nicolas Lescano, MD
# Course: BMIN 5070 – Human Factors in Biomedical Informatics

# =============================================================================
# SETUP AND PACKAGE MANAGEMENT
# =============================================================================

# Function to install packages if not available
install_if_missing <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing package:", pkg, "\n")
      install.packages(pkg, repos = "https://cloud.r-project.org")
    }
  }
}

# Required packages
required_packages <- c(
  "readxl", "dplyr", "tidyr", "ggplot2", "scales", "viridis", 
  "ggthemes", "patchwork", "corrplot", "psych", "broom", 
  "kableExtra", "DT", "knitr", "rmarkdown", "quarto"
)

# Install missing packages
cat("Checking and installing required packages...\n")
install_if_missing(required_packages)

# Load packages
suppressMessages({
  library(readxl)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
  library(viridis)
  library(ggthemes)
  library(patchwork)
  library(corrplot)
  library(psych)
  library(broom)
  library(kableExtra)
  library(DT)
  library(knitr)
})

# =============================================================================
# DATA LOADING AND PREPARATION
# =============================================================================

cat("Loading data from Excel files...\n")

# Load main data
time_data <- read_excel("PEP Data - Lescano N 07_2024-06_2025 v2.xlsx", sheet = "Time")
messages_data <- read_excel("PEP Data - Lescano N 07_2024-06_2025 v2.xlsx", sheet = "Messages")

# Clean column names
names(time_data)[1] <- "DE_ID"
names(messages_data)[1] <- "DE_ID"

# Load financial data for opportunity cost calculation
if (file.exists("Lescano_ProviderWorksheet_FY25.xlsx")) {
  financial_data <- read_excel("Lescano_ProviderWorksheet_FY25.xlsx")
  cat("Financial data loaded for opportunity cost calculation\n")
} else {
  cat("Warning: Financial data file not found. Using default opportunity cost.\n")
  financial_data <- NULL
}

# =============================================================================
# DATA PROCESSING FUNCTIONS
# =============================================================================

# Function to process time data
process_time_data <- function(data) {
  cat("Processing time data...\n")
  
  # Convert to long format
  time_long <- data %>%
    pivot_longer(cols = 4:15, names_to = "Month", values_to = "Value") %>%
    mutate(
      Month = case_when(
        Month == "24-Jul" ~ "2024-07-01",
        Month == "24-Aug" ~ "2024-08-01",
        Month == "24-Sep" ~ "2024-09-01",
        Month == "24-Oct" ~ "2024-10-01",
        Month == "24-Nov" ~ "2024-11-01",
        Month == "24-Dec" ~ "2024-12-01",
        Month == "25-Jan" ~ "2025-01-01",
        Month == "25-Feb" ~ "2025-02-01",
        Month == "25-Mar" ~ "2025-03-01",
        Month == "25-Apr" ~ "2025-04-01",
        Month == "25-May" ~ "2025-05-01",
        Month == "25-Jun" ~ "2025-06-01",
        TRUE ~ Month
      ),
      Date = as.Date(Month)
    )
  
  return(time_long)
}

# Function to calculate normalized workload
calculate_normalized_workload <- function(time_long) {
  cat("Calculating normalized workload...\n")
  
  # Get total system time
  time_summary <- time_long %>%
    filter(Metric == "Count Of Minutes In The System") %>%
    group_by(DE_ID) %>%
    summarise(
      total_minutes = sum(Value, na.rm = TRUE),
      provider_type = first(Grouper),
      .groups = 'drop'
    )
  
  # Get days in system
  days_data <- time_long %>%
    filter(Metric == "Count Of Days In System") %>%
    group_by(DE_ID) %>%
    summarise(
      days_in_system = sum(Value, na.rm = TRUE),
      .groups = 'drop'
    )
  
  # Merge and calculate normalized workload
  time_summary <- time_summary %>%
    left_join(days_data, by = "DE_ID") %>%
    mutate(
      normalized_hours_year = (total_minutes / 60) * (365 / days_in_system),
      provider_type = case_when(
        provider_type == "PHYSICIAN + PSYCHIATRIST" ~ "Attending Psychiatrist",
        provider_type == "RESIDENT + FELLOW" ~ "Psychiatry Resident/Fellow",
        provider_type == "NURSE PRACTITIONER" ~ "Nurse Practitioner",
        TRUE ~ provider_type
      )
    )
  
  return(time_summary)
}

# Function to calculate after-hours work
calculate_after_hours <- function(time_long, time_summary_filtered) {
  cat("Calculating after-hours work patterns...\n")
  
  after_hours_data <- time_long %>%
    filter(Metric == "Count Of Minutes Active Outside 7AM to 7PM") %>%
    group_by(DE_ID) %>%
    summarise(
      total_after_hours_minutes = sum(Value, na.rm = TRUE),
      .groups = 'drop'
    )
  
  total_system_minutes <- time_long %>%
    filter(Metric == "Count Of Minutes In The System") %>%
    group_by(DE_ID) %>%
    summarise(
      total_system_minutes = sum(Value, na.rm = TRUE),
      .groups = 'drop'
    )
  
  after_hours_summary <- after_hours_data %>%
    left_join(total_system_minutes, by = "DE_ID") %>%
    mutate(
      after_hours_percent = (total_after_hours_minutes / total_system_minutes) * 100
    ) %>%
    filter(DE_ID %in% time_summary_filtered$DE_ID) %>%
    filter(!is.na(after_hours_percent) & after_hours_percent > 0)
  
  return(after_hours_summary)
}

# =============================================================================
# STATISTICAL ANALYSIS FUNCTIONS
# =============================================================================

# Function to perform descriptive statistics
perform_descriptive_stats <- function(data) {
  cat("Performing descriptive statistics...\n")
  
  stats <- data %>%
    summarise(
      n = n(),
      mean_raw = mean(total_minutes / 60, na.rm = TRUE),
      median_raw = median(total_minutes / 60, na.rm = TRUE),
      sd_raw = sd(total_minutes / 60, na.rm = TRUE),
      min_raw = min(total_minutes / 60, na.rm = TRUE),
      max_raw = max(total_minutes / 60, na.rm = TRUE),
      cv_raw = (sd_raw / mean_raw) * 100,
      mean_normalized = mean(normalized_hours_year, na.rm = TRUE),
      median_normalized = median(normalized_hours_year, na.rm = TRUE),
      sd_normalized = sd(normalized_hours_year, na.rm = TRUE),
      min_normalized = min(normalized_hours_year, na.rm = TRUE),
      max_normalized = max(normalized_hours_year, na.rm = TRUE),
      cv_normalized = (sd_normalized / mean_normalized) * 100,
      iqr_raw = IQR(total_minutes / 60, na.rm = TRUE),
      iqr_normalized = IQR(normalized_hours_year, na.rm = TRUE)
    )
  
  return(stats)
}

# Function to perform risk stratification
perform_risk_stratification <- function(data) {
  cat("Performing risk stratification...\n")
  
  # Calculate percentiles for risk categories
  percentiles <- quantile(data$normalized_hours_year, probs = c(0.25, 0.75), na.rm = TRUE)
  
  risk_data <- data %>%
    mutate(
      risk_category = case_when(
        normalized_hours_year > percentiles[2] ~ "High Risk",
        normalized_hours_year >= percentiles[1] ~ "Moderate Risk",
        TRUE ~ "Low Risk"
      ),
      risk_category = factor(risk_category, levels = c("Low Risk", "Moderate Risk", "High Risk"))
    )
  
  risk_summary <- risk_data %>%
    group_by(risk_category) %>%
    summarise(
      count = n(),
      percentage = (n() / nrow(risk_data)) * 100,
      mean_raw = mean(total_minutes / 60, na.rm = TRUE),
      mean_normalized = mean(normalized_hours_year, na.rm = TRUE),
      sd_raw = sd(total_minutes / 60, na.rm = TRUE),
      sd_normalized = sd(normalized_hours_year, na.rm = TRUE),
      .groups = 'drop'
    )
  
  return(list(risk_data = risk_data, risk_summary = risk_summary))
}

# Function to perform provider type analysis
analyze_provider_types <- function(data) {
  cat("Analyzing provider types...\n")
  
  provider_analysis <- data %>%
    group_by(provider_type) %>%
    summarise(
      n = n(),
      mean_normalized = mean(normalized_hours_year, na.rm = TRUE),
      median_normalized = median(normalized_hours_year, na.rm = TRUE),
      sd_normalized = sd(normalized_hours_year, na.rm = TRUE),
      min_normalized = min(normalized_hours_year, na.rm = TRUE),
      max_normalized = max(normalized_hours_year, na.rm = TRUE),
      .groups = 'drop'
    ) %>%
    arrange(desc(mean_normalized))
  
  return(provider_analysis)
}

# =============================================================================
# VISUALIZATION FUNCTIONS
# =============================================================================

# Function to create workload distribution plot
create_workload_plot <- function(data) {
  cat("Creating workload distribution plot...\n")
  
  p <- ggplot(data %>% arrange(normalized_hours_year), 
              aes(x = reorder(DE_ID, normalized_hours_year), y = normalized_hours_year)) +
    geom_col(aes(fill = provider_type), alpha = 0.8) +
    scale_fill_manual(name = "Provider Type", 
                      values = c("Attending Psychiatrist" = "#990000",  # Penn Red
                                "Nurse Practitioner" = "#011F5B",        # Penn Blue
                                "Psychiatry Resident/Fellow" = "#6B6B6B")) +  # Gray
    scale_y_continuous(labels = scales::comma_format()) +
    labs(
      title = paste0("Provider Workload Distribution: ", 
                    round(max(data$normalized_hours_year) / min(data$normalized_hours_year), 1), 
                    "× Variation in Annual In-Basket Hours"),
      subtitle = "Normalized workload shows extreme disparities across providers (July 2024–June 2025)",
      x = "Provider (Ranked by Workload)",
      y = "Normalized Annual Workload (Hours/Year)",
      caption = "Source: Epic Signal Analytics. Normalized formula: (Total hours / Days in system) × 365"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray50"),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      legend.position = "bottom",
      plot.caption = element_text(size = 9, color = "gray60")
    ) +
    geom_hline(yintercept = median(data$normalized_hours_year),
               linetype = "dashed", color = "black", alpha = 0.8, linewidth = 1) +
    annotate("text", x = 10, y = median(data$normalized_hours_year) + 25,
             label = paste("Median:", round(median(data$normalized_hours_year), 1), "hrs/year"),
             color = "black", size = 4, fontface = "bold")
  
  return(p)
}

# Function to create after-hours work plot
create_after_hours_plot <- function(after_hours_data) {
  cat("Creating after-hours work plot...\n")
  
  system_avg_after_hours <- mean(after_hours_data$after_hours_percent, na.rm = TRUE)
  total_after_hours_sum <- sum(after_hours_data$total_after_hours_minutes, na.rm = TRUE) / 60
  
  p <- ggplot(after_hours_data %>% arrange(after_hours_percent), 
              aes(x = reorder(DE_ID, after_hours_percent), y = after_hours_percent)) +
    geom_col(aes(fill = after_hours_percent), alpha = 0.8) +
    scale_fill_viridis_c(name = "% After Hours", option = "inferno") +
    labs(
      title = paste0("After-Hours Work Distribution: ", 
                    round(system_avg_after_hours, 1), 
                    "% of In-Basket Work Outside Business Hours"),
      subtitle = paste0(round(total_after_hours_sum, 0), 
                        " hours of after-hours work across providers (July 2024–June 2025)"),
      x = "Provider (Ranked by After-Hours %)",
      y = "Percentage of Work After Hours (%)",
      caption = "Source: Epic Signal Analytics. After-hours defined as outside 7 AM–7 PM."
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray50"),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      legend.position = "bottom",
      plot.caption = element_text(size = 9, color = "gray60")
    ) +
    geom_hline(yintercept = round(system_avg_after_hours, 1), 
               linetype = "dashed", color = "red", alpha = 0.7) +
    annotate("text", x = 10, y = round(system_avg_after_hours, 1) + 0.5,
             label = paste("System Average:", round(system_avg_after_hours, 1), "%"),
             color = "red", size = 3)
  
  return(p)
}

# Function to create risk stratification plot
create_risk_plot <- function(risk_summary) {
  cat("Creating risk stratification plot...\n")
  
  risk_summary$label <- paste0(risk_summary$count, " (", round(risk_summary$percentage), "%)")
  
  p <- ggplot(risk_summary, aes(x = risk_category, y = count, fill = risk_category)) +
    geom_col(alpha = 0.8) +
    geom_text(aes(label = label), vjust = -0.5, size = 4, fontface = "bold") +
    scale_fill_manual(values = c("Low Risk" = "#2E8B57", "Moderate Risk" = "#FFD700", "High Risk" = "#DC143C")) +
    scale_y_continuous(limits = c(0, max(risk_summary$count) * 1.2)) +
    labs(
      title = "Provider Risk Stratification by Workload Burden",
      subtitle = paste0(risk_summary$count[risk_summary$risk_category == "High Risk"], 
                        " providers (",
                        round(risk_summary$percentage[risk_summary$risk_category == "High Risk"]), 
                        "%) at high risk with elevated normalized workload"),
      x = "Risk Category",
      y = "Number of Providers",
      caption = "Source: Epic Signal Analytics. Risk categories based on normalized annual workload thresholds."
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray50"),
      legend.position = "none",
      plot.caption = element_text(size = 9, color = "gray60")
    )
  
  return(p)
}

# =============================================================================
# TABLE GENERATION FUNCTIONS
# =============================================================================

# Function to create descriptive statistics table
create_descriptive_table <- function(stats) {
  cat("Creating descriptive statistics table...\n")
  
  table_data <- data.frame(
    Statistic = c("Mean", "Median", "IQR", "Standard Deviation", "Coefficient of Variation (%)"),
    `Raw Workload (Hours)` = c(
      round(stats$mean_raw, 1),
      round(stats$median_raw, 1),
      round(stats$iqr_raw, 1),
      round(stats$sd_raw, 1),
      round(stats$cv_raw, 1)
    ),
    `Normalized Workload (Hours/year)` = c(
      round(stats$mean_normalized, 1),
      round(stats$median_normalized, 1),
      round(stats$iqr_normalized, 1),
      round(stats$sd_normalized, 1),
      round(stats$cv_normalized, 1)
    )
  )
  
  return(table_data)
}

# Function to create risk stratification table
create_risk_table <- function(risk_summary) {
  cat("Creating risk stratification table...\n")
  
  risk_table <- risk_summary %>%
    mutate(
      `Criteria (Hours/year)` = case_when(
        risk_category == "High Risk" ~ paste0("> ", round(quantile(risk_summary$normalized_hours_year, 0.75, na.rm = TRUE), 0)),
        risk_category == "Moderate Risk" ~ paste0(round(quantile(risk_summary$normalized_hours_year, 0.25, na.rm = TRUE), 0), "–", 
                                                  round(quantile(risk_summary$normalized_hours_year, 0.75, na.rm = TRUE), 0)),
        TRUE ~ paste0("< ", round(quantile(risk_summary$normalized_hours_year, 0.25, na.rm = TRUE), 0))
      )
    ) %>%
    select(risk_category, count, `Criteria (Hours/year)`, mean_raw, mean_normalized, percentage) %>%
    rename(
      `Risk Category` = risk_category,
      `Number of Providers` = count,
      `Mean Raw Workload (Hours)` = mean_raw,
      `Mean Normalized Workload (Hours/year)` = mean_normalized,
      `Proportion of Total Providers (%)` = percentage
    )
  
  return(risk_table)
}

# =============================================================================
# MAIN ANALYSIS PIPELINE
# =============================================================================

cat("Starting Epic In-Basket Analysis Pipeline...\n")
cat("==========================================\n")

# Process time data
time_long <- process_time_data(time_data)

# Calculate normalized workload
time_summary <- calculate_normalized_workload(time_long)

# Filter providers with at least 30 days in system
time_summary_filtered <- time_summary %>%
  filter(days_in_system >= 30)

cat("Filtered to", nrow(time_summary_filtered), "providers with >= 30 days in system\n")

# Calculate after-hours work
after_hours_summary <- calculate_after_hours(time_long, time_summary_filtered)

# Perform statistical analyses
descriptive_stats <- perform_descriptive_stats(time_summary_filtered)
risk_analysis <- perform_risk_stratification(time_summary_filtered)
provider_analysis <- analyze_provider_types(time_summary_filtered)

# =============================================================================
# GENERATE FIGURES
# =============================================================================

cat("Generating figures...\n")

# Figure 1: Workload Distribution
p1 <- create_workload_plot(time_summary_filtered)
ggsave("Figure1_Provider_Workload_Distribution.png", p1, width = 12, height = 8, dpi = 300)

# Figure 2: After-Hours Work Pattern
p2 <- create_after_hours_plot(after_hours_summary)
ggsave("Figure2_After_Hours_Work_Pattern.png", p2, width = 12, height = 8, dpi = 300)

# Figure 3: Risk Stratification
p3 <- create_risk_plot(risk_analysis$risk_summary)
ggsave("Figure3_Risk_Stratification.png", p3, width = 12, height = 8, dpi = 300)

# =============================================================================
# GENERATE TABLES
# =============================================================================

cat("Generating tables...\n")

# Table 1: Descriptive Statistics
table1 <- create_descriptive_table(descriptive_stats)
write.csv(table1, "Table1_Descriptive_Statistics.csv", row.names = FALSE)

# Table 2: Risk Stratification
table2 <- create_risk_table(risk_analysis$risk_summary)
write.csv(table2, "Table2_Risk_Stratification.csv", row.names = FALSE)

# =============================================================================
# GENERATE SUMMARY REPORT
# =============================================================================

cat("Generating summary report...\n")

# Create summary statistics
summary_stats <- list(
  total_providers = nrow(time_summary_filtered),
  total_hours = sum(time_summary_filtered$total_minutes / 60),
  normalized_total_hours = sum(time_summary_filtered$normalized_hours_year),
  workload_variation = round(max(time_summary_filtered$normalized_hours_year) / 
                             min(time_summary_filtered$normalized_hours_year), 1),
  after_hours_percentage = round(mean(after_hours_summary$after_hours_percent, na.rm = TRUE), 1),
  high_risk_providers = sum(risk_analysis$risk_data$risk_category == "High Risk"),
  high_risk_percentage = round(sum(risk_analysis$risk_data$risk_category == "High Risk") / 
                               nrow(risk_analysis$risk_data) * 100, 1)
)

# Print summary
cat("\n=== ANALYSIS SUMMARY ===\n")
cat("Total Providers:", summary_stats$total_providers, "\n")
cat("Total Raw Hours:", round(summary_stats$total_hours, 1), "\n")
cat("Total Normalized Hours:", round(summary_stats$normalized_total_hours, 1), "\n")
cat("Workload Variation:", summary_stats$workload_variation, "×\n")
cat("After-Hours Percentage:", summary_stats$after_hours_percentage, "%\n")
cat("High-Risk Providers:", summary_stats$high_risk_providers, 
    "(", summary_stats$high_risk_percentage, "%)\n")

# =============================================================================
# SAVE PROCESSED DATA
# =============================================================================

cat("Saving processed data...\n")

# Save processed datasets
write.csv(time_summary_filtered, "processed_time_data.csv", row.names = FALSE)
write.csv(after_hours_summary, "processed_after_hours_data.csv", row.names = FALSE)
write.csv(risk_analysis$risk_data, "processed_risk_data.csv", row.names = FALSE)
write.csv(provider_analysis, "processed_provider_analysis.csv", row.names = FALSE)

# Save summary statistics
saveRDS(summary_stats, "summary_statistics.rds")

cat("\n=== PIPELINE COMPLETED SUCCESSFULLY ===\n")
cat("Files generated:\n")
cat("- Figure1_Provider_Workload_Distribution.png\n")
cat("- Figure2_After_Hours_Work_Pattern.png\n")
cat("- Figure3_Risk_Stratification.png\n")
cat("- Table1_Descriptive_Statistics.csv\n")
cat("- Table2_Risk_Stratification.csv\n")
cat("- processed_time_data.csv\n")
cat("- processed_after_hours_data.csv\n")
cat("- processed_risk_data.csv\n")
cat("- processed_provider_analysis.csv\n")
cat("- summary_statistics.rds\n")
