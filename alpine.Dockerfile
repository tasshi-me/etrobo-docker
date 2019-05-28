FROM alpine:3.9
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

# Add repository
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

# Install dependencies
RUN apk add -U --no-cache \
  alpine-sdk perl diffutils tar xz \
  uboot-tools \
  && apk add -U --no-cache --arch x86 \
  libc6-compat 	ncurses-libs libstdc++ \
  && rm -rf /var/cache/apk/*

RUN wget -O - https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download | tar xzvf - -C /opt/
WORKDIR /opt/boost_1_55_0
RUN bootstrap.sh && ./b2 install -j2

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