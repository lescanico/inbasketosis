# Correlation analysis: appointments vs system/inbox minutes
suppressMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
})

# Load and reshape data
dat <- read_csv("data/raw/PEP Data - Lescano N 07_2024-06_2025 v2.csv", 
                locale = locale(grouping_mark=","))

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
    appointments = `Count Of Appointments`,
    system_minutes = `Count Of Minutes In The System`,
    inbox_minutes = `Minutes In In Basket Per Appointment` * `Count Of Appointments`
  ) %>%
  filter(!is.na(days_in_system), days_in_system >= 30,
         !is.na(appointments), !is.na(system_minutes))

# Correlations
cors <- list(
  system_pearson = cor(prov$appointments, prov$system_minutes, use="complete.obs", method="pearson"),
  system_spearman = cor(prov$appointments, prov$system_minutes, use="complete.obs", method="spearman"),
  inbox_pearson = cor(prov$appointments, prov$inbox_minutes, use="complete.obs", method="pearson"),
  inbox_spearman = cor(prov$appointments, prov$inbox_minutes, use="complete.obs", method="spearman")
)

# Linear slopes (minutes per appointment)
lm_sys <- lm(system_minutes ~ appointments, data = prov)
lm_ib <- lm(inbox_minutes ~ appointments, data = prov)

slopes <- list(
  system_minutes_per_appt = unname(coef(lm_sys)[2]),
  inbox_minutes_per_appt = unname(coef(lm_ib)[2])
)

# Per-appointment rates
prov <- prov %>%
  mutate(
    system_min_per_appt = system_minutes / pmax(appointments, 1),
    inbox_min_per_appt = inbox_minutes / pmax(appointments, 1)
  )

summ <- prov %>%
  summarise(
    n_providers = n(),
    system_min_per_appt_median = median(system_min_per_appt, na.rm=TRUE),
    system_min_per_appt_iqr = IQR(system_min_per_appt, na.rm=TRUE),
    inbox_min_per_appt_median = median(inbox_min_per_appt, na.rm=TRUE),
    inbox_min_per_appt_iqr = IQR(inbox_min_per_appt, na.rm=TRUE)
  )

# Print results
cat("CORRELATIONS:\n")
print(cors)
cat("\nSLOPES (minutes per appointment):\n")
print(slopes)
cat("\nSUMMARY STATS:\n")
print(summ)

# Adjusted models
cat("\n\nADJUSTED MODELS:\n")
lm_sys_adj <- lm(system_minutes ~ appointments + provider_type + days_in_system, data = prov)
cat("\nSystem minutes ~ appointments + provider_type + days_in_system:\n")
print(summary(lm_sys_adj))

lm_ib_adj <- lm(inbox_minutes ~ appointments + provider_type + days_in_system, data = prov)
cat("\n\nInbox minutes ~ appointments + provider_type + days_in_system:\n")
print(summary(lm_ib_adj))