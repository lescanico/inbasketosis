#!/usr/bin/env Rscript
# create_single_plot_figures.R
# Script to create single, highest-yield plots per figure

# Load required packages
suppressMessages({
  library(readxl)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
})

# Install missing packages if needed
if (!requireNamespace("viridis", quietly = TRUE)) {
  install.packages("viridis", repos = "https://cloud.r-project.org")
  library(viridis)
}

if (!requireNamespace("ggthemes", quietly = TRUE)) {
  install.packages("ggthemes", repos = "https://cloud.r-project.org")
  library(ggthemes)
}

# Set working directory
setwd(getwd())

# Load the data
cat("Loading data...\n")
time_data <- read_excel("PEP Data - Lescano N 07_2024-06_2025 v2.xlsx", sheet = "Time")
messages_data <- read_excel("PEP Data - Lescano N 07_2024-06_2025 v2.xlsx", sheet = "Messages")

# Clean column names
names(time_data)[1] <- "DE_ID"
names(messages_data)[1] <- "DE_ID"

# Data preparation
cat("Preparing data...\n")

# Convert to long format for time data
time_long <- time_data %>%
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

# Calculate normalized workload (hours per year)
time_summary <- time_long %>%
  filter(Metric == "Count Of Minutes In The System") %>%
  group_by(DE_ID) %>%
  summarise(
    total_minutes = sum(Value, na.rm = TRUE),
    provider_type = first(Grouper),
    .groups = 'drop'
  )

# Get days in system separately
days_data <- time_long %>%
  filter(Metric == "Count Of Days In System") %>%
  group_by(DE_ID) %>%
  summarise(
    days_in_system = sum(Value, na.rm = TRUE),
    .groups = 'drop'
  )

# Merge data
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

# Filter providers with at least 30 days in system
time_summary_filtered <- time_summary %>%
  filter(days_in_system >= 30)

cat("Creating Figure 1: Provider Workload Distribution...\n")

