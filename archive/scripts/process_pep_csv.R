#!/usr/bin/env Rscript

# CSV-based processing for: PEP Data - Lescano N 07_2024-06_2025 v2.csv
# - Reads raw CSV (Time/Messages combined style: DE_ID, Grouper, Metric, months)
# - Maps long metric names to short codes provided by user
# - Tidies to long, coerces values to numeric, builds date index for months
# - Produces wide-by-metric per DE_ID/Grouper/month
# - Aggregates per DE_ID summaries (totals, normalized workload, after-hours %)
# - Writes outputs to data/processed

suppressMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(purrr)
  library(lubridate)
  library(readr)
})

# -----------------------------------------------------------------------------
# Config
# -----------------------------------------------------------------------------

input_csv <- file.path("data", "raw", "PEP Data - Lescano N 07_2024-06_2025 v2.csv")
output_dir <- file.path("data", "processed")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Month label to first-of-month date mapping
month_map <- c(
  "24-Jul" = "2024-07-01",
  "24-Aug" = "2024-08-01",
  "24-Sep" = "2024-09-01",
  "24-Oct" = "2024-10-01",
  "24-Nov" = "2024-11-01",
  "24-Dec" = "2024-12-01",
  "25-Jan" = "2025-01-01",
  "25-Feb" = "2025-02-01",
  "25-Mar" = "2025-03-01",
  "25-Apr" = "2025-04-01",
  "25-May" = "2025-05-01",
  "25-Jun" = "2025-06-01"
)

# Metric mapping: short code -> long name
metric_map <- c(
  # === Schedule Metrics ===
  CA = "Count Of Appointments",
  SHPD = "Scheduled Hours per Day",
  
  # === Day Counts ===
  CD_IRP = "Count Of Days In Reporting Period",
  CD_IS  = "Count Of Days In System",
  CD_SD  = "Count Of Scheduled Days",
  CD_WA  = "Count Of Days With Appointments",
  CD_AA  = "Count Of Days of Afterhours Activity",

  # === Minute Counts ===
  CM_IS   = "Count Of Minutes In The System",
  CM_USD  = "Count Of Minutes Active On Unscheduled Days",
  CM_OSH  = "Count Of Minutes Active Outside 7AM to 7PM",
  CM_OBUF = "Count Of Minutes Active Outside Scheduled Time (30 Min Buffer)",
  CM_IB   = "Count Of In Basket Minutes",

  # === Minutes per Appointment ===
  MPA_CR  = "Minutes In Clinical Review Per Appointment",
  MPA_IB  = "Minutes In In Basket Per Appointment",
  MPA_NL  = "Minutes In Notes/Letters Per Appointment",
  MPA_ORD = "Minutes In Orders Per Appointment",

  # === Minutes per Day ===
  MPD_CR  = "Minutes In Clinical Review Per Day",
  MPD_IB  = "Minutes In In Basket Per Day",
  MPD_OTH = "Minutes In Other Per Day",
  MPD_USD = "Minutes Active On Unscheduled Days Per Day",

  # === Weekend Metrics ===
  SAT_CM = "Count Of Saturday Minutes",
  SAT_PM = "% Of Minutes On Saturday",
  SUN_CM = "Count Of Sunday Minutes",
  SUN_PM = "% Of Minutes On Sunday",

  # === Message Metrics ===
  MSG_REC_CALL = "Count Of Patient Call Messages Received",
  MSG_REC_MAR  = "Count Of Patient Medical Advice Requests Messages Received",
  MSG_REC_RES  = "Count Of Result Messages Received",
  MSG_REC_RX   = "Count Of RX Auth Messages Received",

  MSG_INC_CALL = "Count Of Patient Call Messages Incomplete",
  MSG_INC_MAR  = "Count Of Patient Medical Advice Requests Messages Incomplete",
  MSG_INC_RES  = "Count Of Result Messages Incomplete",
  MSG_INC_RX   = "Count Of RX Auth Messages Incomplete",

  MSG_COM_CALL = "Count Of Patient Call Messages Completed",
  MSG_COM_MAR  = "Count Of Patient Medical Advice Requests Messages Completed",
  MSG_COM_RES  = "Count Of Result Messages Completed",
  MSG_COM_RX   = "Count Of RX Auth Messages Completed",

  MSG_PD_CALL  = "Messages Received per Day - Patient Calls",
  MSG_PD_MAR   = "Messages Received per Day - Patient Medical Advice Request",
  MSG_PD_RES   = "Messages Received per Day - Results",
  MSG_PD_RX    = "Messages Received per Day - Rx Auth",

  MSG_DTC_CALL = "Average Days Until Patient Call Messages Marked Done",
  MSG_DTC_MAR  = "Average Days Until Patient Medical Advice Request Message Marked Done",
  MSG_DTC_RES  = "Average Days Until Result Message Marked Done",
  MSG_DTC_RX   = "Average Days Until RX Auth Message Marked Done"
)

