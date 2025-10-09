# Data Dictionary

This document describes the processed datasets used in the project. For each dataset, we list columns, inferred types (from CSV samples), and brief definitions. Adjust definitions if your domain usage differs.

## Raw Data

Source files in `data/raw/`:

- `PEP Data - Lescano N 07_2024-06_2025 v2.xlsx`
  - Sheets used: `Time`, `Messages`
  - Common handling: First column renamed to `DE_ID` in the pipeline
  - Sheet: `Time`
    - **DE_ID** (integer): De-identified provider identifier.
    - **Grouper** (string): Epic role grouping; mapped to provider types in processing.
      - Mapping in pipeline: `PHYSICIAN + PSYCHIATRIST` → `Attending Psychiatrist`; `RESIDENT + FELLOW` → `Psychiatry Resident/Fellow`; `NURSE PRACTITIONER` → `Nurse Practitioner`.
    - **Metric** (string): Metric name per row. Complete set observed in the CSV:
      - `Count Of Days In Reporting Period`: Total number of days included in the reporting window for the provider.
      - `Count Of Days In System`: Number of days the provider was active in the system during the reporting period.
      - `Count Of Scheduled Days`: Number of days the provider was scheduled to work.
      - `Count Of Days With Appointments`: Number of days on which the provider had at least one scheduled appointment.
      - `Count Of Days of Afterhours Activity`: Number of days where the provider performed activity outside of standard business hours.
      - `Count Of Minutes Active On Unscheduled Days`: Total minutes the provider was active on days they were not scheduled to work.
      - `Count Of Minutes In The System`: Total minutes the provider was logged into or active in the system.
      - `Minutes In Clinical Review Per Appointment`: Average minutes spent on clinical review tasks per appointment.
      - `Minutes In In Basket Per Appointment`: Average minutes spent in the In Basket (messaging/task system) per appointment.
      - `Minutes In Notes/Letters Per Appointment`: Average minutes spent writing notes or letters per appointment.
      - `Minutes In Orders Per Appointment`: Average minutes spent entering orders per appointment.
      - `Minutes In Clinical Review Per Day`: Average minutes spent on clinical review tasks per day.
      - `Count Of Appointments`: Total number of appointments handled by the provider.
      - `Scheduled Hours per Day`: Number of hours the provider was scheduled to work per day.
      - `Count Of Minutes Active Outside 7AM to 7PM`: Total minutes of activity occurring outside the 7AM–7PM window.
      - `Count Of Minutes Active Outside Scheduled Time (30 Min Buffer)`: Total minutes of activity outside scheduled work hours, allowing a 30-minute buffer before and after scheduled time.
      - `Minutes Active On Unscheduled Days Per Day`: Average minutes of activity per unscheduled day.
      - `% Of Minutes On Sunday`: Percentage of total activity minutes that occurred on Sundays.
      - `Minutes In Other Per Day`: Average minutes per day spent on activities not categorized elsewhere.
      - `Count Of Sunday Minutes`: Total minutes of activity on Sundays.
      - `% Of Minutes On Saturday`: Percentage of total activity minutes that occurred on Saturdays.
      - `Count Of Saturday Minutes`: Total minutes of activity on Saturdays.
    - **24-Jul ... 25-Jun** (numeric): Monthly values for the metric by provider. The pipeline pivots these columns from wide to long and converts month labels to dates.