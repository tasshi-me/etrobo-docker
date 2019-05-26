FROM alpine:3.9
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

RUN wget -O - https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 | tar jxvf - -C /opt/
RUN export PATH=$PATH:$opt/gcc-arm-none-eabi-5_4-2016q3/bin
