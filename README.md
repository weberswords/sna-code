## Tools
For folks not familiar with the command line (CLI) the following are recommended: 
- A GitHub account
- [RStudio](https://www.rstudio.com/products/rstudio/)
- [GitHub Desktop](https://desktop.github.com/)

For folks who ARE familiar with the CLI, any IDE and GitHub on command line work as well.

## Instructions for installing R packages via command line on MacOS
If you want to install R packages from the command line (CLI), I've included a script that takes package names as CLI arguments and installs them all.
`Rscript installPackages.R "some_library"`

#### Example
`Rscript installPackages.R "openxlsx" "igraph" "ggraph"`
