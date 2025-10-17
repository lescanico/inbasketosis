# Epic In-Basket Analysis - Project Structure

## Directory Organization

```
inbasketosis/
├── data/                           # Data files
│   ├── raw/                        # Original data files
│   │   ├── PEP Data - Lescano N 07_2024-06_2025 v2.xlsx
│   │   └── Lescano_ProviderWorksheet_FY25.xlsx
│   └── processed/                  # Processed data files
│       ├── processed_time_data.csv
│       ├── processed_after_hours_data.csv
│       ├── processed_risk_data.csv
│       ├── processed_provider_analysis.csv
│       └── summary_statistics.rds
├── scripts/                        # Analysis scripts
│   ├── epic_inbasket_pipeline.R    # Main analysis pipeline
│   ├── create_single_plot_figures.R
│   ├── generate_report.R
│   ├── run_complete_analysis.R    # Master script
│   └── install_dependencies.sh
├── figures/                        # Generated figures
│   ├── Figure1_Provider_Workload_Distribution.png
│   ├── Figure2_After_Hours_Work_Pattern.png
│   ├── Figure3_Risk_Stratification.png
│   ├── Figure2_Provider_Type_Comparison.png
│   ├── Figure3_After_Hours_Work_Pattern.png
│   └── Figure4_Risk_Stratification.png
├── tables/                         # Generated tables
│   ├── Table1_Descriptive_Statistics.csv
│   └── Table2_Risk_Stratification.csv
├── reports/                        # Final reports
│   ├── Project_Summary.md
│   └── Project_Summary_Final_Clean.pdf
├── docs/                          # Documentation
│   ├── README.md
│   ├── README_Pipeline.md
│   ├── TROUBLESHOOTING.md
│   └── requirements.txt
├── templates/                     # LaTeX templates
│   ├── template_custom.tex
│   └── template_title.tex
├── archive/                       # Archived files
└── articles/                      # Reference articles
```

## File Descriptions

### Data Files
- **`data/raw/PEP Data - Lescano N 07_2024-06_2025 v2.xlsx`**: Main dataset with Time and Messages sheets
- **`data/raw/Lescano_ProviderWorksheet_FY25.xlsx`**: Financial data for opportunity cost calculation
- **`data/processed/*.csv`**: Processed datasets from analysis pipeline
- **`data/processed/summary_statistics.rds`**: R object with key statistics

### Scripts
- **`scripts/epic_inbasket_pipeline.R`**: Main analysis pipeline
- **`scripts/create_single_plot_figures.R`**: Figure generation
- **`scripts/generate_report.R`**: Report generation
- **`scripts/run_complete_analysis.R`**: Master script
- **`scripts/install_dependencies.sh`**: System dependencies

### Figures
- **`figures/Figure1_Provider_Workload_Distribution.png`**: Main workload distribution (UPenn colors)
- **`figures/Figure2_After_Hours_Work_Pattern.png`**: After-hours work analysis
- **`figures/Figure3_Risk_Stratification.png`**: Risk stratification visualization

### Tables
- **`tables/Table1_Descriptive_Statistics.csv`**: Comprehensive descriptive statistics
- **`tables/Table2_Risk_Stratification.csv`**: Risk stratification summary

### Reports
- **`reports/Project_Summary.md`**: Markdown source document
- **`reports/Project_Summary_Final_Clean.pdf`**: Final PDF report

### Documentation
- **`docs/README.md`**: Project overview
- **`docs/README_Pipeline.md`**: Pipeline documentation
- **`docs/TROUBLESHOOTING.md`**: Common issues and solutions
- **`docs/requirements.txt`**: Python dependencies

## Usage Workflow

### 1. Data Preparation
```bash
# Ensure raw data is in data/raw/
ls data/raw/
```

### 2. Run Analysis
```bash
# Run complete pipeline
Rscript scripts/run_complete_analysis.R

# Or run individual components
Rscript scripts/epic_inbasket_pipeline.R
Rscript scripts/create_single_plot_figures.R
Rscript scripts/generate_report.R
```

### 3. Review Outputs
```bash
# Check generated files
ls figures/
ls tables/
ls reports/
```

## Key Outputs

### Figures (PNG format, 300 DPI)
- Provider workload distribution with UPenn branding
- After-hours work patterns
- Risk stratification visualization

### Tables (CSV format)
- Descriptive statistics with academic formatting
- Risk stratification summary

### Reports (PDF format)
- Complete analysis report with title page
- Table of contents
- All figures and tables integrated

## Data Flow

1. **Raw Data** → `data/raw/`
2. **Processing** → `scripts/epic_inbasket_pipeline.R`
3. **Processed Data** → `data/processed/`
4. **Figures** → `figures/`
5. **Tables** → `tables/`
6. **Final Report** → `reports/`

## Maintenance

### Adding New Data
- Place new raw data files in `data/raw/`
- Update pipeline scripts as needed
- Re-run analysis pipeline

### Updating Figures
- Modify `scripts/create_single_plot_figures.R`
- Re-run figure generation
- Update report if needed

### Documentation Updates
- Update `docs/README.md` for project changes
- Update `docs/README_Pipeline.md` for pipeline changes
- Add troubleshooting entries as needed

## Quality Control

### File Validation
- All scripts are executable
- Data files are properly formatted
- Figures meet resolution requirements (300 DPI)
- Tables follow academic standards
- Reports render without errors

### Version Control
- Keep raw data unchanged
- Document any processing changes
- Maintain reproducible pipeline
- Archive old versions in `archive/`

## Contact
Nicolas Lescano, MD  
BMIN 5070 – Human Factors in Biomedical Informatics  
October 2025
