#!/usr/bin/env Rscript

# Purpose: Build reduced dataset and key figures/tables from data/raw/pep_clean.csv
# Outputs:
# - data/processed/pep_reduced.csv
# - tables/pep_deciles_summary.csv
# - figures/threshold_boxplots.png
# - figures/responsiveness_vs_appointments_threshold.png
# - figures/lorenz_workload.png
# - figures/funnel_completion_vs_messages.png

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(janitor)
  library(ggplot2)
  library(scales)
})

# -----------------------------
# 1) Load data
# -----------------------------

input_path <- "data/raw/pep_clean.csv"
if (!file.exists(input_path)) {
  stop(sprintf("Input not found: %s", input_path))
}

raw <- read_csv(input_path, show_col_types = FALSE, na = c("", "NA", "N/A"))

# Expect long metric layout or already wide. We standardize by name cleanup.
raw <- raw %>% clean_names()

# Heuristic: if columns include Metric-like fields, reshape; else assume already wide
has_metric_cols <- all(c("metric", "value") %in% names(raw))

if (has_metric_cols) {
  # Assume columns: id, metric, value (possibly with Grouper/DE_ID)
  raw <- raw %>%
    mutate(metric = str_replace_all(metric, "Recieved", "Received")) %>%
    distinct(id, metric, .keep_all = TRUE) %>%
    pivot_wider(names_from = metric, values_from = value) %>%
    clean_names()
}

# -----------------------------
# 2) Derive core variables (robust to missing names)
# -----------------------------

get_col <- function(df, candidates, default = NA_real_) {
  nm <- candidates[candidates %in% names(df)]
  if (length(nm) == 0) return(rep(default, nrow(df)))
  df[[nm[1]]]
}

df <- raw %>% mutate(
  id = coalesce(get_col(raw, c("id"), NA_character_), as.character(row_number())),
  count_of_appointments = get_col(raw, c("count_of_appointments"), 0),
  count_of_days_in_system = get_col(raw, c("count_of_days_in_system"), NA_real_),
  count_of_scheduled_days = get_col(raw, c("count_of_scheduled_days"), NA_real_),
  scheduled_hours_per_day = get_col(raw, c("scheduled_hours_per_day"), NA_real_),
  count_of_minutes_in_the_system = get_col(raw, c("count_of_minutes_in_the_system"), NA_real_),
  count_of_in_basket_minutes = get_col(raw, c("count_of_in_basket_minutes"), NA_real_),
  total_messages_received = get_col(raw, c("total_messages_received"), NA_real_),
  total_messages_completed = get_col(raw, c("total_messages_completed"), NA_real_),
  total_messages_incomplete = get_col(raw, c("total_messages_incomplete"), NA_real_),
  message_completion_rate = {
    comp <- get_col(raw, c("message_completion_rate"), NA_real_)
    if (all(is.na(comp))) {
      comp_num <- get_col(raw, c("total_messages_completed"), NA_real_)
      comp_den <- get_col(raw, c("total_messages_completed"), NA_real_) + get_col(raw, c("total_messages_incomplete"), NA_real_)
      comp <- ifelse(comp_den > 0, comp_num / comp_den, NA_real_)
    }
    comp
  },
  avg_days_to_complete = get_col(raw, c("avg_days_to_complete", "average_days_to_complete"), NA_real_),
  percent_weekend_minutes = get_col(raw, c("percent_weekend_minutes"), NA_real_),
  afterhours_minutes_ratio = get_col(raw, c("afterhours_minutes_ratio", "outside_hours_ratio"), NA_real_),
  minutes_in_in_basket_per_appointment = get_col(raw, c("minutes_in_in_basket_per_appointment", "inbox_minutes_per_appointment"), NA_real_),
  minutes_per_appointment = get_col(raw, c("minutes_per_appointment", "system_minutes_per_appointment"), NA_real_),
  inbox_minutes_per_day = get_col(raw, c("inbox_minutes_per_day"), NA_real_),
  inbox_minutes_per_message = get_col(raw, c("inbox_minutes_per_message", "inbox_minutes_per_received_message"), NA_real_),
  appointments_per_day = get_col(raw, c("appointments_per_day", "appointments_per_scheduled_day"), NA_real_),
  provider_type = sub("_.*$", "", coalesce(get_col(raw, c("id"), NA_character_), as.character(row_number())))
)

