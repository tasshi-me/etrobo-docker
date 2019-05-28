FROM alpine:3.9
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

# Add repository
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/v3.3/main/ >> /etc/apk/repositories

# Install dependencies
RUN apk add -U --no-cache \
  alpine-sdk perl diffutils tar xz musl musl-dev \
  uboot-tools boost-dev=1.59.0-r0 \
  && rm -rf /var/cache/apk/*

# Install x86 dependencies
WORKDIR /tmp
RUN wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86/musl-1.1.20-r4.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86/musl-dev-1.1.20-r4.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86/libc6-compat-1.1.20-r4.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86/ncurses-libs-6.1_p20190105-r0.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86/libstdc%2B%2B-8.3.0-r0.apk
RUN apk add -U --allow-untrusted musl-1.1.20-r4.apk --no-cache
RUN apk add -U --allow-untrusted musl-dev-1.1.20-r4.apk --no-cache
RUN apk add -U --allow-untrusted libc6-compat-1.1.20-r4.apk --no-cache
RUN apk add -U --allow-untrusted ncurses-libs-6.1_p20190105-r0.apk --no-cache
RUN apk add -U --allow-untrusted libstdc%2B%2B-8.3.0-r0.apk --no-cache

#RUN wget -O - https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download | tar xzvf - -C /opt/
#WORKDIR /opt/boost_1_55_0
#RUN ash bootstrap.sh && ./b2 install -j2

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