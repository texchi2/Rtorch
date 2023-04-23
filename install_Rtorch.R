# install R torch since 2023/04/23
install.packages(c("pak", "pkgdepends", "pkgcache"))
pak::pak("r-lib/devtools")
# x install.packages("devtools")
library("devtools")
remotes::install_github("mlverse/torch")


Sys.setenv(TORCH_URL="~/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcu117.zip")
Sys.setenv(LANTERN_URL="~/lantern-0.10.0+cu117+x86_64-Linux.zip")

# x install.packages("~/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcu117.zip", repos=NULL, type="linux.binary")

# or
devtools::install_local("~/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcu117.zip")
devtools::install_local("~/lantern-0.10.0.9000+cu117+x86_64-Linux.zip")

# x torch::install_torch()


### (ok) install R torch
# or https://torch.mlverse.org/docs/articles/installation.html#installing-from-pre-built-binaries
options(timeout = 1600) # increasing timeout is recommended since we will be downloading a 2GB file.
# For Windows and Linux: "cpu", "cu117" are the only currently supported
# For MacOS the supported are: "cpu-intel" or "cpu-m1"
kind <- "cu117" 
version <- "0.10.0"
options(repos = c(
  torch = sprintf("https://storage.googleapis.com/torch-lantern-builds/packages/%s/%s/", kind, version),
  CRAN = "https://cloud.r-project.org" # or any other from which you want to install the other R dependencies.
))
install.packages("torch")
library(torch)


#### %%  python model to R
#% https://torch.mlverse.org/docs/articles/python-to-r.html

# 2020 allow me to introduce torch for R https://blogs.rstudio.com/ai/posts/2020-09-29-introducing-torch-for-r/

# R torch 0.10.0 https://blogs.rstudio.com/ai/posts/2023-04-14-torch-0-10/#pre-built-binaries

