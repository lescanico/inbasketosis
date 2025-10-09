# Comprehensive correlation analysis: explore all meaningful relationships
suppressMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
})

# Load and reshape data
dat <- read_csv("data/raw/PEP Data - Lescano N 07_2024-06_2025 v2.csv", 
                locale = locale(grouping_mark=","), show_col_types = FALSE)

long <- dat %>%
  pivot_longer(cols = 4:ncol(dat), names_to = "month", values_to = "value") %>%
  mutate(value = suppressWarnings(as.numeric(value)))

# Aggregate to provider totals
prov <- long %>%
  group_by(DE_ID, Grouper, Metric) %>%
  summarise(total = sum(value, na.rm = TRUE), .groups="drop") %>%
  pivot_wider(names_from = Metric, values_from = total) %>%
  transmute(
    DE_ID,
    provider_type = dplyr::recode(Grouper,
      "PHYSICIAN + PSYCHIATRIST" = "Attending Psychiatrist",
      "RESIDENT + FELLOW" = "Psychiatry Resident/Fellow", 
      "NURSE PRACTITIONER" = "Nurse Practitioner",
      .default = Grouper
    ),
    days_in_system = `Count Of Days In System`,
    days_scheduled = `Count Of Scheduled Days`,
    appointments = `Count Of Appointments`,
    system_minutes = `Count Of Minutes In The System`,
    after_hours_minutes = `Count Of Minutes Active Outside 7AM to 7PM`,
    unscheduled_minutes = `Count Of Minutes Active On Unscheduled Days`,
    sunday_minutes = `Count Of Sunday Minutes`,
    saturday_minutes = `Count Of Saturday Minutes`,
    scheduled_hours_per_day = `Scheduled Hours per Day`,
    # Calculate derived metrics
    inbox_minutes = `Minutes In In Basket Per Appointment` * `Count Of Appointments`,
    notes_minutes = `Minutes In Notes/Letters Per Appointment` * `Count Of Appointments`,
    clinical_review_minutes = `Minutes In Clinical Review Per Appointment` * `Count Of Appointments`,
    orders_minutes = `Minutes In Orders Per Appointment` * `Count Of Appointments`,
    # Per-day rates
    system_min_per_day = system_minutes / pmax(days_in_system, 1),
    appointments_per_day = appointments / pmax(days_in_system, 1),
    # After-hours percentage
    after_hours_pct = (after_hours_minutes / pmax(system_minutes, 1)) * 100,
    # Efficiency metrics
    minutes_per_appointment = system_minutes / pmax(appointments, 1),
    inbox_per_appointment = inbox_minutes / pmax(appointments, 1)
  ) %>%
  filter(!is.na(days_in_system), days_in_system >= 30,
         !is.na(appointments), !is.na(system_minutes))

cat("=== PROVIDER-LEVEL CORRELATION ANALYSIS ===\n")
cat("Sample size:", nrow(prov), "providers\n\n")

# 1. Core workload correlations
cat("1. CORE WORKLOAD CORRELATIONS:\n")
core_vars <- c("appointments", "system_minutes", "inbox_minutes", "notes_minutes", 
               "clinical_review_minutes", "orders_minutes", "after_hours_minutes")
core_cor <- cor(prov[core_vars], use = "complete.obs", method = "pearson")
print(round(core_cor, 3))

# 2. Efficiency and intensity correlations
cat("\n2. EFFICIENCY & INTENSITY CORRELATIONS:\n")
efficiency_vars <- c("minutes_per_appointment", "inbox_per_appointment", 
                     "system_min_per_day", "appointments_per_day", 
                     "after_hours_pct", "scheduled_hours_per_day")
efficiency_cor <- cor(prov[efficiency_vars], use = "complete.obs", method = "pearson")
print(round(efficiency_cor, 3))

# 3. After-hours and weekend work patterns
cat("\n3. AFTER-HOURS & WEEKEND PATTERNS:\n")
afterhours_vars <- c("after_hours_minutes", "sunday_minutes", "saturday_minutes", 
                     "unscheduled_minutes", "after_hours_pct", "system_minutes")
afterhours_cor <- cor(prov[afterhours_vars], use = "complete.obs", method = "pearson")
print(round(afterhours_cor, 3))

# 4. Provider type analysis
cat("\n4. PROVIDER TYPE DIFFERENCES:\n")
provider_summary <- prov %>%
  group_by(provider_type) %>%
  summarise(
    n = n(),
    mean_appointments = mean(appointments, na.rm = TRUE),
    mean_system_minutes = mean(system_minutes, na.rm = TRUE),
    mean_inbox_minutes = mean(inbox_minutes, na.rm = TRUE),
    mean_after_hours_pct = mean(after_hours_pct, na.rm = TRUE),
    mean_minutes_per_appt = mean(minutes_per_appointment, na.rm = TRUE),
    .groups = "drop"
  )
print(provider_summary)

