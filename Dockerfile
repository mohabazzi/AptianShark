# Use the Rocker image with Ubuntu base
FROM rocker/r-ver:4.5.0

# Copy the .qmd and related files. 
COPY AptianShark.qmd /app/AptianShark.qmd
COPY data/* /app/data/
COPY references.bib /app/references.bib
COPY phylogeny/500treePLtrees.nex /app/phylogeny/500treePLtrees.nex
COPY phylogeny/mccTree_alopias.nex /app/phylogeny/mccTree_alopias.nex
COPY _extensions/stanford-quarto /app/_extensions/stanford-quarto
COPY _extensions/shafayetShafee /app/_extensions/shafayetShafee

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libudunits2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libmagick++-dev \
    liblapack-dev \
    libblas-dev \
    libx11-dev \
    libzip-dev \
    libfftw3-dev \
    libxt-dev \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Quarto CLI.
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.13/quarto-1.7.13-linux-amd64.deb \
    && dpkg -i quarto-1.7.13-linux-amd64.deb \
    && rm quarto-1.7.13-linux-amd64.deb

# Step 1: Install sf first — it has system dependencies
RUN R -e "install.packages('sf', repos = 'https://cloud.r-project.org')"

# Step 2: Install ozmaps separately (after sf is ready)
RUN R -e "install.packages('ozmaps', repos = 'https://cloud.r-project.org')"

# Step 3: Install everything else (in one go)
RUN R -e "install.packages(c( \
  'oz', 'ggpubr','quarto', 'ggspatial', 'dplyr', 'openxlsx', 'ggplot2', 'tidyr', 'reshape', 'janitor', \
  'downlit', 'see', 'purrr', 'readxl', 'kableExtra', 'knitr', 'gtsummary', 'gt', 'MASS', 'broom', \
  'emmeans', 'geomorph', 'xml2', 'broom.helpers', 'smatr', 'MASSTIMATE', 'ggpmisc', 'ggrepel', \
  'performance', 'flextable', 'Metrics', 'magick', 'rempsyc', 'car', 'forcats', 'RRPP', 'caper', \
  'geiger', 'phangorn', 'lmtest', 'randomForest', 'MuMIn', 'phytools', 'conflicted', 'tibble', \
  'irr', 'nlme', 'ggdist', 'adephylo'), repos = 'https://cloud.r-project.org')"

# Clean up apt caches
RUN apt-get clean

# Set working directory
WORKDIR /app

# Render the Quarto document
CMD ["R", "-e", "quarto::quarto_render('/app/AptianShark.qmd')"]
