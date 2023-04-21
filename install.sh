#!/bin/sh
while IFS=" " read $1 -r package version;
do
  R -e "if('"$package"' %in% rownames(installed.packages()) == FALSE) {install.packages('https://cran.r-project.org/package="$package"&version="$version"', quiet=TRUE, dependencies=FALSE , repos=NULL, type='source')}";
done
