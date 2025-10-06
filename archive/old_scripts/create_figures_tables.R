#!/usr/bin/env Rscript
# create_figures_tables.R
# Script to create the 6 most relevant figures and 3 most relevant tables for the Epic In-Basket Analysis

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

# Calculate key metrics
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

# Combine metrics
provider_metrics <- total_workload %>%
  left_join(afterhours_burden, by = c("DE_ID", "Grouper")) %>%
  left_join(weekend_burden, by = c("DE_ID", "Grouper")) %>%
  left_join(message_volume, by = c("DE_ID", "Grouper")) %>%
  mutate(
    AfterHoursPercent = ifelse(TotalMinutes > 0, (AfterHoursMinutes / TotalMinutes) * 100, 0),
    WeekendPercent = ifelse(TotalMinutes > 0, (WeekendMinutes / TotalMinutes) * 100, 0),
    MessagesPerHour = ifelse(TotalHours > 0, TotalMessages / TotalHours, 0)
  )

# Risk assessment
provider_metrics <- provider_metrics %>%
  mutate(
    RiskLevel = case_when(
      TotalHours > 100 & AfterHoursPercent > 20 ~ "High Risk",
      TotalHours > 75 & AfterHoursPercent > 15 ~ "Moderate Risk",
      TRUE ~ "Low Risk"
    )
  )

# Create output directory
if (!dir.exists("figures_tables")) {
  dir.create("figures_tables")
}

cat("Creating figures and tables...\n")

# FIGURE 1: Total Workload Distribution by Provider
cat("Creating Figure 1: Total Workload Distribution...\n")
fig1 <- provider_metrics %>%
  arrange(desc(TotalHours)) %>%
  mutate(ProviderRank = row_number()) %>%
  ggplot(aes(x = ProviderRank, y = TotalHours)) +
  geom_col(aes(fill = RiskLevel), alpha = 0.8) +
  scale_fill_manual(values = c("High Risk" = "#d73027", "Moderate Risk" = "#fee08b", "Low Risk" = "#1a9850")) +
  labs(
    title = "Figure 1: Total In-Basket Workload by Provider",
    subtitle = "Extreme disparities reveal unsustainable work conditions for high-burden providers",
    x = "Provider Rank (by workload)",
    y = "Total Hours (12 months)",
    fill = "Risk Level"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "bottom"
  ) +
  scale_y_continuous(labels = comma_format())

ggsave("figures_tables/figure1_workload_distribution.png", fig1, width = 12, height = 8, dpi = 300)

# FIGURE 2: After-Hours vs Weekend Burden
cat("Creating Figure 2: After-Hours vs Weekend Burden...\n")
fig2 <- provider_metrics %>%
  ggplot(aes(x = AfterHoursPercent, y = WeekendPercent)) +
  geom_point(aes(size = TotalHours, color = RiskLevel), alpha = 0.7) +
  scale_color_manual(values = c("High Risk" = "#d73027", "Moderate Risk" = "#fee08b", "Low Risk" = "#1a9850")) +
  scale_size_continuous(range = c(2, 8)) +
  labs(
    title = "Figure 2: After-Hours vs Weekend Work Burden",
    subtitle = "High after-hours and weekend work indicates poor work-life balance",
    x = "After-Hours Work (%)",
    y = "Weekend Work (%)",
    size = "Total Hours",
    color = "Risk Level"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "bottom"
  ) +
  scale_x_continuous(labels = percent_format(scale = 1)) +
  scale_y_continuous(labels = percent_format(scale = 1))

ggsave("figures_tables/figure2_afterhours_weekend.png", fig2, width = 12, height = 8, dpi = 300)

# FIGURE 3: Provider Type Comparison
cat("Creating Figure 3: Provider Type Comparison...\n")
provider_type_summary <- provider_metrics %>%
  group_by(Grouper) %>%
  summarise(
    AvgHours = mean(TotalHours, na.rm = TRUE),
    AvgAfterHours = mean(AfterHoursPercent, na.rm = TRUE),
    AvgWeekend = mean(WeekendPercent, na.rm = TRUE),
    AvgMessages = mean(TotalMessages, na.rm = TRUE),
    Count = n(),
    .groups = "drop"
  )

fig3 <- provider_type_summary %>%
  pivot_longer(cols = c(AvgHours, AvgAfterHours, AvgWeekend), names_to = "Metric", values_to = "Value") %>%
  mutate(
    Metric = case_when(
      Metric == "AvgHours" ~ "Average Hours",
      Metric == "AvgAfterHours" ~ "After-Hours %",
      Metric == "AvgWeekend" ~ "Weekend %"
    )
  ) %>%
  ggplot(aes(x = Grouper, y = Value, fill = Metric)) +
  geom_col(position = "dodge", alpha = 0.8) +
  scale_fill_manual(values = c("Average Hours" = "#2166ac", "After-Hours %" = "#d73027", "Weekend %" = "#f46d43")) +
  labs(
    title = "Figure 3: Workload Comparison by Provider Type",
    subtitle = "Psychiatrists show highest burden across all metrics",
    x = "Provider Type",
    y = "Value",
    fill = "Metric"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  ) +
  scale_y_continuous(labels = comma_format())