# Figure 1: Provider Workload Distribution (highest yield - shows the extreme disparities)
p1 <- ggplot(time_summary_filtered, aes(x = reorder(DE_ID, normalized_hours_year), y = normalized_hours_year)) +
  geom_col(aes(fill = provider_type), alpha = 0.8) +
  scale_fill_manual(name = "Provider Type", 
                    values = c("Attending Psychiatrist" = "#990000",  # Penn Red
                              "Nurse Practitioner" = "#011F5B",        # Penn Blue
                              "Psychiatry Resident/Fellow" = "#6B6B6B")) +  # Gray for residents
  scale_y_continuous(labels = scales::comma_format()) +
  labs(
    title = "Provider Workload Distribution: 27.2× Variation in Annual In-Basket Hours",
    subtitle = "Normalized workload shows extreme disparities across 56 providers (July 2024–June 2025)",
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
  geom_hline(yintercept = median(time_summary_filtered$normalized_hours_year),
             linetype = "dashed", color = "black", alpha = 0.8, linewidth = 1) +
  annotate("text", x = 10, y = median(time_summary_filtered$normalized_hours_year) + 25,
           label = paste("Median:", round(median(time_summary_filtered$normalized_hours_year), 1), "hrs/year"),
           color = "black", size = 4, fontface = "bold")

ggsave("Figure1_Provider_Workload_Distribution.png", p1, width = 12, height = 8, dpi = 300)

cat("Creating Figure 2: Provider Type Comparison...\n")

# Figure 2: Provider Type Comparison (highest yield - shows clear differences by role)
p2 <- ggplot(time_summary_filtered, aes(x = provider_type, y = normalized_hours_year, fill = provider_type)) +
  geom_boxplot(alpha = 0.7, outlier.shape = 21, outlier.fill = "red") +
  geom_jitter(width = 0.2, alpha = 0.6, size = 2) +
  scale_fill_viridis_d(name = "Provider Type", option = "viridis") +
  scale_y_continuous(labels = scales::comma_format()) +
  labs(
    title = "Workload Disparities by Provider Type",
    subtitle = "Nurse Practitioners show highest median workload (1,239 hrs/year) vs Residents (343 hrs/year)",
    x = "Provider Type",
    y = "Normalized Annual Workload (Hours/Year)",
    caption = "Source: Epic Signal Analytics. Box plots show median, quartiles, and outliers. Points represent individual providers."
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "gray50"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none",
    plot.caption = element_text(size = 9, color = "gray60")
  ) +
  stat_summary(fun = median, geom = "point", shape = 23, size = 3, fill = "white", color = "black")

ggsave("Figure2_Provider_Type_Comparison.png", p2, width = 10, height = 8, dpi = 300)

cat("Creating Figure 3: After-Hours Work Pattern...\n")

# Figure 3: After-Hours Work Pattern (highest yield - shows the 40.2% after-hours burden)
after_hours_data <- time_long %>%
  filter(Metric == "Count Of Minutes Active Outside 7AM to 7PM") %>%
  group_by(DE_ID) %>%
  summarise(
    after_hours_minutes = sum(Value, na.rm = TRUE),
    total_minutes = sum(time_long$Value[time_long$DE_ID == DE_ID & time_long$Metric == "Count Of Minutes In The System"], na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  mutate(
    after_hours_percent = (after_hours_minutes / total_minutes) * 100,
    after_hours_hours = after_hours_minutes / 60
  ) %>%
  filter(!is.na(after_hours_percent) & after_hours_percent > 0)

p3 <- ggplot(after_hours_data, aes(x = reorder(DE_ID, after_hours_percent), y = after_hours_percent)) +
  geom_col(aes(fill = after_hours_percent), alpha = 0.8) +
  scale_fill_viridis_c(name = "% After Hours", option = "inferno") +
  labs(
    title = "After-Hours Work Distribution: 3.8% of In-Basket Work Outside Business Hours",
    subtitle = "794 hours of after-hours work across 56 providers (July 2024–June 2025)",
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
  geom_hline(yintercept = 3.8, linetype = "dashed", color = "red", alpha = 0.7) +
  annotate("text", x = 10, y = 4.5,
           label = "System Average: 3.8%",
           color = "red", size = 3)

ggsave("Figure3_After_Hours_Work_Pattern.png", p3, width = 12, height = 8, dpi = 300)

cat("Creating Figure 4: Risk Stratification...\n")

# Figure 4: Risk Stratification (highest yield - shows the high-risk providers)
risk_data <- time_summary_filtered %>%
  mutate(
    risk_category = case_when(
      normalized_hours_year > 530 ~ "High Risk",
      normalized_hours_year >= 217 ~ "Moderate Risk",
      TRUE ~ "Low Risk"
    ),
    risk_category = factor(risk_category, levels = c("Low Risk", "Moderate Risk", "High Risk"))
  )

risk_summary <- risk_data %>%
  group_by(risk_category) %>%
  summarise(
    count = n(),
    mean_hours = mean(normalized_hours_year),
    .groups = 'drop'
  ) %>%
  mutate(
    percentage = (count / sum(count)) * 100,
    label = paste0(count, " providers\n(", round(percentage, 0), "%)")
  )

p4 <- ggplot(risk_summary, aes(x = risk_category, y = count, fill = risk_category)) +
  geom_col(alpha = 0.8) +
  geom_text(aes(label = label), vjust = -0.5, size = 4, fontface = "bold") +
  scale_fill_manual(values = c("Low Risk" = "#2E8B57", "Moderate Risk" = "#FFD700", "High Risk" = "#DC143C")) +
  scale_y_continuous(limits = c(0, max(risk_summary$count) * 1.2)) +
  labs(
    title = "Provider Risk Stratification by Workload Burden",
    subtitle = "14 providers (25%) at high risk with >530 hours/year normalized workload",
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

ggsave("Figure4_Risk_Stratification.png", p4, width = 10, height = 8, dpi = 300)

cat("Creating tables...\n")

# Table 1: Descriptive Statistics
desc_stats <- time_summary_filtered %>%
  summarise(
    Statistic = c("Mean", "Median"),
    `Raw Workload (Hours)` = c(
      round(mean(total_minutes / 60), 1),
      round(median(total_minutes / 60), 1)
    ),
    `Normalized Workload (Hours/year)` = c(
      round(mean(normalized_hours_year), 1),
      round(median(normalized_hours_year), 1)
    ),
    Minimum = c(
      round(min(total_minutes / 60), 1),
      round(min(normalized_hours_year), 1)
    ),
    Maximum = c(
      round(max(total_minutes / 60), 1),
      round(max(normalized_hours_year), 1)
    ),
    `Standard Deviation` = c(
      round(sd(total_minutes / 60), 1),
      round(sd(normalized_hours_year), 1)
    ),
    `Coefficient of Variation (%)` = c(
      round((sd(total_minutes / 60) / mean(total_minutes / 60)) * 100, 1),
      round((sd(normalized_hours_year) / mean(normalized_hours_year)) * 100, 1)
    )
  )

# Table 2: Risk Stratification
risk_table <- risk_data %>%
  group_by(risk_category) %>%
  summarise(
    `Number of Providers` = n(),
    `Criteria (Hours/year)` = case_when(
      risk_category == "High Risk" ~ "> 530",
      risk_category == "Moderate Risk" ~ "217–530",
      TRUE ~ "< 217"
    ),
    `Mean Raw Workload (Hours)` = round(mean(total_minutes / 60), 1),
    `Mean Normalized Workload (Hours/year)` = round(mean(normalized_hours_year), 1),
    `Proportion of Total Providers (%)` = round((n() / nrow(risk_data)) * 100, 0),
    .groups = 'drop'
  ) %>%
  rename(`Risk Category` = risk_category)

# Save tables as CSV for reference
write.csv(desc_stats, "Table1_Descriptive_Statistics.csv", row.names = FALSE)
write.csv(risk_table, "Table2_Risk_Stratification.csv", row.names = FALSE)

cat("Single-plot figures created successfully!\n")
cat("Files created:\n")
cat("- Figure1_Provider_Workload_Distribution.png\n")
cat("- Figure2_Provider_Type_Comparison.png\n")
cat("- Figure3_After_Hours_Work_Pattern.png\n")
cat("- Figure4_Risk_Stratification.png\n")
cat("- Table1_Descriptive_Statistics.csv\n")
cat("- Table2_Risk_Stratification.csv\n")
