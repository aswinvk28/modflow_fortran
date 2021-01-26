# based on https://github.com/naftulikay/docker-bionic-vm/blob/master/Dockerfile

FROM ubuntu:18.04
ENV container=docker TERM=xterm LC_ALL=en_US LANGUAGE=en_US LANG=en_US.UTF-8

# stop some annoying interactive prompts, also need "-yq" on apt-get
ENV DEBIAN_FRONTEND=noninteractive

# locale
RUN apt-get update -q > /dev/null && \
  apt-get install --no-install-recommends -yq apt-utils locales language-pack-en dialog > /dev/null && \
  locale-gen $LANGUAGE $LANG

# add sudo commmand
RUN apt-get -yq install sudo > /dev/null

# create and switch to a non-priviliged (but sudo-enabled) user, arbitrary name
RUN echo "nonprivuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/nonprivuser --create-home --shell /bin/bash nonprivuser && adduser nonprivuser sudo
USER nonprivuser 
WORKDIR /home/nonprivuser

# Git/Curl -- don't disable recommends here or you won't have Certification Authority certificates and will fail
RUN sudo apt-get install -yq git curl > /dev/null

# packages specific to your needs
RUN sudo apt-get install --no-install-recommends -yq make gfortran libcoarrays-dev libopenmpi-dev open-coarrays-bin > /dev/null && \
  sudo apt-get clean -q

RUN sudo apt-get install build-essential -y
RUN sudo apt-get install checkinstall zlib1g-dev openssl libssl-dev -y
RUN git clone https://github.com/Kitware/CMake && cd CMake && OPENSSL_ROOT_DIR=/usr/lib/ssl && ./bootstrap && \
OPENSSL_ROOT_DIR=/usr/lib/ssl make && sudo make install

# latest cmake
RUN git clone --depth 1 https://github.com/scivision/cmake-utils && \
  mkdir -v /home/nonprivuser/.local && \
  cd cmake-utils && mkdir build && cd build && sudo cmake ..

RUN cd cmake-utils/build && sudo make && sudo make all

RUN sudo apt-get --yes install geany

RUN sudo apt-get install ncurses-term -y

ENV PATH=$PATH:/home/nonprivuser/.local/cmake/bin

RUN sudo apt-get install wget -y
WORKDIR /home/nonprivuser/
RUN wget https://water.usgs.gov/water-resources/software/MODFLOW-6/mf6.2.0.zip

RUN sudo apt-get install unzip -y
RUN unzip -o mf6.2.0.zip

RUN sudo mkdir -p /home/project/
WORKDIR /home/nonprivuser/mf6.2.0/make
RUN make -f makefile

COPY . /home/project
WORKDIR /home/project/install_lin

RUN sudo mkdir -p /usr/local/include
RUN sudo mv toolbox.mod /usr/local/include/
RUN sudo mv toolbox.o /usr/local/include/
RUN sudo mv toolbox_debug.o /usr/local/include/
RUN sudo cp ./src/toolbox_version.sh /usr/local/include/

WORKDIR /home/project/

# other optional installs

# RUN sudo apt-get install --no-install-recommends -yq octave
