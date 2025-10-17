# Epic In-Basket Analysis

## Overview
This repository contains the complete analysis for "Measuring the Invisible Work of Epic In-Basket Messaging in Outpatient Psychiatry" - a comprehensive study examining the hidden workload burden of electronic health record messaging in psychiatric practice.

## Project Structure
```
inbasketosis/
├── data/raw/           # Original datasets
├── data/processed/     # Processed data files
├── scripts/           # Analysis scripts
├── figures/           # Generated visualizations
├── tables/            # Statistical tables
├── reports/           # Final reports
├── docs/              # Documentation
├── templates/         # LaTeX templates
└── archive/           # Archived files
```

## Quick Start
```bash
# Run complete analysis
Rscript scripts/run_complete_analysis.R

# Or run individual components
Rscript scripts/epic_inbasket_pipeline.R
Rscript scripts/create_single_plot_figures.R
Rscript scripts/generate_report.R
```

## Key Findings
- **27.2× variation** in workload across 56 providers
- **3.7% after-hours work** across all providers
- **25% high-risk providers** with elevated workload
- **1,925.4 total hours** of invisible work (1.01 FTE equivalent)

## Outputs
- **3 Figures**: Workload distribution, after-hours patterns, risk stratification
- **2 Tables**: Descriptive statistics, risk analysis
- **1 Report**: Complete PDF analysis document

## Documentation
- `PROJECT_STRUCTURE.md` - Detailed project organization
- `docs/README_Pipeline.md` - Pipeline documentation
- `docs/TROUBLESHOOTING.md` - Common issues and solutions

## Contact
Nicolas Lescano, MD  
BMIN 5070 – Human Factors in Biomedical Informatics  
October 2025
