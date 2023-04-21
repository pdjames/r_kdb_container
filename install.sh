#!/bin/sh
while IFS=" " read $1 -r package version;
do
  R -e "if('"$package"' %in% rownames(installed.packages()) == FALSE) {install.packages('https://cran.r-project.org/package="$package"&version="$version"', dependencies=FALSE , repos=NULL, type='source')}";
#  Rscript -e "if('"$package"' %in% rownames(installed.packages()) == FALSE) {install.packages('"$package"', dependencies=TRUE)}";
#  R -e "install.packages('"$package"', dependencies=TRUE, repos='http://cran.rstudio.com/')";
#  R -e "devtools::install_version('"$package"', dependencies=TRUE, repos='http://cran.rstudio.com/')";
done