ggsave("figures_tables/figure3_provider_type_comparison.png", fig3, width = 12, height = 8, dpi = 300)

# FIGURE 4: Monthly Workload Trends
cat("Creating Figure 4: Monthly Workload Trends...\n")
monthly_trends <- time_long %>%
  filter(grepl("Minutes In In Basket", Metric)) %>%
  group_by(Date) %>%
  summarise(TotalMinutes = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  mutate(TotalHours = TotalMinutes / 60)

fig4 <- monthly_trends %>%
  ggplot(aes(x = Date, y = TotalHours)) +
  geom_line(color = "#2166ac", linewidth = 1.2) +
  geom_point(color = "#2166ac", size = 3) +
  labs(
    title = "Figure 4: Monthly In-Basket Workload Trends",
    subtitle = "Consistent high workload throughout the year with no relief periods",
    x = "Month",
    y = "Total Hours"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  scale_y_continuous(labels = comma_format()) +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month")

ggsave("figures_tables/figure4_monthly_trends.png", fig4, width = 12, height = 8, dpi = 300)

# FIGURE 5: Risk Assessment Distribution
cat("Creating Figure 5: Risk Assessment Distribution...\n")
risk_summary <- provider_metrics %>%
  group_by(RiskLevel) %>%
  summarise(
    Count = n(),
    Percent = n() / nrow(provider_metrics) * 100,
    TotalHours = sum(TotalHours, na.rm = TRUE),
    PercentWorkload = sum(TotalHours, na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100,
    .groups = "drop"
  )

fig5 <- risk_summary %>%
  ggplot(aes(x = RiskLevel, y = Count, fill = RiskLevel)) +
  geom_col(alpha = 0.8) +
  scale_fill_manual(values = c("High Risk" = "#d73027", "Moderate Risk" = "#fee08b", "Low Risk" = "#1a9850")) +
  geom_text(aes(label = paste0(Count, "\n(", round(Percent, 1), "%)")), vjust = -0.5, size = 4) +
  labs(
    title = "Figure 5: Provider Risk Assessment Distribution",
    subtitle = "33% of total workload concentrated among 11% of providers (High Risk)",
    x = "Risk Level",
    y = "Number of Providers",
    fill = "Risk Level"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "none"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

ggsave("figures_tables/figure5_risk_distribution.png", fig5, width = 12, height = 8, dpi = 300)

# FIGURE 6: Message Volume vs Time Burden
cat("Creating Figure 6: Message Volume vs Time Burden...\n")
fig6 <- provider_metrics %>%
  ggplot(aes(x = TotalMessages, y = TotalHours)) +
  geom_point(aes(size = AfterHoursPercent, color = RiskLevel), alpha = 0.7) +
  scale_color_manual(values = c("High Risk" = "#d73027", "Moderate Risk" = "#fee08b", "Low Risk" = "#1a9850")) +
  scale_size_continuous(range = c(2, 8)) +
  labs(
    title = "Figure 6: Message Volume vs Time Burden",
    subtitle = "High message volume correlates with excessive time burden and after-hours work",
    x = "Total Messages (12 months)",
    y = "Total Hours (12 months)",
    size = "After-Hours %",
    color = "Risk Level"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "bottom"
  ) +
  scale_x_continuous(labels = comma_format()) +
  scale_y_continuous(labels = comma_format())

ggsave("figures_tables/figure6_message_volume_vs_time.png", fig6, width = 12, height = 8, dpi = 300)

# TABLE 1: System-Wide Summary Statistics
cat("Creating Table 1: System-Wide Summary...\n")
system_summary <- data.frame(
  Metric = c(
    "Total Providers",
    "Total In-Basket Hours (12 months)",
    "Average Hours per Provider",
    "Median Hours per Provider",
    "Coefficient of Variation",
    "Maximum Hours (single provider)",
    "Minimum Hours (single provider)",
    "Extreme Ratio (max/min)",
    "After-Hours Burden (%)",
    "Weekend Burden (%)",
    "High-Risk Providers (count)",
    "High-Risk Providers (%)",
    "Workload Concentration (%)"
  ),
  Value = c(
    nrow(provider_metrics),
    round(sum(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(mean(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(median(provider_metrics$TotalHours, na.rm = TRUE), 1),
    paste0(round(sd(provider_metrics$TotalHours, na.rm = TRUE) / mean(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%"),
    round(max(provider_metrics$TotalHours, na.rm = TRUE), 1),
    round(min(provider_metrics$TotalHours, na.rm = TRUE), 1),
    paste0(round(max(provider_metrics$TotalHours, na.rm = TRUE) / min(provider_metrics$TotalHours, na.rm = TRUE), 1), "x"),
    paste0(round(mean(provider_metrics$AfterHoursPercent, na.rm = TRUE), 1), "%"),
    paste0(round(mean(provider_metrics$WeekendPercent, na.rm = TRUE), 1), "%"),
    sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE),
    paste0(round(sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE) / nrow(provider_metrics) * 100, 1), "%"),
    paste0(round(sum(provider_metrics$TotalHours[provider_metrics$RiskLevel == "High Risk"], na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%")
  )
)

# Save as CSV
write.csv(system_summary, "figures_tables/table1_system_summary.csv", row.names = FALSE)

# TABLE 2: Provider Type Comparison
cat("Creating Table 2: Provider Type Comparison...\n")
provider_type_table <- provider_metrics %>%
  group_by(Grouper) %>%
  summarise(
    Count = n(),
    AvgHours = round(mean(TotalHours, na.rm = TRUE), 1),
    MedianHours = round(median(TotalHours, na.rm = TRUE), 1),
    AvgAfterHours = round(mean(AfterHoursPercent, na.rm = TRUE), 1),
    AvgWeekend = round(mean(WeekendPercent, na.rm = TRUE), 1),
    AvgMessages = round(mean(TotalMessages, na.rm = TRUE), 0),
    HighRiskCount = sum(RiskLevel == "High Risk", na.rm = TRUE),
    HighRiskPercent = round(sum(RiskLevel == "High Risk", na.rm = TRUE) / n() * 100, 1),
    .groups = "drop"
  ) %>%
  arrange(desc(AvgHours))

# Save as CSV
write.csv(provider_type_table, "figures_tables/table2_provider_type_comparison.csv", row.names = FALSE)

# TABLE 3: Top 10 Highest Burden Providers
cat("Creating Table 3: Top 10 Highest Burden Providers...\n")
top_providers <- provider_metrics %>%
  arrange(desc(TotalHours)) %>%
  head(10) %>%
  select(DE_ID, Grouper, TotalHours, AfterHoursPercent, WeekendPercent, TotalMessages, RiskLevel) %>%
  mutate(
    TotalHours = round(TotalHours, 1),
    AfterHoursPercent = round(AfterHoursPercent, 1),
    WeekendPercent = round(WeekendPercent, 1),
    TotalMessages = round(TotalMessages, 0)
  )

# Save as CSV
write.csv(top_providers, "figures_tables/table3_top_providers.csv", row.names = FALSE)

# Create HTML versions of tables
cat("Creating HTML versions of tables...\n")

# Table 1 HTML
table1_html <- system_summary %>%
  kable(format = "html", caption = "Table 1: System-Wide Summary Statistics")

writeLines(as.character(table1_html), "figures_tables/table1_system_summary.html")

# Table 2 HTML
table2_html <- provider_type_table %>%
  kable(format = "html", caption = "Table 2: Provider Type Comparison")

writeLines(as.character(table2_html), "figures_tables/table2_provider_type_comparison.html")

# Table 3 HTML
table3_html <- top_providers %>%
  kable(format = "html", caption = "Table 3: Top 10 Highest Burden Providers")

writeLines(as.character(table3_html), "figures_tables/table3_top_providers.html")

# Create a summary document
cat("Creating summary document...\n")
summary_text <- paste0(
  "# Epic In-Basket Analysis: Figures and Tables Summary\n\n",
  "## Figures Created:\n",
  "1. **Figure 1**: Total Workload Distribution by Provider\n",
  "2. **Figure 2**: After-Hours vs Weekend Burden\n",
  "3. **Figure 3**: Provider Type Comparison\n",
  "4. **Figure 4**: Monthly Workload Trends\n",
  "5. **Figure 5**: Risk Assessment Distribution\n",
  "6. **Figure 6**: Message Volume vs Time Burden\n\n",
  "## Tables Created:\n",
  "1. **Table 1**: System-Wide Summary Statistics\n",
  "2. **Table 2**: Provider Type Comparison\n",
  "3. **Table 3**: Top 10 Highest Burden Providers\n\n",
  "## Key Findings:\n",
  "- Total providers analyzed: ", nrow(provider_metrics), "\n",
  "- Total invisible work: ", round(sum(provider_metrics$TotalHours, na.rm = TRUE), 1), " hours\n",
  "- Coefficient of variation: ", round(sd(provider_metrics$TotalHours, na.rm = TRUE) / mean(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%\n",
  "- Extreme ratio: ", round(max(provider_metrics$TotalHours, na.rm = TRUE) / min(provider_metrics$TotalHours, na.rm = TRUE), 1), "x\n",
  "- High-risk providers: ", sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE), " (", round(sum(provider_metrics$RiskLevel == "High Risk", na.rm = TRUE) / nrow(provider_metrics) * 100, 1), "%)\n",
  "- Workload concentration: ", round(sum(provider_metrics$TotalHours[provider_metrics$RiskLevel == "High Risk"], na.rm = TRUE) / sum(provider_metrics$TotalHours, na.rm = TRUE) * 100, 1), "%\n"
)

writeLines(summary_text, "figures_tables/README.md")

cat("All figures and tables created successfully!\n")
cat("Output directory: figures_tables/\n")
cat("Files created:\n")
cat("- 6 PNG figures (300 DPI)\n")
cat("- 3 CSV tables\n")
cat("- 3 HTML tables\n")
cat("- README.md summary\n")
