#!/bin/sh
while IFS=" " read $1 -r package version;
do
  R -e "if('"$package"' %in% rownames(installed.packages()) == FALSE) {install.packages('"$package"')}";
done
