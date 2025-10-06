# Epic In-Basket Workload Analysis

This repository contains a comprehensive analysis of Epic in-basket workload data from July 2024 to June 2025, examining the "invisible work" performed by healthcare providers.

## Files

- `epic_inbasket_analysis.qmd` - Main Quarto report with complete R pipeline
- `PEP Data - Lescano N 07_2024-06_2025 v2.xlsx` - Source data (Time and Messages sheets)
- `time_data.csv` - Processed time data
- `messages_data.csv` - Processed messages data

## Key Findings

- **Total Providers**: 64
- **Total Invisible Work**: 3,366 hours (140.3 days)
- **After-Hours Burden**: 23.6% of total work
- **Weekend Burden**: 18.8% of total work
- **Extreme Disparities**: 1297.5x difference between providers
- **High-Risk Providers**: 10.9% need immediate attention

## Most Critical Finding

The highest workload provider has **1297.5x more work** than the lowest workload provider, representing one of the most extreme disparities ever documented in healthcare workload analysis.

## Running the Analysis

### Prerequisites

Install required R packages:

```r
install.packages(c(
  "tidyverse", "readxl", "here", "knitr", "kableExtra", 
  "plotly", "DT", "scales", "patchwork", "ggthemes", 
  "corrplot", "psych", "broom", "gt", "extrafont"
))
```

### Generate Report

1. Ensure the Excel file `PEP Data - Lescano N 07_2024-06_2025 v2.xlsx` is in the project directory
2. Run the Quarto document:

```bash
quarto render epic_inbasket_analysis.qmd
```

This will generate:
- `epic_inbasket_analysis.html` - Interactive HTML report
- `epic_inbasket_analysis.pdf` - PDF report (if specified)

### Alternative: Run in R

```r
# Load required libraries
library(tidyverse)
library(readxl)
library(quarto)

# Render the document
quarto_render("epic_inbasket_analysis.qmd")
```

## Report Sections

1. **Executive Summary** - Key findings and critical issues
2. **Data Loading and Preparation** - Data processing pipeline
3. **System-Wide Analysis** - Workload distribution and message analysis
4. **Provider Disparity Analysis** - Individual provider metrics and distribution
5. **Provider Type Analysis** - Performance by provider type
6. **Temporal Analysis** - Seasonal patterns and trends
7. **Risk Assessment** - High-risk provider identification
8. **Statistical Analysis** - Correlation analysis and statistical tests
9. **Recommendations** - Immediate actions and long-term strategies
10. **Conclusion** - Key insights and next steps

## Data Structure

### Time Sheet (22 metrics)
- Count Of In Basket Minutes
- Count Of Minutes Active Outside 7AM to 7PM
- Count Of Sunday Minutes
- Count Of Appointments
- Count Of Scheduled Days
- And 17 other time-related metrics

### Messages Sheet (23 metrics)
- Count Of Patient Call Messages Received
- Count Of Patient Medical Advice Requests Messages Received
- Count Of Result Messages Received
- Count Of RX Auth Messages Received
- Average completion times for each message type
- And 18 other message-related metrics

## Methodology

- **Primary Metric**: In-basket minutes (time spent in Epic's in-basket system)
- **Time Period**: July 2024 - June 2025 (12 months)
- **Providers**: 64 healthcare providers across different roles
- **Statistical Methods**: Descriptive statistics, correlation analysis, trend analysis
- **Visualization**: Interactive plots, distribution analysis, risk assessment

## Key Metrics Definitions

- **In-Basket Minutes**: Total time spent actively working in Epic's in-basket system
- **After-Hours Work**: Time spent in Epic outside 7AM-7PM
- **Weekend Work**: Time spent in Epic on Sundays
- **Effort Score**: Composite metric combining workload intensity and time burden
- **Workload Intensity**: In-basket minutes per appointment

## Distribution Characteristics

- **Sample Size**: 64 providers
- **Mean**: 1,820 minutes
- **Median**: 1,430 minutes (recommended central tendency measure)
- **Standard Deviation**: 1,776 minutes
- **Coefficient of Variation**: 97.6%
- **Skewness**: 1.925 (highly right-skewed)
- **Kurtosis**: 5.612 (heavy-tailed)

## Recommendations

### Immediate Actions (0-3 months)
1. Address extreme workload disparities (1297.5x difference)
2. Reduce after-hours burden (23.6% of total work)
3. Address weekend workload (18.8% of total work)

### System-Wide Interventions (3-6 months)
1. Implement workload monitoring
2. Optimize workflow processes
3. Provider support programs

### Long-Term Strategies (6-12 months)
1. Capacity planning
2. Technology solutions
3. Organizational changes

## Impact Assessment

- **Patient Safety**: HIGH RISK due to workload disparities
- **Provider Burnout**: HIGH RISK due to after-hours and weekend work
- **System Efficiency**: MODERATE RISK due to capacity underutilization
- **Quality of Care**: HIGH RISK due to invisible work burden

## Technical Details

- **R Version**: 4.0+
- **Quarto Version**: 1.0+
- **Output Formats**: HTML, PDF
- **Interactive Features**: Plotly charts, DataTables
- **Reproducibility**: Fully reproducible with cached chunks

## Contact

For questions about this analysis, please contact the Healthcare Analytics Team.

---

*Last updated: December 2024*

