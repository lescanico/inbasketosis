#!/bin/bash
# install_dependencies.sh
# Script to install system dependencies for Epic In-Basket Analysis

echo "Installing system dependencies for Epic In-Basket Analysis..."
echo "This script will install required system packages for R and Quarto."

# Check if running on Ubuntu/Debian
if command -v apt-get &> /dev/null; then
    echo "Detected Ubuntu/Debian system"
    
    # Update package list
    sudo apt-get update
    
    # Install system dependencies
    echo "Installing system packages..."
    sudo apt-get install -y \
        r-base \
        r-base-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libmariadb-dev \
        libpq-dev \
        libsodium-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        libfontconfig1-dev \
        libcairo2-dev \
        libgdal-dev \
        libproj-dev \
        libgeos-dev \
        libudunits2-dev \
        pandoc \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-xetex \
        fonts-liberation \
        fonts-dejavu-core
    
    echo "System packages installed successfully!"
    
elif command -v yum &> /dev/null; then
    echo "Detected Red Hat/CentOS system"
    
    # Install system dependencies
    echo "Installing system packages..."
    sudo yum install -y \
        R \
        R-devel \
        libcurl-devel \
        openssl-devel \
        libxml2-devel \
        mariadb-devel \
        postgresql-devel \
        libsodium-devel \
        harfbuzz-devel \
        fribidi-devel \
        freetype-devel \
        libpng-devel \
        libtiff-devel \
        libjpeg-turbo-devel \
        fontconfig-devel \
        cairo-devel \
        gdal-devel \
        proj-devel \
        geos-devel \
        udunits2-devel \
        pandoc \
        texlive-latex \
        texlive-fonts \
        liberation-fonts \
        dejavu-fonts
    
    echo "System packages installed successfully!"
    
elif command -v brew &> /dev/null; then
    echo "Detected macOS system"
    
    # Install system dependencies
    echo "Installing system packages..."
    brew install \
        r \
        pandoc \
        texlive \
        cairo \
        pkg-config \
        libcurl \
        openssl \
        libxml2 \
        mariadb \
        postgresql \
        libsodium \
        harfbuzz \
        fribidi \
        freetype \
        libpng \
        libtiff \
        libjpeg \
        fontconfig \
        gdal \
        proj \
        geos \
        udunits
    
    echo "System packages installed successfully!"
    
else
    echo "Unsupported system. Please install dependencies manually."
    echo "Required packages:"
    echo "- R and R development tools"
    echo "- libcurl, openssl, libxml2 development libraries"
    echo "- Database development libraries (mariadb, postgresql)"
    echo "- Graphics libraries (cairo, freetype, libpng, etc.)"
    echo "- Pandoc and LaTeX"
    exit 1
fi

echo ""
echo "System dependencies installation complete!"
echo ""
echo "Next steps:"
echo "1. Install Quarto: https://quarto.org/docs/get-started/"
echo "2. Run the R script: Rscript render_report.R"
echo "3. Or render directly: quarto render epic_inbasket_analysis.qmd"
