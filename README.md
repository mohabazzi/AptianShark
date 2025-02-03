
<!-- README.md is generated from README.Rmd. -->

# Early evolutionary onset of large-body sizes in lamniform sharks

<!-- badges: start -->
<!-- badges: end -->

This GitHub repository contains the code used to analyse all
datasets presented in **Early evolutionary onset of large-body sizes in lamniform sharks**

by Mohamad Bazzi, Mikael Siversson, Sabine Wintner, Michael Newbrey, Jonathan L. Payne, Nicolás E. Campione, Aubrey J. Roberts, Stephen Hall, Tatianna Blake, and Benjamin P. Kear

Code written and maintained by Mohamad Bazzi 
<br/>
Contact:
<bazzi@stanford.edu> and <mohammmed_bazzi@hotmail.com>

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

[data](/data) contains all data file analysed in this study.
