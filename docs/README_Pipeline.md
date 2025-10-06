# Epic In-Basket Analysis Pipeline

## Overview
This R pipeline provides comprehensive data processing and analysis for the "Measuring the Invisible Work of Epic In-Basket Messaging in Outpatient Psychiatry" study.

## Files Structure

### Main Scripts
- **`epic_inbasket_pipeline.R`** - Main data processing and analysis pipeline
- **`generate_report.R`** - Generates final PDF report
- **`run_complete_analysis.R`** - Master script that runs everything
- **`create_single_plot_figures.R`** - Generates individual figures

### Input Data
- **`PEP Data - Lescano N 07_2024-06_2025 v2.xlsx`** - Main dataset (Time and Messages sheets)
- **`Lescano_ProviderWorksheet_FY25.xlsx`** - Financial data for opportunity cost calculation

### Output Files
- **Figures**: `Figure1_Provider_Workload_Distribution.png`, `Figure2_After_Hours_Work_Pattern.png`, `Figure3_Risk_Stratification.png`
- **Tables**: `Table1_Descriptive_Statistics.csv`, `Table2_Risk_Stratification.csv`
- **Processed Data**: `processed_*.csv` files for further analysis
- **Report**: `Project_Summary_Final_Report.pdf`

## Usage

### Option 1: Run Complete Analysis
```bash
Rscript run_complete_analysis.R
```

### Option 2: Run Individual Components
```bash
# Step 1: Data processing and analysis
Rscript epic_inbasket_pipeline.R

# Step 2: Generate figures
Rscript create_single_plot_figures.R

# Step 3: Generate final report
Rscript generate_report.R
```

## Pipeline Features

### Data Processing
- **Data Loading**: Reads Excel files with time and message data
- **Data Cleaning**: Standardizes column names and formats
- **Normalization**: Calculates annualized workload using days in system
- **Filtering**: Removes providers with <30 days in system

### Statistical Analysis
- **Descriptive Statistics**: Mean, median, IQR, standard deviation, CV
- **Risk Stratification**: Categorizes providers into Low/Moderate/High risk
- **Provider Type Analysis**: Compares workload across provider types
- **After-Hours Analysis**: Quantifies work outside business hours

### Visualizations
- **Figure 1**: Provider workload distribution with UPenn colors
- **Figure 2**: After-hours work patterns
- **Figure 3**: Risk stratification visualization

### Tables
- **Table 1**: Comprehensive descriptive statistics
- **Table 2**: Risk stratification summary

## Key Metrics Calculated

### Workload Metrics
- **Raw Workload**: Total hours during observation period
- **Normalized Workload**: Annualized hours per year
- **Workload Variation**: Ratio of highest to lowest workload
- **After-Hours Percentage**: Proportion of work outside 7 AM-7 PM

### Risk Categories
- **Low Risk**: Bottom 25th percentile
- **Moderate Risk**: 25th-75th percentile  
- **High Risk**: Top 25th percentile

## Dependencies

### R Packages
- `readxl` - Excel file reading
- `dplyr`, `tidyr` - Data manipulation
- `ggplot2` - Visualization
- `scales`, `viridis` - Plot formatting
- `ggthemes` - Plot themes
- `corrplot`, `psych` - Statistical analysis
- `kableExtra`, `DT` - Table formatting
- `knitr`, `rmarkdown` - Report generation

### System Requirements
- R version 4.0 or higher
- LaTeX (for PDF generation)
- Pandoc (for document conversion)

## Output Summary

The pipeline generates:
- **3 Figures** with UPenn branding colors
- **2 Tables** with academic formatting
- **Processed datasets** for further analysis
- **Summary statistics** for key findings
- **Final PDF report** with complete analysis

## Key Findings

- **56 providers** analyzed with ≥30 days in system
- **27.2× variation** in normalized annual workload
- **3.7% after-hours work** across all providers
- **25% high-risk providers** with elevated workload
- **1,925.4 total hours** of invisible work (1.01 FTE equivalent)

## Troubleshooting

### Common Issues
1. **Missing packages**: Pipeline auto-installs required packages
2. **Excel file errors**: Ensure input files are in correct format
3. **LaTeX errors**: Install LaTeX distribution for PDF generation
4. **Memory issues**: Large datasets may require increased memory allocation

### Error Handling
- Pipeline includes comprehensive error checking
- Missing data is handled gracefully with warnings
- All outputs are validated before saving

## Contact
Nicolas Lescano, MD  
BMIN 5070 – Human Factors in Biomedical Informatics  
October 2025
