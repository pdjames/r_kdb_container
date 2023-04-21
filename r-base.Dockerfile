FROM rocker/shiny-verse:3.6.2

RUN /bin/sh -c apt-get update
RUN /bin/sh -c apt-get upgrade cpp gcc g++ libc6 manpages-dev gfortran libc-dev-bin libc6-dev build-essential -y
RUN /bin/sh -c apt-get install cmake automake libtool apt-utils pkg-config -y
RUN /bin/sh -c apt-get install libcurl4-openssl-dev -y
RUN /bin/sh -c apt-get install libv8-dev libnode-dev libmagick++-dev -y
RUN /bin/sh -c apt-get install libharfbuzz-dev libfribidi-dev -y
RUN /bin/sh -c apt-get install libfontconfig1-dev -y
RUN /bin/sh -c apt-get install libxml++2.6-dev -y
RUN /bin/sh -c apt-get install libgit2-dev jags -y
RUN /bin/sh -c apt-get install libsodium-dev libudunits2-dev -y
RUN /bin/sh -c apt-get install libssl-dev libpq-dev libmariadb-dev unixodbc-dev -y
RUN /bin/sh -c apt-get install libpoppler-cpp-dev -y
RUN /bin/sh -c apt-get install libzmq3-dev -y
RUN /bin/sh -c mkdir /inst

WORKDIR /inst
COPY install.sh .
RUN /bin/sh -c chmod +x install.sh
COPY reqs.txt .
RUN /bin/sh -c sed -n '1,422p; 423q' /inst/reqs.txt | ./install.sh
RUN /bin/sh -c R -e "install.packages('devtools')"
RUN /bin/sh -c apt-get install curl -y
RUN /bin/sh -c R -e "devtools::install_github('kxsystems/rkdb', INSTALL_opts=c('--no-multiarch', '--no-test-load'))"
RUN /bin/sh -c #R -e "devtools::install_github('kxsystems/rkdb@v0.10.0', INSTALL_opts=c('--no-multiarch', '--no-test-load'))"
ENTRYPOINT ["tail" "-f" "/dev/null"]
