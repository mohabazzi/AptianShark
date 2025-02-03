
<!-- README.md is generated from README.Rmd. -->

# Early evolutionary onset of large-body sizes in lamniform sharks

<!-- badges: start -->
<!-- badges: end -->

This GitHub repository contains the code used in analysis of all
datasets used in **Continuity of large-body size in the evolution of
lamniform sharks**

by Mohamad Bazzi, Mikael Siversson, Sabine Wintner, Michael Newbrey,
Aubrey J. Roberts, Stephen Hall, Nicolás E. Campione, Tatianna Blake,
Jonathan L. Payne and Benjamin P. Kear

Code written and maintained by Mohamad Bazzi Contact:
<bazzi@stanford.edu>

## Access .Rdata

Larger assets can be accessed from within a report using
[`piggyback`](https://github.com/ropensci/piggyback)!

``` r
# Install and load R package
require(piggyback)

# Create temporary directory and load .Rdata into R environment,
pb_download(file = "default.RData",dest = tempdir(),repo = "mohabazzi/AptianShark",tag = "v.01")
load(file = file.path(tempdir(),"default.RData"))
```

[r](/data) contains all data file analysed in this study.
