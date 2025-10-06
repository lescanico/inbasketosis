#!/usr/bin/env Rscript

# Create Lorenz curve and Gini coefficient analysis for workload inequality
# This script generates sophisticated inequality metrics for the workload distribution

# Load required libraries
library(ggplot2)
library(dplyr)
library(scales)

# Calculate Gini coefficient manually (no external packages needed)
gini_coefficient <- function(x) {
  x <- sort(x)
  n <- length(x)
  cumsum_x <- cumsum(x)
  return((2 * sum((1:n) * x)) / (n * sum(x)) - (n + 1) / n)
}

# Set working directory
setwd("/workspace")

# Load the processed data
time_data <- read.csv("data/processed/processed_time_data.csv")

# Calculate Gini coefficient for normalized workload
gini_value <- gini_coefficient(time_data$normalized_hours_year)
cat("Gini coefficient for normalized workload:", round(gini_value, 3), "\n")

# Create Lorenz curve data
lorenz_data <- data.frame(
  provider_rank = 1:length(time_data$normalized_hours_year),
  cumulative_providers = (1:length(time_data$normalized_hours_year)) / length(time_data$normalized_hours_year),
  cumulative_workload = cumsum(sort(time_data$normalized_hours_year)) / sum(time_data$normalized_hours_year)
)

# Add perfect equality line
lorenz_data$perfect_equality <- lorenz_data$cumulative_providers

# Create Lorenz curve plot with UPenn colors and professional styling
p_lorenz <- ggplot(lorenz_data, aes(x = cumulative_providers, y = cumulative_workload)) +
  # Perfect equality line - use Penn Blue
  geom_line(aes(y = perfect_equality), color = "#011F5B", linetype = "dashed", linewidth = 1.5) +
  # Actual distribution curve - use Penn Red for main curve
  geom_line(color = "#990000", linewidth = 2.5) +
  # Inequality area - subtle Penn Blue fill
  geom_ribbon(aes(ymin = cumulative_providers, ymax = cumulative_workload), 
              alpha = 0.15, fill = "#011F5B") +
  # Key data points with Penn Red
  annotate("point", x = 0.1, y = 0.259, color = "#990000", size = 4, shape = 19) +
  annotate("point", x = 0.5, y = 0.262, color = "#990000", size = 4, shape = 19) +
  # Clean labels and annotations
  labs(
    title = "Lorenz Curve: Workload Distribution Inequality",
    subtitle = paste("Gini coefficient =", round(gini_value, 3), 
                    "• Top 10% handle 25.9% of workload"),
    x = "Cumulative Proportion of Providers (ranked by workload)",
    y = "Cumulative Proportion of Total Workload",
    caption = "Source: Epic Signal, July 2024–June 2025. All analyses conducted using de-identified Epic Analytics data."
  ) +
  scale_x_continuous(labels = percent_format(), limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  scale_y_continuous(labels = percent_format(), limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "#011F5B", margin = margin(b = 8)),
    plot.subtitle = element_text(size = 14, color = "#6B6B6B", margin = margin(b = 20)),
    axis.title = element_text(size = 13, color = "#011F5B", face = "bold"),
    axis.text = element_text(size = 12, color = "#6B6B6B"),
    panel.grid.major = element_line(color = "#E5E5E5", linewidth = 0.8),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    legend.position = "none",
    plot.margin = margin(30, 35, 30, 35),
    plot.caption = element_text(size = 10, color = "#6B6B6B", hjust = 0)
  ) +
  coord_cartesian(clip = "off") +
  # Clean, well-positioned annotations with UPenn colors
  annotate("label", x = 0.75, y = 0.25,
           label = "Perfect Equality\n(Gini = 0)",
           color = "#011F5B", fill = "white", label.size = 0,
           size = 4.2, hjust = 0, fontface = "bold", alpha = 0.95) +
  annotate("label", x = 0.25, y = 0.75,
           label = paste("Actual Distribution\n(Gini =", round(gini_value, 3), ")"),
           color = "#990000", fill = "white", label.size = 0,
           size = 4.2, hjust = 0, fontface = "bold", alpha = 0.95) +
  # Key statistics with improved positioning to avoid overlaps
  annotate("label", x = 0.12, y = 0.45,
           label = "Top 10%\n25.9%",
           color = "#990000", fill = "white", label.size = 0,
           size = 3.8, hjust = 0, fontface = "bold", alpha = 0.95) +
  annotate("label", x = 0.52, y = 0.45,
           label = "Bottom 50%\n26.2%",
           color = "#990000", fill = "white", label.size = 0,
           size = 3.8, hjust = 0, fontface = "bold", alpha = 0.95) +
  # Add subtle connecting lines to data points with Penn Red
  annotate("segment", x = 0.1, xend = 0.1, y = 0.259, yend = 0.42, 
           color = "#990000", linewidth = 0.8, alpha = 0.6) +
  annotate("segment", x = 0.5, xend = 0.5, y = 0.262, yend = 0.42, 
           color = "#990000", linewidth = 0.8, alpha = 0.6)

