# FTE Calculation Guide for Provider Workload Analysis

## Overview

This guide outlines the best practices for calculating Full-Time Equivalent (FTE) percentages among healthcare providers, specifically for analyzing in-basket workload in outpatient psychiatry settings.

## Current Issues Identified

The original FTE calculation had several problems:
```r
# INCORRECT - Original calculation
fte = round(sch_hrs / (max(aggregated) * weeks), 2)
```

**Issues:**
1. `max(aggregated)` is invalid - cannot take maximum of a data frame
2. No standard FTE definition applied
3. Doesn't account for different provider types
4. Results in meaningless FTE values

## Recommended FTE Calculation Methods

### Method 1: Standard Academic Medical Center FTE (Primary Method)
```r
fte_standard = round(sch_hrs / (40 * weeks), 2)  # 40 hours = 1.0 FTE
fte_pct = fte_standard * 100  # Convert to percentage
```

**Rationale:**
- Standard definition: 1.0 FTE = 40 hours per week
- Widely accepted in academic medical centers
- Allows direct comparison across provider types
- Easy to interpret and communicate

### Method 2: Provider-Type Adjusted FTE
```r
fte_adjusted = case_when(
  type == "MD" ~ round(sch_hrs / (40 * weeks), 2),      # Full-time MD = 40 hrs/week
  type == "NP" ~ round(sch_hrs / (40 * weeks), 2),      # Full-time NP = 40 hrs/week  
  type == "RF" ~ round(sch_hrs / (60 * weeks), 2),      # Full-time resident = 60 hrs/week
  TRUE ~ round(sch_hrs / (40 * weeks), 2)
)
```

**Rationale:**
- Accounts for different workload expectations by role
- Residents typically work longer hours (60+ hrs/week)
- More accurate for role-specific analysis
- Useful for comparing workload within provider types

### Method 3: Clinical FTE
```r
fte_clinical = round(sch_hrs / (32 * weeks), 2)  # 32 clinical hours = 1.0 FTE
```

**Rationale:**
- Focuses on clinical time only (excluding administrative)
- Accounts for typical 20% administrative time
- Better reflects actual patient care capacity
- Useful for clinical productivity analysis

### Method 4: Appointment-Based FTE
```r
fte_appt = round(appts / (20 * weeks), 2)  # 1 FTE = 20 appointments/week
```

**Rationale:**
- Based on appointment volume rather than scheduled hours
- Accounts for different appointment lengths
- Useful for clinical capacity planning
- May better reflect actual clinical workload

## Implementation in Code

The corrected implementation includes:

1. **Primary FTE calculation** using standard 40-hour definition
2. **Multiple FTE methods** for different analytical purposes
3. **FTE categorization** for easy interpretation
4. **Workload intensity metrics** normalized by FTE

```r
# FTE calculations using multiple methods
fte_standard = round(sch_hrs / (40 * weeks), 2),  # Standard: 40 hrs/week = 1.0 FTE
fte_pct = fte_standard * 100,  # FTE as percentage

# Provider-type adjusted FTE
fte_adjusted = case_when(
  type == "MD" ~ round(sch_hrs / (40 * weeks), 2),
  type == "NP" ~ round(sch_hrs / (40 * weeks), 2),  
  type == "RF" ~ round(sch_hrs / (60 * weeks), 2),
  TRUE ~ round(sch_hrs / (40 * weeks), 2)
),

# Clinical FTE
fte_clinical = round(sch_hrs / (32 * weeks), 2),

# Appointment-based FTE
fte_appt = round(appts / (20 * weeks), 2),

# FTE categorization
fte_category = case_when(
  fte >= 0.9 ~ "Full-time (0.9+)",
  fte >= 0.5 ~ "Part-time (0.5-0.89)",
  fte >= 0.1 ~ "Reduced (0.1-0.49)",
  TRUE ~ "Minimal (<0.1)"
),

# Workload intensity metrics
hrs_per_fte = ifelse(fte > 0, sch_hrs / fte, NA),
appts_per_fte = ifelse(fte > 0, appts / fte, NA),
ib_hrs_per_fte = ifelse(fte > 0, ib_hrs / fte, NA)
```

## Best Practices for FTE Analysis

### 1. Choose the Right Method
- **Standard FTE**: For general workload comparisons
- **Adjusted FTE**: For role-specific analysis
- **Clinical FTE**: For clinical productivity analysis
- **Appointment FTE**: For capacity planning

### 2. Use FTE Categories
- Full-time (0.9+ FTE): Primary clinical providers
- Part-time (0.5-0.89 FTE): Regular part-time providers
- Reduced (0.1-0.49 FTE): Limited clinical time
- Minimal (<0.1 FTE): Administrative or research focus

### 3. Normalize Workload Metrics
- Hours per FTE: Actual hours worked per FTE unit
- Appointments per FTE: Clinical productivity per FTE
- In-basket hours per FTE: Administrative burden per FTE

### 4. Consider Provider Type Differences
- Residents typically work longer hours
- APPs may have different productivity expectations
- Attending physicians may have administrative duties

## Quality Assurance

### Validation Checks
1. **Range validation**: FTE should typically be 0.0-1.5
2. **Consistency checks**: Compare different FTE methods
3. **Outlier detection**: Identify unusual FTE values
4. **Cross-validation**: Compare with known provider schedules

### Common Issues to Avoid
1. **Division by zero**: Check for zero weeks or hours
2. **Missing data**: Handle NA values appropriately
3. **Inconsistent units**: Ensure all time units are consistent
4. **Temporal misalignment**: Ensure weeks calculation is correct

## Interpretation Guidelines

### FTE Values
- **1.0 FTE**: Full-time provider (40 hrs/week)
- **0.5 FTE**: Half-time provider (20 hrs/week)
- **0.25 FTE**: Quarter-time provider (10 hrs/week)

### Workload Analysis
- **High FTE, High In-basket**: Heavy clinical and administrative load
- **Low FTE, High In-basket**: Administrative burden disproportionate to clinical time
- **High FTE, Low In-basket**: Efficient clinical practice or limited administrative duties

### Recommendations
1. Use standard FTE (40 hrs/week) as primary metric
2. Apply provider-type adjustments when comparing across roles
3. Normalize workload metrics by FTE for fair comparisons
4. Consider multiple FTE methods for comprehensive analysis
5. Validate results against known provider schedules

## Conclusion

The corrected FTE calculation provides a robust foundation for analyzing provider workload distribution. By implementing multiple FTE methods and normalization approaches, you can gain comprehensive insights into workload equity, administrative burden, and clinical productivity across your provider population.