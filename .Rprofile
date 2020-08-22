#!/usr/bin/env R

options(
  browser = 'echo "$@" > /dev/null'
, scipen = 2
, digits = 3
, max.print = 200
, mc.cores = parallel::detectCores()
, menu.graphics = FALSE
, pillar.bold = TRUE
, repos = c(CRAN = "https://cloud.r-project.org/")
)

Sys.setenv(R_REMOTES_UPGRADE = "never")

# called on R exit
## .Last <- function()
##   if (interactive()) try(savehistory(".Rhistory"))