# Save the plot
ggsave("figures/Figure2_Lorenz_Curve_Workload_Inequality.png", 
       plot = p_lorenz, width = 8, height = 6, dpi = 300)

# Calculate additional inequality metrics
cat("\n=== WORKLOAD INEQUALITY ANALYSIS ===\n")
cat("Gini coefficient:", round(gini_value, 3), "\n")
cat("Coefficient of variation:", round(sd(time_data$normalized_hours_year) / mean(time_data$normalized_hours_year), 3), "\n")
cat("Max/Min ratio:", round(max(time_data$normalized_hours_year) / min(time_data$normalized_hours_year), 1), "x\n")

# Calculate what percentage of providers account for what percentage of workload
top_10_percent <- length(time_data$normalized_hours_year) * 0.1
top_10_workload <- sum(sort(time_data$normalized_hours_year, decreasing = TRUE)[1:ceiling(top_10_percent)])
total_workload <- sum(time_data$normalized_hours_year)
top_10_percent_share <- (top_10_workload / total_workload) * 100

cat("Top 10% of providers account for", round(top_10_percent_share, 1), "% of total workload\n")

# Calculate bottom 50% share
bottom_50_percent <- length(time_data$normalized_hours_year) * 0.5
bottom_50_workload <- sum(sort(time_data$normalized_hours_year)[1:ceiling(bottom_50_percent)])
bottom_50_percent_share <- (bottom_50_workload / total_workload) * 100

cat("Bottom 50% of providers account for", round(bottom_50_percent_share, 1), "% of total workload\n")

# Create a summary table
inequality_summary <- data.frame(
  Metric = c("Gini Coefficient", "Coefficient of Variation", "Max/Min Ratio", 
             "Top 10% Workload Share", "Bottom 50% Workload Share"),
  Value = c(round(gini_value, 3), 
            round(sd(time_data$normalized_hours_year) / mean(time_data$normalized_hours_year), 3),
            paste(round(max(time_data$normalized_hours_year) / min(time_data$normalized_hours_year), 1), "x"),
            paste(round(top_10_percent_share, 1), "%"),
            paste(round(bottom_50_percent_share, 1), "%")),
  Interpretation = c(
    "0 = perfect equality, 1 = perfect inequality",
    "Standard deviation / mean",
    "Highest to lowest workload ratio",
    "Concentration of workload among high-burden providers",
    "Workload share of lower-burden providers"
  )
)

# Save inequality summary
write.csv(inequality_summary, "tables/Table2_Inequality_Metrics.csv", row.names = FALSE)

cat("\n=== INEQUALITY SUMMARY TABLE ===\n")
print(inequality_summary)

cat("\nLorenz curve saved to: figures/Figure2_Lorenz_Curve_Workload_Inequality.png\n")
cat("Inequality metrics saved to: tables/Table2_Inequality_Metrics.csv\n")
