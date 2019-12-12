FROM ubuntu:18.04
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get -yqq update \
    && apt-get -yqq remove binutils-arm-none-eabi gcc-arm-none-eabi \
    && apt-get -yqq install \
    build-essential diffutils ca-certificates wget bzip2 unzip \
    libc6:i386 libncurses5:i386 libstdc++6:i386 \
    u-boot-tools libboost1.58-all-dev \
    --no-install-recommends \
    && apt-get -yqq autoremove \
    && apt-get -yqq clean \
    && rm -rf /var/lib/apt/lists* /var/tmp/* /tmp/* 

RUN wget -O - https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 | tar jxvf - -C /opt/
ENV PATH $PATH:/opt/gcc-arm-none-eabi-5_4-2016q3/bin

WORKDIR /opt
RUN wget http://www.toppers.jp/download.cgi/ev3rt-beta7-2-release.zip
RUN unzip ev3rt-beta7-2-release.zip && rm ev3rt-beta7-2-release.zip
WORKDIR /opt/ev3rt-beta7-2-release
RUN tar Jxvf hrp2.tar.xz && rm hrp2.tar.xz
WORKDIR /opt/ev3rt-beta7-2-release/hrp2/cfg/
RUN make
WORKDIR /opt/ev3rt-beta7-2-release/hrp2/