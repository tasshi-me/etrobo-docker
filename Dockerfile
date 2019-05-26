FROM ubuntu:16.04
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get -yqq update \
    && apt-get -yqq install \
    build-essential ca-certificates wget bzip2 \
    libc6:i386 libncurses5:i386 libstdc++6:i386 \
    --no-install-recommends \
    && apt-get -yqq autoremove \
    && apt-get -yqq clean \
    && rm -rf /var/lib/apt/lists* /var/tmp/* /tmp/* 

RUN wget -O - https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 | tar jxvf - -C /opt/
ENV PATH $PATH:/opt/gcc-arm-none-eabi-5_4-2016q3/bin
