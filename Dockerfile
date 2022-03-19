FROM alpine:3 AS build

ARG VERSION="1.4.64"
ARG CHECKSUM="71e46403fb28371a06b23ef1cceffd75285140c6f62a879c777ee5af0d248801"

ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$VERSION.tar.gz /tmp/lighttpd.tar.gz

RUN [ "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add bsd-compat-headers build-base pcre2-dev scons && \
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
