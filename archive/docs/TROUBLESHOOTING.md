# Troubleshooting Guide

## Common Issues and Solutions

### Package Installation Errors

#### Error: `installation of package 'ragg' had non-zero exit status`

**Cause**: Missing system dependencies for graphics packages.

**Solution**:
1. Install system dependencies:
   ```bash
   ./install_dependencies.sh
   ```

2. If on Ubuntu/Debian, install specific packages:
   ```bash
   sudo apt-get install -y libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libfontconfig1-dev libcairo2-dev
   ```

3. Try installing R packages again:
   ```r
   install.packages(c("ragg", "systemfonts", "textshaping"))
   ```

#### Error: `package 'quarto' is not available`

**Cause**: Quarto R package not available or Quarto not installed.

**Solution**:
1. Install Quarto CLI first: https://quarto.org/docs/get-started/
2. Then install R package:
   ```r
   install.packages("quarto")
   ```

#### Error: `there is no package called 'tidyverse'`

**Cause**: tidyverse package not installed.

**Solution**:
1. Install tidyverse:
   ```r
   install.packages("tidyverse")
   ```

2. If that fails, install core packages individually:
   ```r
   install.packages(c("dplyr", "ggplot2", "readr", "tidyr", "purrr", "tibble", "stringr", "forcats"))
   ```

### Rendering Errors

#### Error: `Error in library(quarto)`

**Cause**: Quarto R package not loaded properly.

**Solution**:
1. Check if Quarto is installed:
   ```bash
   quarto --version
   ```

2. Install Quarto if missing: https://quarto.org/docs/get-started/

3. Install R package:
   ```r
   install.packages("quarto")
   ```

#### Error: `Data file not found`

**Cause**: Excel file missing or wrong working directory.

**Solution**:
1. Ensure `PEP Data - Lescano N 07_2024-06_2025 v2.xlsx` is in the project directory
2. Check working directory:
   ```r
   getwd()
   list.files()
   ```

#### Error: `Quarto document not found`

**Cause**: `epic_inbasket_analysis.qmd` missing or wrong working directory.

**Solution**:
1. Ensure the .qmd file is in the project directory
2. Check file exists:
   ```bash
   ls -la *.qmd
   ```

### System-Specific Issues

#### Ubuntu/Debian

**Missing system libraries**:
```bash
sudo apt-get update
sudo apt-get install -y r-base r-base-dev libcurl4-openssl-dev libssl-dev libxml2-dev
```

**Missing graphics libraries**:
```bash
sudo apt-get install -y libcairo2-dev libpango1.0-dev libgdk-pixbuf2.0-dev libgtk-3-dev
```

#### macOS

**Missing Xcode tools**:
```bash
xcode-select --install
```

**Missing Homebrew packages**:
```bash
brew install r pandoc texlive
```

#### Windows

**Install Rtools**: https://cran.r-project.org/bin/windows/Rtools/

**Install MiKTeX**: https://miktex.org/download

### Performance Issues

#### Slow rendering

**Cause**: Large datasets or complex visualizations.

**Solution**:
1. Enable caching in Quarto:
   ```yaml
   execute:
     cache: true
   ```

2. Reduce data size for testing:
   ```r
   # In the .qmd file, add this chunk
   {r data-sample, cache=TRUE}
   # Sample data for faster rendering
   provider_summary <- provider_summary %>% slice_head(n = 20)
   ```

#### Memory issues

**Cause**: Insufficient RAM for large datasets.

**Solution**:
1. Increase R memory limit:
   ```r
   memory.limit(size = 8000)  # Windows
   ```

2. Process data in chunks:
   ```r
   # Process data in smaller batches
   chunk_size <- 1000
   for (i in seq(1, nrow(data), chunk_size)) {
     chunk <- data[i:min(i + chunk_size - 1, nrow(data)), ]
     # Process chunk
   }
   ```

### Output Issues

#### HTML output not interactive

**Cause**: Plotly or DT packages not loaded.

**Solution**:
1. Check package installation:
   ```r
   library(plotly)
   library(DT)
   ```

2. Reinstall if needed:
   ```r
   install.packages(c("plotly", "DT"))
   ```

#### PDF output fails

**Cause**: Missing LaTeX or fonts.

**Solution**:
1. Install LaTeX:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install -y texlive-latex-extra texlive-fonts-recommended
   
   # macOS
   brew install --cask mactex
   ```

2. Install fonts:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install -y fonts-liberation fonts-dejavu-core
   ```

#### Charts not displaying

**Cause**: Graphics device issues.

**Solution**:
1. Check graphics device:
   ```r
   capabilities()
   ```

2. Install graphics libraries:
   ```bash
   sudo apt-get install -y libcairo2-dev libpango1.0-dev
   ```

### Getting Help

#### Check system information

```r
# R version and platform
R.version.string
.Platform

# Installed packages
installed.packages()[1:10, c("Package", "Version")]

# System capabilities
capabilities()
```

#### Check Quarto installation

```bash
quarto --version
quarto check
```

#### Check file permissions

```bash
ls -la *.qmd *.xlsx *.R
```

#### Test with minimal example

Create a test file `test.qmd`:
```markdown
---
title: "Test"
format: html
---

```{r}
library(tidyverse)
data.frame(x = 1:5, y = 1:5) %>% 
  ggplot(aes(x, y)) + 
  geom_point()
```
```

Then render:
```bash
quarto render test.qmd
```

### Contact

If you continue to experience issues:

1. Check the error messages carefully
2. Try the solutions above in order
3. Check system requirements: https://quarto.org/docs/get-started/
4. Search for specific error messages online
5. Consider using RStudio Cloud for a cloud-based solution

### System Requirements

**Minimum**:
- R 4.0+
- 4GB RAM
- 2GB disk space

**Recommended**:
- R 4.2+
- 8GB RAM
- 5GB disk space
- Quarto 1.4+

**Required packages**:
- tidyverse, readxl, knitr, kableExtra
- plotly, DT, scales, patchwork
- ggthemes, corrplot, psych, broom, gt
