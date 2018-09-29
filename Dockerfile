FROM alpine:latest
ARG SYSDIGVER=0.23.1

RUN apk add --no-cache --update wget ca-certificates \
    build-base gcc abuild binutils \
    bc cmake && \
    export KERNELVER=`uname -r  | cut -d '-' -f 1`  && \
    export KERNELDIR=/src/linux-$KERNELVER && \
    mkdir /src && \
    cd /src && \
    wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-$KERNELVER.tar.gz && \
    tar zxf linux-$KERNELVER.tar.gz && \
    cd /src/linux-$KERNELVER && \
    zcat /proc/1/root/proc/config.gz > .config && \
    make modules_prepare && \
    mv .config /src/config && \
    cd /src && \
    wget https://github.com/draios/sysdig/archive/$SYSDIGVER.tar.gz && \
    tar zxf $SYSDIGVER.tar.gz && \
    mkdir -p /sysdig/build && \
    cd /sysdig/build && \
    cmake /src/sysdig-$SYSDIGVER -DSYSDIG_VERSION=$SYSDIGVER && \
    make driver && \
    rm -rf /src && \
    cp /sysdig/build/driver/sysdig-probe.ko /lib && \
    cd / && \
    rm -fR /sysdig && \
    apk del wget ca-certificates \
    build-base gcc abuild binutils \
    bc \
    cmake && \
    apk add --no-cache --update xterm

ADD sysdig-bin-0.23.1.tar.gz /
ADD docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"] 
