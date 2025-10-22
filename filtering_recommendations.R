# Provider Filtering Recommendations for Fair Analysis
# Based on data exploration and research objectives

library(dplyr)

# Load the final dataset
final <- readRDS("data/engineered.rds")

# RECOMMENDED FILTERING APPROACH

# Option 1: Conservative filtering (recommended for main analysis)
filtered_conservative <- final %>%
  filter(
    n_months >= 6,           # At least 6 months of data
    apt_tot >= 50,            # At least 50 appointments
    sch_hrs_tot >= 50,         # At least 50 scheduled hours
    ib_hrs >= 10             # At least 10 in-basket hours
  )

# Option 2: More restrictive filtering (for sensitivity analysis)
filtered_restrictive <- final %>%
  filter(
    n_months >= 9,           # At least 9 months of data
    apt_tot >= 100,           # At least 100 appointments
    sch_hrs_tot >= 100,        # At least 100 scheduled hours
    ib_hrs >= 20             # At least 20 in-basket hours
  )

# Option 3: Minimal filtering (for maximum sample size)
filtered_minimal <- final %>%
  filter(
    n_months >= 3,           # At least 3 months of data
    apt_tot >= 25,            # At least 25 appointments
    sch_hrs_tot >= 25,         # At least 25 scheduled hours
    ib_hrs >= 5              # At least 5 in-basket hours
  )

# Compare sample sizes
cat("Original sample size:", nrow(final), "\n")
cat("Conservative filtering:", nrow(filtered_conservative), "\n")
cat("Restrictive filtering:", nrow(filtered_restrictive), "\n")
cat("Minimal filtering:", nrow(filtered_minimal), "\n")

# Check provider type distribution after filtering
cat("\nProvider type distribution after conservative filtering:\n")
print(table(filtered_conservative$type))

cat("\nProvider group distribution after conservative filtering:\n")
print(table(filtered_conservative$group))

# Check data quality metrics
cat("\nData quality after conservative filtering:\n")
quality_summary <- filtered_conservative %>%
  summarise(
    mean_months = mean(n_months),
    min_months = min(n_months),
    max_months = max(n_months),
    mean_appt = mean(n_appt),
    mean_sch_hrs = mean(n_sch_hrs),
    mean_ib_hrs = mean(ib_hrs)
  )
print(quality_summary)

# Save filtered datasets
saveRDS(filtered_conservative, "data/final_filtered_conservative.rds")
saveRDS(filtered_restrictive, "data/final_filtered_restrictive.rds")
saveRDS(filtered_minimal, "data/final_filtered_minimal.rds")

# EXCLUSION RATIONALE DOCUMENTATION
cat("\n=== EXCLUSION RATIONALE ===\n")
cat("1. Minimum observation period: Ensures sufficient data for reliable metrics\n")
cat("2. Minimum activity thresholds: Removes providers with very low clinical activity\n")
cat("3. Maintains all provider types: Preserves role-based analysis capability\n")
cat("4. Balances sample size vs data quality: Conservative approach recommended\n")

# PROVIDERS EXCLUDED BY CONSERVATIVE FILTERING
excluded <- final %>%
  filter(
    n_months < 6 | apt_tot < 50 | sch_hrs_tot < 50 | ib_hrs < 10
  )

cat("\nProviders excluded by conservative filtering:\n")
print(excluded[, c("id", "type", "n_months", "n_appt", "n_sch_hrs", "ib_hrs")])
