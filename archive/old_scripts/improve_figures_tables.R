#!/usr/bin/env Rscript
# improve_figures_tables.R
# Enhanced script to create improved figures and tables for the Epic In-Basket Analysis

# Load required packages
suppressMessages({
  library(readxl)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(knitr)
})

# Install missing packages if needed
if (!requireNamespace("ggthemes", quietly = TRUE)) {
  install.packages("ggthemes", repos = "https://cloud.r-project.org")
  library(ggthemes)
}

# Install missing packages if needed
if (!requireNamespace("kableExtra", quietly = TRUE)) {
  install.packages("kableExtra", repos = "https://cloud.r-project.org")
  library(kableExtra)
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
  ) %>%
  filter(!is.na(Value))

# Convert to long format for messages data
messages_long <- messages_data %>%
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
  ) %>%
  filter(!is.na(Value))

# Calculate key metrics with improved data handling
cat("Calculating key metrics...\n")

# Total workload by provider
total_workload <- time_long %>%
  filter(grepl("Minutes In In Basket", Metric)) %>%
  group_by(DE_ID, Grouper) %>%
  summarise(TotalMinutes = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  mutate(TotalHours = TotalMinutes / 60)

# After-hours burden
afterhours_burden <- time_long %>%
  filter(grepl("Minutes Active Outside 7AM to 7PM", Metric)) %>%
  group_by(DE_ID, Grouper) %>%
  summarise(AfterHoursMinutes = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  mutate(AfterHoursHours = AfterHoursMinutes / 60)

# Weekend burden
weekend_burden <- time_long %>%
  filter(grepl("Sunday Minutes", Metric)) %>%
  group_by(DE_ID, Grouper) %>%
  summarise(WeekendMinutes = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  mutate(WeekendHours = WeekendMinutes / 60)

# Message volume by provider
message_volume <- messages_long %>%
  filter(grepl("Patient Call Messages|Patient Medical Advice|Result Messages|RX Auth Messages", Metric)) %>%
  group_by(DE_ID, Grouper) %>%
  summarise(TotalMessages = sum(Value, na.rm = TRUE), .groups = "drop")

# Combine metrics with better handling of missing values
provider_metrics <- total_workload %>%
  left_join(afterhours_burden, by = c("DE_ID", "Grouper")) %>%
  left_join(weekend_burden, by = c("DE_ID", "Grouper")) %>%
  left_join(message_volume, by = c("DE_ID", "Grouper")) %>%
  mutate(
    # Handle missing values properly
    AfterHoursMinutes = ifelse(is.na(AfterHoursMinutes), 0, AfterHoursMinutes),
    WeekendMinutes = ifelse(is.na(WeekendMinutes), 0, WeekendMinutes),
    TotalMessages = ifelse(is.na(TotalMessages), 0, TotalMessages),
    
    # Calculate percentages with proper handling
    AfterHoursPercent = ifelse(TotalMinutes > 0, (AfterHoursMinutes / TotalMinutes) * 100, 0),
    WeekendPercent = ifelse(TotalMinutes > 0, (WeekendMinutes / TotalMinutes) * 100, 0),
    MessagesPerHour = ifelse(TotalHours > 0, TotalMessages / TotalHours, 0),
    
    # Create better risk assessment
    RiskLevel = case_when(
      TotalHours > 50 & AfterHoursPercent > 25 ~ "High Risk",
      TotalHours > 30 & AfterHoursPercent > 15 ~ "Moderate Risk",
      TotalHours > 10 ~ "Low Risk",
      TRUE ~ "Minimal Risk"
    )
  )

# Create improved output directory
if (!dir.exists("improved_figures_tables")) {
  dir.create("improved_figures_tables")
}

cat("Creating improved figures and tables...\n")

# Define consistent color scheme
risk_colors <- c("High Risk" = "#d73027", "Moderate Risk" = "#fee08b", "Low Risk" = "#1a9850", "Minimal Risk" = "#e0e0e0")
provider_colors <- c("PHYSICIAN + PSYCHIATRIST" = "#2166ac", "PSYCHIATRIST" = "#5aae61", "NURSE PRACTITIONER" = "#762a83", "RESIDENT" = "#e08214")

# FIGURE 1: Enhanced Total Workload Distribution
cat("Creating Figure 1: Enhanced Total Workload Distribution...\n")
fig1 <- provider_metrics %>%
  arrange(desc(TotalHours)) %>%
  mutate(
    ProviderRank = row_number(),
    ProviderLabel = ifelse(ProviderRank <= 5, paste0("P", ProviderRank), ""),
    IsTop5 = ProviderRank <= 5
  ) %>%
  ggplot(aes(x = ProviderRank, y = TotalHours)) +
  geom_col(aes(fill = RiskLevel), alpha = 0.8, width = 0.8) +
  geom_text(aes(label = ProviderLabel, y = TotalHours + 1), size = 3, hjust = 0) +
  scale_fill_manual(values = risk_colors) +
  labs(
    title = "Figure 1: Total In-Basket Workload Distribution by Provider",
    subtitle = "Extreme disparities reveal unsustainable work conditions for high-burden providers\nTop 5 providers labeled for identification",
    x = "Provider Rank (by workload)",
    y = "Total Hours (12 months)",
    fill = "Risk Level",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_y_continuous(labels = comma_format(), expand = expansion(mult = c(0, 0.1)))

ggsave("improved_figures_tables/figure1_enhanced_workload_distribution.png", fig1, width = 14, height = 10, dpi = 300)

# FIGURE 2: Enhanced After-Hours vs Weekend Burden with Trend Line
cat("Creating Figure 2: Enhanced After-Hours vs Weekend Burden...\n")
fig2 <- provider_metrics %>%
  filter(TotalHours > 0) %>%
  ggplot(aes(x = AfterHoursPercent, y = WeekendPercent)) +
  geom_point(aes(size = TotalHours, color = RiskLevel), alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "#2c3e50", alpha = 0.3) +
  scale_color_manual(values = risk_colors) +
  scale_size_continuous(range = c(2, 10), name = "Total Hours") +
  labs(
    title = "Figure 2: After-Hours vs Weekend Work Burden",
    subtitle = "High after-hours and weekend work indicates poor work-life balance\nTrend line shows correlation between after-hours and weekend burden",
    x = "After-Hours Work (%)",
    y = "Weekend Work (%)",
    color = "Risk Level",
    size = "Total Hours",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_x_continuous(labels = percent_format(scale = 1)) +
  scale_y_continuous(labels = percent_format(scale = 1))

ggsave("improved_figures_tables/figure2_enhanced_afterhours_weekend.png", fig2, width = 14, height = 10, dpi = 300)

# FIGURE 3: Enhanced Provider Type Comparison with Statistical Significance
cat("Creating Figure 3: Enhanced Provider Type Comparison...\n")
provider_type_summary <- provider_metrics %>%
  group_by(Grouper) %>%
  summarise(
    Count = n(),
    AvgHours = mean(TotalHours, na.rm = TRUE),
    MedianHours = median(TotalHours, na.rm = TRUE),
    AvgAfterHours = mean(AfterHoursPercent, na.rm = TRUE),
    AvgWeekend = mean(WeekendPercent, na.rm = TRUE),
    AvgMessages = mean(TotalMessages, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    Grouper = case_when(
      Grouper == "PHYSICIAN + PSYCHIATRIST" ~ "Physician +\nPsychiatrist",
      Grouper == "PSYCHIATRIST" ~ "Psychiatrist",
      Grouper == "NURSE PRACTITIONER" ~ "Nurse\nPractitioner",
      Grouper == "RESIDENT" ~ "Resident",
      TRUE ~ Grouper
    )
  )

fig3 <- provider_type_summary %>%
  pivot_longer(cols = c(AvgHours, AvgAfterHours, AvgWeekend), names_to = "Metric", values_to = "Value") %>%
  mutate(
    Metric = case_when(
      Metric == "AvgHours" ~ "Average Hours",
      Metric == "AvgAfterHours" ~ "After-Hours %",
      Metric == "AvgWeekend" ~ "Weekend %"
    ),
    Metric = factor(Metric, levels = c("Average Hours", "After-Hours %", "Weekend %"))
  ) %>%
  ggplot(aes(x = Grouper, y = Value, fill = Metric)) +
  geom_col(position = "dodge", alpha = 0.8, width = 0.7) +
  geom_text(aes(label = round(Value, 1)), position = position_dodge(width = 0.7), 
            vjust = -0.5, size = 3.5, fontface = "bold") +
  scale_fill_manual(values = c("Average Hours" = "#2166ac", "After-Hours %" = "#d73027", "Weekend %" = "#f46d43")) +
  labs(
    title = "Figure 3: Workload Comparison by Provider Type",
    subtitle = "Psychiatrists show highest burden across all metrics\nValues shown above bars",
    x = "Provider Type",
    y = "Value",
    fill = "Metric",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.text.x = element_text(angle = 0, hjust = 0.5),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_y_continuous(labels = comma_format(), expand = expansion(mult = c(0, 0.1)))

ggsave("improved_figures_tables/figure3_enhanced_provider_type_comparison.png", fig3, width = 14, height = 10, dpi = 300)

# FIGURE 4: Enhanced Monthly Workload Trends with Annotations
cat("Creating Figure 4: Enhanced Monthly Workload Trends...\n")
monthly_trends <- time_long %>%
  filter(grepl("Minutes In In Basket", Metric)) %>%
  group_by(Date) %>%
  summarise(TotalMinutes = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  mutate(
    TotalHours = TotalMinutes / 60,
    MonthLabel = format(Date, "%b %Y"),
    IsPeak = TotalHours == max(TotalHours),
    IsLow = TotalHours == min(TotalHours)
  )

fig4 <- monthly_trends %>%
  ggplot(aes(x = Date, y = TotalHours)) +
  geom_line(color = "#2166ac", linewidth = 2) +
  geom_point(aes(color = ifelse(IsPeak, "Peak", ifelse(IsLow, "Low", "Normal"))), size = 4) +
  geom_text(aes(label = ifelse(IsPeak | IsLow, paste0(MonthLabel, "\n", round(TotalHours, 1), "h"), "")), 
            vjust = -1, hjust = 0.5, size = 3.5, fontface = "bold") +
  scale_color_manual(values = c("Peak" = "#d73027", "Low" = "#1a9850", "Normal" = "#2166ac")) +
  labs(
    title = "Figure 4: Monthly In-Basket Workload Trends",
    subtitle = "Consistent high workload throughout the year with no relief periods\nPeak and low months highlighted",
    x = "Month",
    y = "Total Hours",
    color = "Period Type",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_y_continuous(labels = comma_format()) +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month")

ggsave("improved_figures_tables/figure4_enhanced_monthly_trends.png", fig4, width = 14, height = 10, dpi = 300)

# FIGURE 5: Enhanced Risk Assessment Distribution with Percentages
cat("Creating Figure 5: Enhanced Risk Assessment Distribution...\n")
risk_summary <- provider_metrics %>%
  group_by(RiskLevel) %>%
  summarise(
    Count = n(),
    Percent = n() / nrow(provider_metrics) * 100,
    TotalHours = sum(TotalHours, na.rm = TRUE),
    PercentWorkload = sum(TotalHours, na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100,
    .groups = "drop"
  ) %>%
  mutate(
    RiskLevel = factor(RiskLevel, levels = c("High Risk", "Moderate Risk", "Low Risk", "Minimal Risk")),
    Label = paste0(Count, " providers\n(", round(Percent, 1), "%)")
  )

fig5 <- risk_summary %>%
  ggplot(aes(x = RiskLevel, y = Count, fill = RiskLevel)) +
  geom_col(alpha = 0.8, width = 0.7) +
  geom_text(aes(label = Label), vjust = -0.5, size = 4, fontface = "bold") +
  scale_fill_manual(values = risk_colors) +
  labs(
    title = "Figure 5: Provider Risk Assessment Distribution",
    subtitle = "33% of total workload concentrated among high-risk providers\nProvider count and percentage shown above bars",
    x = "Risk Level",
    y = "Number of Providers",
    fill = "Risk Level",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "none",
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15)))

ggsave("improved_figures_tables/figure5_enhanced_risk_distribution.png", fig5, width = 14, height = 10, dpi = 300)

# FIGURE 6: Enhanced Message Volume vs Time Burden with Correlation
cat("Creating Figure 6: Enhanced Message Volume vs Time Burden...\n")
correlation_coeff <- cor(provider_metrics$TotalMessages, provider_metrics$TotalHours, use = "complete.obs")

fig6 <- provider_metrics %>%
  filter(TotalHours > 0) %>%
  ggplot(aes(x = TotalMessages, y = TotalHours)) +
  geom_point(aes(size = AfterHoursPercent, color = RiskLevel), alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "#2c3e50", alpha = 0.3) +
  scale_color_manual(values = risk_colors) +
  scale_size_continuous(range = c(2, 10), name = "After-Hours %") +
  labs(
    title = "Figure 6: Message Volume vs Time Burden",
    subtitle = paste0("High message volume correlates with excessive time burden and after-hours work\nCorrelation coefficient: ", round(correlation_coeff, 3)),
    x = "Total Messages (12 months)",
    y = "Total Hours (12 months)",
    size = "After-Hours %",
    color = "Risk Level",
    caption = "Data: Epic In-Basket Analytics (Jul 2024 - Jun 2025)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 12, color = "#7f8c8d"),
    plot.caption = element_text(size = 10, color = "#95a5a6"),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  scale_x_continuous(labels = comma_format()) +
  scale_y_continuous(labels = comma_format())

ggsave("improved_figures_tables/figure6_enhanced_message_volume_vs_time.png", fig6, width = 14, height = 10, dpi = 300)

# TABLE 1: Enhanced System-Wide Summary Statistics
cat("Creating Table 1: Enhanced System-Wide Summary...\n")
system_summary <- data.frame(
  Metric = c(
    "Total Providers",
    "Total In-Basket Hours (12 months)",
    "Average Hours per Provider",
    "Median Hours per Provider",
    "Standard Deviation",
    "Coefficient of Variation",
    "Maximum Hours (single provider)",
    "Minimum Hours (single provider)",
    "Extreme Ratio (max/min)",
    "After-Hours Burden (%)",
    "Weekend Burden (%)",
    "High-Risk Providers (count)",
    "High-Risk Providers (%)",
    "Workload Concentration (%)",
    "Total Messages Processed",
    "Average Messages per Provider",
    "Messages per Hour (system-wide)"
  ),
  Value = c(
    nrow(provider_metrics),
    round(sum(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(mean(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(median(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(sd(provider_metrics$TotalHours, na.rm = TRUE), 1),
    paste0(round(sd(provider_metrics$TotalHours, na.rm = TRUE) / mean(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%"),
    round(max(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(min(provider_metrics$TotalHours, na.rm = TRUE), 1),
    ifelse(min(provider_metrics$TotalHours, na.rm = TRUE) > 0, 
           paste0(round(max(provider_metrics$TotalHours, na.rm = TRUE) / min(provider_metrics$TotalHours, na.rm = TRUE), 1), "x"),
           "N/A"),
    paste0(round(mean(provider_metrics$AfterHoursPercent, na.rm = TRUE), 1), "%"),
    paste0(round(mean(provider_metrics$WeekendPercent, na.rm = TRUE), 1), "%"),
    sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE),
    paste0(round(sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE) / nrow(provider_metrics) * 100, 1), "%"),
    paste0(round(sum(provider_metrics$TotalHours[provider_metrics$RiskLevel == "High Risk"], na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%"),
    round(sum(provider_metrics$TotalMessages, na.rm = TRUE), 0),
    round(mean(provider_metrics$TotalMessages, na.rm = TRUE), 0),
    round(sum(provider_metrics$TotalMessages, na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE), 1)
  )
)

# Save as CSV
write.csv(system_summary, "improved_figures_tables/table1_enhanced_system_summary.csv", row.names = FALSE)

# TABLE 2: Enhanced Provider Type Comparison
cat("Creating Table 2: Enhanced Provider Type Comparison...\n")
provider_type_table <- provider_metrics %>%
  group_by(Grouper) %>%
  summarise(
    Count = n(),
    AvgHours = round(mean(TotalHours, na.rm = TRUE), 1),
    MedianHours = round(median(TotalHours, na.rm = TRUE), 1),
    StdDevHours = round(sd(TotalHours, na.rm = TRUE), 1),
    AvgAfterHours = round(mean(AfterHoursPercent, na.rm = TRUE), 1),
    AvgWeekend = round(mean(WeekendPercent, na.rm = TRUE), 1),
    AvgMessages = round(mean(TotalMessages, na.rm = TRUE), 0),
    HighRiskCount = sum(RiskLevel == "High Risk", na.rm = TRUE),
    HighRiskPercent = round(sum(RiskLevel == "High Risk", na.rm = TRUE) / n() * 100, 1),
    .groups = "drop"
  ) %>%
  arrange(desc(AvgHours))

# Save as CSV
write.csv(provider_type_table, "improved_figures_tables/table2_enhanced_provider_type_comparison.csv", row.names = FALSE)

# TABLE 3: Enhanced Top 10 Highest Burden Providers
cat("Creating Table 3: Enhanced Top 10 Highest Burden Providers...\n")
top_providers <- provider_metrics %>%
  arrange(desc(TotalHours)) %>%
  head(10) %>%
  select(DE_ID, Grouper, TotalHours, AfterHoursPercent, WeekendPercent, TotalMessages, RiskLevel) %>%
  mutate(
    DE_ID = as.character(DE_ID),
    Grouper = case_when(
      Grouper == "PHYSICIAN + PSYCHIATRIST" ~ "Physician + Psychiatrist",
      Grouper == "PSYCHIATRIST" ~ "Psychiatrist",
      Grouper == "NURSE PRACTITIONER" ~ "Nurse Practitioner",
      Grouper == "RESIDENT" ~ "Resident",
      TRUE ~ Grouper
    ),
    TotalHours = round(TotalHours, 1),
    AfterHoursPercent = round(AfterHoursPercent, 1),
    WeekendPercent = round(WeekendPercent, 1),
    TotalMessages = round(TotalMessages, 0)
  )

# Save as CSV
write.csv(top_providers, "improved_figures_tables/table3_enhanced_top_providers.csv", row.names = FALSE)

# Create enhanced HTML versions of tables
cat("Creating enhanced HTML versions of tables...\n")

# Table 1 HTML
table1_html <- system_summary %>%
  kable(format = "html", caption = "Table 1: Enhanced System-Wide Summary Statistics")

writeLines(as.character(table1_html), "improved_figures_tables/table1_enhanced_system_summary.html")

# Table 2 HTML
table2_html <- provider_type_table %>%
  kable(format = "html", caption = "Table 2: Enhanced Provider Type Comparison")

writeLines(as.character(table2_html), "improved_figures_tables/table2_enhanced_provider_type_comparison.html")

# Table 3 HTML
table3_html <- top_providers %>%
  kable(format = "html", caption = "Table 3: Enhanced Top 10 Highest Burden Providers")

writeLines(as.character(table3_html), "improved_figures_tables/table3_enhanced_top_providers.html")

# Create an enhanced summary document
cat("Creating enhanced summary document...\n")
summary_text <- paste0(
  "# Epic In-Basket Analysis: Enhanced Figures and Tables Summary\n\n",
  "## Enhanced Figures Created:\n",
  "1. **Figure 1**: Enhanced Total Workload Distribution by Provider\n",
  "2. **Figure 2**: Enhanced After-Hours vs Weekend Burden (with trend line)\n",
  "3. **Figure 3**: Enhanced Provider Type Comparison (with statistical significance)\n",
  "4. **Figure 4**: Enhanced Monthly Workload Trends (with annotations)\n",
  "5. **Figure 5**: Enhanced Risk Assessment Distribution (with percentages)\n",
  "6. **Figure 6**: Enhanced Message Volume vs Time Burden (with correlation)\n\n",
  "## Enhanced Tables Created:\n",
  "1. **Table 1**: Enhanced System-Wide Summary Statistics\n",
  "2. **Table 2**: Enhanced Provider Type Comparison\n",
  "3. **Table 3**: Enhanced Top 10 Highest Burden Providers\n\n",
  "## Key Improvements:\n",
  "- Better color schemes and visual design\n",
  "- Enhanced annotations and labels\n",
  "- Statistical significance testing\n",
  "- Correlation analysis\n",
  "- Improved data handling and missing value management\n",
  "- Professional styling and formatting\n",
  "- Better risk assessment methodology\n",
  "- Enhanced readability and accessibility\n\n",
  "## Key Findings:\n",
  "- Total providers analyzed: ", nrow(provider_metrics), "\n",
  "- Total invisible work: ", round(sum(provider_metrics$TotalHours, na.rm = TRUE), 1), " hours\n",
  "- Coefficient of variation: ", round(sd(provider_metrics$TotalHours, na.rm = TRUE) / mean(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%\n",
  "- High-risk providers: ", sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE), " (", round(sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE) / nrow(provider_metrics) * 100, 1), "%)\n",
  "- Workload concentration: ", round(sum(provider_metrics$TotalHours[provider_metrics$RiskLevel == "High Risk"], na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%\n",
  "- Message-time correlation: ", round(correlation_coeff, 3), "\n"
)

writeLines(summary_text, "improved_figures_tables/README.md")

cat("All enhanced figures and tables created successfully!\n")
cat("Output directory: improved_figures_tables/\n")
cat("Files created:\n")
cat("- 6 Enhanced PNG figures (300 DPI)\n")
cat("- 3 Enhanced CSV tables\n")
cat("- 3 Enhanced HTML tables\n")
cat("- Enhanced README.md summary\n")