# Reverse lookup: long name -> short code
metric_rev <- setNames(names(metric_map), metric_map)

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

`%||%` <- function(a, b) if (!is.null(a)) a else b

parse_numeric <- function(x) {
  # Remove commas and coerce to numeric; keep NA for blanks
  if (is.numeric(x)) return(x)
  x |>
    str_replace_all(",", "") |>
    na_if("") |>
    as.numeric()
}

month_to_date <- function(x) {
  as.Date(unname(month_map[x]))
}

# -----------------------------------------------------------------------------
# Load
# -----------------------------------------------------------------------------

stopifnot(file.exists(input_csv))

raw <- suppressMessages(readr::read_csv(input_csv, show_col_types = FALSE))

# Trim column names (some have trailing spaces like "DE_ID ")
names(raw) <- str_trim(names(raw))

# Identify month columns present in file
month_cols <- intersect(names(raw), names(month_map))

# Tidy to long by month
long <- raw %>%
  mutate(across(all_of(month_cols), parse_numeric)) %>%
  pivot_longer(cols = all_of(month_cols), names_to = "MonthLabel", values_to = "Value") %>%
  mutate(
    Date = month_to_date(MonthLabel),
    MetricLong = Metric,
    MetricCode = metric_rev[MetricLong] %||% NA_character_
  ) %>%
  rename(DE_ID = `DE_ID`, ProviderGroup = Grouper) %>%
  mutate(
    DE_ID = as.character(DE_ID),
    ProviderGroup = as.character(ProviderGroup)
  )

# Wide by metric code per provider/month
wide <- long %>%
  select(DE_ID, ProviderGroup, Date, MetricCode, Value) %>%
  filter(!is.na(MetricCode)) %>%
  distinct() %>%
  pivot_wider(names_from = MetricCode, values_from = Value, values_fill = NA_real_)

# -----------------------------------------------------------------------------
# Aggregations by DE_ID
# -----------------------------------------------------------------------------

# Totals across months per DE_ID (sum of monthly values)
totals_by_provider <- long %>%
  filter(!is.na(MetricCode)) %>%
  group_by(DE_ID, ProviderGroup, MetricCode) %>%
  summarise(total_value = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = MetricCode, values_from = total_value, values_fill = 0)

# Normalized workload using CM_IS and CD_IS
provider_summary <- totals_by_provider %>%
  mutate(
    total_minutes_in_system = CM_IS %||% NA_real_,
    days_in_system = CD_IS %||% NA_real_,
    normalized_hours_year = ifelse(!is.na(total_minutes_in_system) & !is.na(days_in_system) & days_in_system > 0,
                                   (total_minutes_in_system / 60) * (365 / days_in_system),
                                   NA_real_),
    after_hours_percent = ifelse(!is.na(CM_OSH) & !is.na(CM_IS) & CM_IS > 0, (CM_OSH / CM_IS) * 100, NA_real_)
  )

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

write_csv(long, file.path(output_dir, "pep_long_by_month.csv"))
write_csv(wide, file.path(output_dir, "pep_wide_by_metric.csv"))
write_csv(provider_summary, file.path(output_dir, "processed_provider_analysis.csv"))

# Minimal risk-style data and after-hours data for downstream compatibility
risk_data <- provider_summary %>%
  select(DE_ID, ProviderGroup, normalized_hours_year, CM_IS) %>%
  filter(!is.na(normalized_hours_year))

after_hours_summary <- provider_summary %>%
  select(DE_ID, ProviderGroup, total_after_hours_minutes = CM_OSH, total_system_minutes = CM_IS, after_hours_percent) %>%
  mutate(across(everything(), ~ .x))

write_csv(risk_data, file.path(output_dir, "processed_risk_data.csv"))
write_csv(after_hours_summary, file.path(output_dir, "processed_after_hours_data.csv"))

# Summary statistics
summary_stats <- list(
  total_providers = nrow(provider_summary),
  providers_with_normalized = sum(!is.na(provider_summary$normalized_hours_year)),
  total_system_hours = sum(provider_summary$CM_IS, na.rm = TRUE) / 60,
  median_normalized_hours = median(provider_summary$normalized_hours_year, na.rm = TRUE),
  mean_after_hours_percent = mean(provider_summary$after_hours_percent, na.rm = TRUE)
)

saveRDS(summary_stats, file.path(output_dir, "summary_statistics.rds"))

cat("CSV processing completed. Outputs written to:", output_dir, "\n")


