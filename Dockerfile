FROM debian:stable AS build

ARG VERSION="1.4.58"
ARG CHECKSUM="49c03789876f6ee5bee82bae0aee375d45bd508a6dd016da0b55e80d15f2b5a3"

ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$VERSION.tar.gz /tmp/lighttpd.tar.gz

RUN [ "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apt update && \
    apt install -y build-essential libpcre3-dev scons && \
    tar -C /tmp -xf /tmp/lighttpd.tar.gz && \
    cd /tmp/lighttpd-$VERSION && \
      scons -j 4 build_fullstatic=1 build_dynamic=0

RUN mkdir -p /rootfs/bin && \
      cp /tmp/lighttpd-$VERSION/sconsbuild/fullstatic/build/lighttpd /rootfs/bin/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
ENTRYPOINT ["/bin/lighttpd"]
CMD ["-D", "-f", "/lighttpd.conf"]
