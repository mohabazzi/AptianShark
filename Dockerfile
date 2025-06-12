FROM rocker/geospatial:4.3.1

# Copy project files
COPY AptianShark.qmd /app/AptianShark.qmd
COPY data/* /app/data/
COPY references.bib /app/references.bib
COPY phylogeny/500treePLtrees.nex /app/phylogeny/500treePLtrees.nex
COPY phylogeny/mccTree_alopias.nex /app/phylogeny/mccTree_alopias.nex
COPY _extensions/stanford-quarto /app/_extensions/stanford-quarto
COPY _extensions/shafayetShafee /app/_extensions/shafayetShafee

# Install Quarto CLI
RUN apt-get update -y && apt-get install -y wget \
    && wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.13/quarto-1.7.13-linux-amd64.deb \
    && dpkg -i quarto-1.7.13-linux-amd64.deb \
    && rm quarto-1.7.13-linux-amd64.deb

# Install r-cran-* binary packages
RUN apt-get install -y --no-install-recommends \
    r-cran-tidyverse

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get clean

# Install R packages from source
RUN R -e "install.packages(c(\
    'ozmaps', \
    'ggspatial', \
    'dplyr', \
    'openxlsx', \
    'ggplot2', \
    'tidyr', \
    'reshape', \
    'janitor', \
    'downlit', \
    'sf', \
    'see', \
    'purrr', \
    'readxl', \
    'kableExtra', \
    'knitr', \
    'gtsummary', \
    'gt', \
    'MASS', \
    'broom', \
    'emmeans', \
    'geomorph', \
    'xml2', \
    'broom.helpers', \
    'smatr', \
    'MASSTIMATE', \
    'ggpmisc', \
    'ggrepel', \
    'smatr', \
    'performance', \
    'flextable', \
    'Metrics', \
    'magick', \
    'rempsyc', \
    'car', \
    'forcats', \
    'RRPP', \
    'caper', \
    'geiger', \
    'phangorn', \
    'lmtest', \
    'MuMIn', \
    'phytools', \
    'conflicted', \
    'tibble', \
    'irr', \
    'nlme', \
    'ggdist', \
    'adephylo'))"

RUN R -e "install.packages('quarto', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('ggpubr', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('patchwork', repos = 'https://cloud.r-project.org')"

# Set working directory
WORKDIR /app

# Render the Quarto document
CMD ["R", "-e", "quarto::quarto_render('/app/AptianShark.qmd')"]
