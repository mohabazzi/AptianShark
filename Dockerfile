# Use the Rocker image with Ubuntu base
FROM rocker/r-ubuntu

# Copy the .qmd and related files. 
COPY AptianShark.qmd /app/AptianShark.qmd
COPY "data/*" /app/data/
COPY references.bib /app/references.bib
COPY ./phylogeny/500treePLtrees.nex /app/phylogeny/500treePLtrees.nex
COPY ./phylogeny/mccTree_alopias.nex /app/phylogeny/mccTree_alopias.nex
COPY ./_extensions/stanford-quarto /app/_extensions/stanford-quarto
COPY ./_extensions/shafayetShafee /app/_extensions/shafayetShafee

# Install required system dependencies (with APT cleanup to reduce image size)
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    wget \
    r-cran-ggpubr \
    r-cran-ggspatial \
    r-cran-dplyr \
    r-cran-openxlsx \
    r-cran-ggplot2 \
    r-cran-tidyr \
    r-cran-flextable \
    r-cran-purrr \
    r-cran-readxl \
    r-cran-kableextra \
    r-cran-knitr \
    r-cran-gtsummary \
    r-cran-gt \
    r-cran-ggpmisc \
    r-cran-mass \
    r-cran-broom \
    r-cran-ggrepel \
    r-cran-performance \
    r-cran-car \
    r-cran-forcats \
    r-cran-caper \
    r-cran-geiger \
    r-cran-phangorn \
    r-cran-lmtest \
    r-cran-conflicted \
    r-cran-tibble \
    r-cran-irr \
    r-cran-nlme \
    r-cran-ggdist \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto CLI.
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.13/quarto-1.7.13-linux-amd64.deb \
    && dpkg -i quarto-1.7.13-linux-amd64.deb \
    && rm quarto-1.7.13-linux-amd64.deb

# Install missing R packages.
RUN R -e "install.packages(c(\
    'quarto', \
    'see', \
    'remotes', \
    'emmeans', \
    'ozmaps', \
    'smatr', \
    'RRPP', \
    'reshape', \
    'downlit', \
    'janitor', \
    'xml2', \
    'Metrics', \
    'patchwork', \
    'geomorph', \
    'flextable', \
    'Matrix', \
    'ggpmisc', \
    'MASSTIMATE', \
    'randomForest', \
    'rempsyc', \
    'phytools', \
    'ape', \
    'adephylo', \
    'MASS', \
    'piggyback', \
    'MuMIn'), repos = 'https://cloud.r-project.org/')" \
    && echo "R packages installed successfully"

# Clean up any additional unnecessary files
RUN apt-get clean

# Set working directory
WORKDIR /app

# Render the Quarto document
CMD ["R", "-e", "quarto::quarto_render('/app/AptianShark.qmd')"]


