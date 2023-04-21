FROM rocker/shiny-verse:3.6.2

RUN apt-get --allow-releaseinfo-change update
RUN apt-get upgrade cpp gcc g++ libc6 manpages-dev gfortran libc-dev-bin libc6-dev build-essential -y
RUN apt-get install cmake automake libtool apt-utils pkg-config -y
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libv8-dev libnode-dev libmagick++-dev -y
RUN apt-get install libharfbuzz-dev libfribidi-dev -y
RUN apt-get install libfontconfig1-dev -y
RUN apt-get install libxml++2.6-dev -y
RUN apt-get install libgit2-dev jags -y
RUN apt-get install libsodium-dev libudunits2-dev -y
RUN apt-get install libssl-dev libpq-dev libmariadb-dev unixodbc-dev -y
RUN apt-get install libpoppler-cpp-dev -y
RUN apt-get install libzmq3-dev -y
RUN apt-get install mailutils -y
RUN mkdir /inst

WORKDIR /inst
COPY install.sh .
RUN chmod +x install.sh
COPY reqs.txt .
RUN sed -n '1,422p; 423q' /inst/reqs.txt | ./install.sh
RUN R -e "install.packages('devtools')"
RUN apt-get install curl -y
RUN R -e "devtools::install_github('kxsystems/rkdb', INSTALL_opts=c('--no-multiarch', '--no-test-load'))"
RUN #R -e "devtools::install_github('kxsystems/rkdb@v0.10.0', INSTALL_opts=c('--no-multiarch', '--no-test-load'))"
ENTRYPOINT ["tail" "-f" "/dev/null"]