# 5. Key relationships with appointments
cat("\n5. RELATIONSHIPS WITH APPOINTMENT VOLUME:\n")
appointment_correlations <- sapply(c("system_minutes", "inbox_minutes", "notes_minutes", 
                                    "clinical_review_minutes", "orders_minutes", 
                                    "after_hours_minutes", "sunday_minutes", "saturday_minutes"), 
                                  function(x) {
                                    if(x %in% names(prov)) {
                                      cor(prov$appointments, prov[[x]], use = "complete.obs", method = "pearson")
                                    } else NA
                                  })
appointment_cor_df <- data.frame(
  metric = names(appointment_correlations),
  correlation = round(appointment_correlations, 3)
) %>% arrange(desc(abs(correlation)))
print(appointment_cor_df)

# 6. After-hours work drivers
cat("\n6. AFTER-HOURS WORK DRIVERS:\n")
afterhours_drivers <- sapply(c("appointments", "system_minutes", "inbox_minutes", 
                              "notes_minutes", "clinical_review_minutes", "orders_minutes"), 
                            function(x) {
                              if(x %in% names(prov)) {
                                cor(prov$after_hours_minutes, prov[[x]], use = "complete.obs", method = "pearson")
                              } else NA
                            })
afterhours_drivers_df <- data.frame(
  metric = names(afterhours_drivers),
  correlation_with_afterhours = round(afterhours_drivers, 3)
) %>% arrange(desc(abs(correlation_with_afterhours)))
print(afterhours_drivers_df)

# 7. Workload intensity patterns
cat("\n7. WORKLOAD INTENSITY PATTERNS:\n")
intensity_vars <- c("system_min_per_day", "appointments_per_day", "after_hours_pct", 
                   "minutes_per_appointment", "inbox_per_appointment")
intensity_cor <- cor(prov[intensity_vars], use = "complete.obs", method = "pearson")
print(round(intensity_cor, 3))

# 8. Weekend work analysis
cat("\n8. WEEKEND WORK ANALYSIS:\n")
weekend_analysis <- prov %>%
  filter(sunday_minutes > 0 | saturday_minutes > 0) %>%
  summarise(
    n_providers_with_weekend_work = n(),
    mean_sunday_minutes = mean(sunday_minutes, na.rm = TRUE),
    mean_saturday_minutes = mean(saturday_minutes, na.rm = TRUE),
    weekend_work_correlation_with_appointments = cor(appointments, sunday_minutes + saturday_minutes, use = "complete.obs"),
    weekend_work_correlation_with_system = cor(system_minutes, sunday_minutes + saturday_minutes, use = "complete.obs")
  )
print(weekend_analysis)

# 9. High-burden provider characteristics
cat("\n9. HIGH-BURDEN PROVIDER CHARACTERISTICS:\n")
high_burden <- prov %>%
  filter(system_minutes > quantile(system_minutes, 0.75, na.rm = TRUE)) %>%
  summarise(
    n_high_burden = n(),
    mean_appointments = mean(appointments, na.rm = TRUE),
    mean_after_hours_pct = mean(after_hours_pct, na.rm = TRUE),
    mean_minutes_per_appt = mean(minutes_per_appointment, na.rm = TRUE),
    mean_inbox_per_appt = mean(inbox_per_appointment, na.rm = TRUE),
    provider_type_distribution = paste(table(provider_type), collapse = ", ")
  )
print(high_burden)

# 10. Efficiency vs volume trade-offs
cat("\n10. EFFICIENCY VS VOLUME TRADE-OFFS:\n")
efficiency_volume <- cor(prov$appointments, prov$minutes_per_appointment, use = "complete.obs", method = "pearson")
inbox_efficiency_volume <- cor(prov$appointments, prov$inbox_per_appointment, use = "complete.obs", method = "pearson")
cat("Appointments vs Minutes per Appointment:", round(efficiency_volume, 3), "\n")
cat("Appointments vs Inbox Minutes per Appointment:", round(inbox_efficiency_volume, 3), "\n")

# 11. Provider type-specific correlations
cat("\n11. PROVIDER TYPE-SPECIFIC CORRELATIONS:\n")
for(ptype in unique(prov$provider_type)) {
  ptype_data <- prov[prov$provider_type == ptype, ]
  if(nrow(ptype_data) >= 3) {
    cat("\n", ptype, ":\n")
    ptype_cor <- cor(ptype_data$appointments, ptype_data$system_minutes, use = "complete.obs", method = "pearson")
    ptype_inbox_cor <- cor(ptype_data$appointments, ptype_data$inbox_minutes, use = "complete.obs", method = "pearson")
    cat("  Appointments vs System Minutes:", round(ptype_cor, 3), "\n")
    cat("  Appointments vs Inbox Minutes:", round(ptype_inbox_cor, 3), "\n")
  }
}

cat("\n=== ANALYSIS COMPLETE ===\n")
