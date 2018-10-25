#' ----
#' author: "Taavi Päll"
#' output: github_document
#' ----

#' Load libraries
library(tidyverse)
library(skimr)

#' Import dataset. Here we use `fread` function from **data.table** library 
#' because we have no idea what delimiters are being used in this file 
#' (don't trust file extension).
violations <- data.table::fread("data/liiklusjarelevalve_3.csv") %>% as_data_frame()
violations

#' Let's have a look how this dataset looks like and what variables it has
skim(violations)

#' We have mostly 
