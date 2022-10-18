#!/usr/bin/env R

# On Guix or Nix, don't try to upgrade.
if (grepl("guix|^/gnu|^/nix", R.home()))
  Sys.setenv(R_REMOTES_UPGRADE = "never")

options(
  mc.cores = parallel::detectCores()
, repos = c(CRAN = "https://cloud.r-project.org/")
#, warn = 2 # https://www.r-bloggers.com/2012/05/a-warning-about-warning/
, scipen = 2
, digits = 3
, max.print = 200
  # , browser = 'echo "$@" > /dev/null' # test modeltime::plot_time_series with this off
, menu.graphics = FALSE
, pillar.bold = TRUE
, usethis.full_name = "Martin Edström"
, usethis.description =
    list(`Authors@R` = 'person("Martin", "Edström",
                               email = "meedstrom@teknik.io",
                               role = c("aut", "cre"))',
         License = 'GPL (>= 3)',
         Language =  'en')
)

## if (interactive()) {
##   try(suppressMessages(require(devtools)))
## }

# called on R exit
## .Last <- function()
##   if (interactive()) try(savehistory(".Rhistory"))
