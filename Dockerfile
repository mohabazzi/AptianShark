# Use the Rocker image with Ubuntu base
FROM rocker/r-ubuntu

# Copy the .qmd and related files. 
COPY AptianShark.qmd /app/AptianShark.qmd
COPY data/* /app/data/
COPY references.bib /app/references.bib
COPY phylogeny/500treePLtrees.nex /app/phylogeny/500treePLtrees.nex
COPY phylogeny/mccTree_alopias.nex /app/phylogeny/mccTree_alopias.nex
COPY _extensions/stanford-quarto /app/_extensions/stanford-quarto
COPY _extensions/shafayetShafee /app/_extensions/shafayetShafee

# Install system dependencies required by R packages and wget
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    wget \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libudunits2-dev \
    libgit2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto CLI.
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.13/quarto-1.7.13-linux-amd64.deb \
    && dpkg -i quarto-1.7.13-linux-amd64.deb \
    && rm quarto-1.7.13-linux-amd64.deb

RUN R -e "install.packages(c(\
  'ggpubr','remotes', 'ggspatial', 'dplyr', 'openxlsx', 'ggplot2', 'tidyr', \
  'flextable','devtools', 'purrr', 'readxl', 'kableExtra', 'knitr', 'gtsummary', \
  'gt', 'ggpmisc', 'MASS', 'broom', 'ggrepel', 'performance', 'car', 'forcats', \
  'caper', 'geiger', 'phangorn', 'lmtest', 'conflicted', 'tibble', 'irr', 'nlme', \
  'ggdist', 'quarto', 'see', 'emmeans', 'ozmaps', 'smatr', 'RRPP', 'reshape', \
  'downlit', 'janitor', 'xml2', 'Metrics', 'patchwork', 'geomorph', 'Matrix', \
  'MASSTIMATE', 'randomForest', 'rempsyc', 'phytools', 'ape', 'adephylo', \
  'piggyback', 'MuMIn'), repos = 'https://cloud.r-project.org/')"

# Clean up apt caches
RUN apt-get clean

# Set working directory
WORKDIR /app

# Render the Quarto document
CMD ["R", "-e", "quarto::quarto_render('/app/AptianShark.qmd')"]