# Guard denominators
df <- df %>% mutate(
  minutes_per_appointment = ifelse(is.na(minutes_per_appointment) & !is.na(count_of_minutes_in_the_system),
                                   count_of_minutes_in_the_system / pmax(count_of_appointments, 1),
                                   minutes_per_appointment),
  inbox_minutes_per_appointment = ifelse(is.na(minutes_in_in_basket_per_appointment) & !is.na(count_of_in_basket_minutes),
                                         count_of_in_basket_minutes / pmax(count_of_appointments, 1),
                                         minutes_in_in_basket_per_appointment),
  inbox_minutes_per_message = ifelse(is.na(inbox_minutes_per_message) & !is.na(count_of_in_basket_minutes),
                                     count_of_in_basket_minutes / pmax(total_messages_received, 1),
                                     inbox_minutes_per_message)
)

# Threshold group: appointments <=1000 vs >1000
df <- df %>% mutate(
  volume_group = case_when(
    is.na(count_of_appointments) ~ NA_character_,
    count_of_appointments > 1000 ~ ">1000",
    TRUE ~ "<=1000"
  )
)

# -----------------------------
# 3) Reduced dataset
# -----------------------------

reduced <- df %>% transmute(
  id, provider_type,
  appointments = count_of_appointments,
  days_in_system = count_of_days_in_system,
  scheduled_hours_per_day,
  system_minutes = count_of_minutes_in_the_system,
  inbasket_minutes = count_of_in_basket_minutes,
  minutes_per_appointment,
  inbasket_minutes_per_appointment = inbox_minutes_per_appointment,
  afterhours_ratio = afterhours_minutes_ratio,
  weekend_ratio = percent_weekend_minutes,
  messages_total = total_messages_received,
  completion_rate = message_completion_rate,
  avg_days_to_complete,
  appointments_per_day,
  inbox_minutes_per_day,
  inbox_minutes_per_message,
  system_min_per_100_appts = ifelse(appointments > 0, 100 * system_minutes / appointments, NA_real_),
  inbasket_min_per_100_appts = ifelse(appointments > 0, 100 * inbasket_minutes / appointments, NA_real_),
  volume_group
)

out_reduced <- "data/processed/pep_reduced.csv"
dir.create(dirname(out_reduced), showWarnings = FALSE, recursive = TRUE)
write_csv(reduced, out_reduced)
message(sprintf("Wrote: %s", out_reduced))

# -----------------------------
# 4) Threshold split boxplots
# -----------------------------

fig_threshold <- "figures/threshold_boxplots.png"
dir.create("figures", showWarnings = FALSE)

p1 <- ggplot(reduced, aes(x = volume_group, y = avg_days_to_complete, fill = volume_group)) +
  geom_boxplot(outlier.alpha = 0.3) +
  scale_fill_brewer(palette = "Set2", na.translate = FALSE) +
  labs(x = "Appointments group", y = "Avg days to complete", title = "Responsiveness by appointment volume") +
  theme_minimal(base_size = 12) + theme(legend.position = "none")

p2 <- ggplot(reduced, aes(x = volume_group, y = afterhours_ratio, fill = volume_group)) +
  geom_boxplot(outlier.alpha = 0.3) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  scale_fill_brewer(palette = "Set2", na.translate = FALSE) +
  labs(x = "Appointments group", y = "After-hours minutes ratio", title = "After-hours burden by appointment volume") +
  theme_minimal(base_size = 12) + theme(legend.position = "none")

g <- patchwork::wrap_plots(p1, p2, ncol = 2)

ggsave(fig_threshold, g, width = 10, height = 4.5, dpi = 150)
message(sprintf("Wrote: %s", fig_threshold))

# -----------------------------
# 5) Responsiveness vs appointments with simple piecewise-like fit
# -----------------------------

fig_resp <- "figures/responsiveness_vs_appointments_threshold.png"

df_pw <- reduced %>% mutate(
  x = appointments,
  x1 = pmin(x, 1000),
  x2 = pmax(x - 1000, 0)
)

fit <- lm(avg_days_to_complete ~ x1 + x2, data = df_pw)

p_pw <- ggplot(df_pw, aes(x = appointments, y = avg_days_to_complete)) +
  geom_point(alpha = 0.6) +
  geom_vline(xintercept = 1000, linetype = "dashed", color = "firebrick") +
  stat_smooth(method = "lm", formula = y ~ x1 + x2, se = FALSE, color = "steelblue") +
  labs(title = "Avg days to complete vs appointments (piecewise proxy)",
       x = "Appointments/year", y = "Avg days to complete") +
  theme_minimal(base_size = 12)

ggsave(fig_resp, p_pw, width = 7, height = 4.5, dpi = 150)
message(sprintf("Wrote: %s", fig_resp))

# -----------------------------
# 6) Lorenz curve for workload inequality (system & inbox minutes)
# -----------------------------

fig_lorenz <- "figures/lorenz_workload.png"

lorenz_prep <- function(x) {
  x <- x[is.finite(x) & !is.na(x)]
  n <- length(x)
  if (n == 0) return(tibble(p = numeric(0), L = numeric(0)))
  xs <- sort(x)
  cumx <- cumsum(xs)
  p <- seq_len(n) / n
  L <- cumx / sum(xs)
  tibble(p = p, L = L)
}

lz_sys <- lorenz_prep(reduced$system_minutes)
lz_ib  <- lorenz_prep(reduced$inbasket_minutes)

p_lz <- ggplot() +
  geom_abline(slope = 1, intercept = 0, linetype = "dotted", color = "grey50") +
  geom_line(data = lz_sys, aes(p, L, color = "System minutes"), size = 1) +
  geom_line(data = lz_ib, aes(p, L, color = "Inbox minutes"), size = 1) +
  scale_color_brewer(palette = "Dark2", name = NULL) +
  labs(title = "Lorenz curves of workload inequality",
       x = "Cumulative share of providers",
       y = "Cumulative share of workload") +
  theme_minimal(base_size = 12) + theme(legend.position = "bottom")

ggsave(fig_lorenz, p_lz, width = 6.5, height = 5, dpi = 150)
message(sprintf("Wrote: %s", fig_lorenz))

# -----------------------------
# 7) Decile summary table
# -----------------------------

dec_tbl <- reduced %>%
  filter(is.finite(appointments)) %>%
  mutate(decile = ntile(appointments, 10)) %>%
  group_by(decile) %>%
  summarise(
    n = n(),
    appt_med = median(appointments, na.rm = TRUE),
    ib_min_appt_med = median(inbasket_minutes_per_appointment, na.rm = TRUE),
    afterhours_med = median(afterhours_ratio, na.rm = TRUE),
    days_to_done_med = median(avg_days_to_complete, na.rm = TRUE),
    .groups = "drop"
  )

out_dec <- "tables/pep_deciles_summary.csv"
dir.create(dirname(out_dec), showWarnings = FALSE, recursive = TRUE)
write_csv(dec_tbl, out_dec)
message(sprintf("Wrote: %s", out_dec))

# -----------------------------
# 8) Funnel plot: completion rate vs messages received
# -----------------------------

fig_funnel <- "figures/funnel_completion_vs_messages.png"

funnel_df <- reduced %>%
  transmute(messages_total,
            completion_rate,
            comp_n = pmax(messages_total, 0)) %>%
  filter(is.finite(messages_total), is.finite(completion_rate), comp_n > 0)

if (nrow(funnel_df) > 1) {
  p_bar <- mean(funnel_df$completion_rate, na.rm = TRUE)
  n_seq <- seq(max(1, floor(min(funnel_df$comp_n))), ceiling(max(funnel_df$comp_n)), length.out = 200)
  se <- sqrt(p_bar * (1 - p_bar) / n_seq)
  z95 <- 1.96; z99 <- 2.576
  band <- tibble(
    n = n_seq,
    p95_lo = p_bar - z95 * se,
    p95_hi = p_bar + z95 * se,
    p99_lo = p_bar - z99 * se,
    p99_hi = p_bar + z99 * se
  )

  p_fn <- ggplot(funnel_df, aes(x = comp_n, y = completion_rate)) +
    geom_point(alpha = 0.7) +
    geom_line(data = band, aes(x = n, y = p95_lo), color = "orange", linetype = "dashed") +
    geom_line(data = band, aes(x = n, y = p95_hi), color = "orange", linetype = "dashed") +
    geom_line(data = band, aes(x = n, y = p99_lo), color = "red", linetype = "dotted") +
    geom_line(data = band, aes(x = n, y = p99_hi), color = "red", linetype = "dotted") +
    scale_y_continuous(labels = percent_format(accuracy = 1)) +
    labs(x = "Total messages (n)", y = "Completion rate",
         title = "Funnel plot: completion rate vs messages") +
    theme_minimal(base_size = 12)

  ggsave(fig_funnel, p_fn, width = 7, height = 4.5, dpi = 150)
  message(sprintf("Wrote: %s", fig_funnel))
} else {
  message("Skipping funnel plot: insufficient data")
}

message("Done.")


