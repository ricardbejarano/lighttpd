FROM debian:10 AS build

ARG PCRE_VERSION="8.43"
ARG PCRE_CHECKSUM="0b8e7465dc5e98c757cc3650a20a7843ee4c3edf50aaf60bb33fd879690d2c73"

ARG ZLIB_VERSION="1.2.11"
ARG ZLIB_CHECKSUM="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"

ARG LIGHTTPD_VERSION="1.4.54"
ARG LIGHTTPD_CHECKSUM="5151d38cb7c4c40effa13710e77ebdbef899f945b062cf32befc02d128ac424c"

ADD https://ftp.pcre.org/pub/pcre/pcre-$PCRE_VERSION.tar.gz /tmp/pcre.tar.gz
ADD https://zlib.net/zlib-$ZLIB_VERSION.tar.gz /tmp/zlib.tar.gz
ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$LIGHTTPD_VERSION.tar.gz /tmp/lighttpd.tar.gz

RUN [ "$PCRE_CHECKSUM" = "$(sha256sum /tmp/pcre.tar.gz | awk '{print $1}')" ] && \
    [ "$ZLIB_CHECKSUM" = "$(sha256sum /tmp/zlib.tar.gz | awk '{print $1}')" ] && \
    [ "$LIGHTTPD_CHECKSUM" = "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/pcre.tar.gz && \
    tar -C /tmp -xf /tmp/zlib.tar.gz && \
    tar -C /tmp -xf /tmp/lighttpd.tar.gz && \
    mv /tmp/lighttpd-$LIGHTTPD_VERSION /tmp/lighttpd

RUN apt update && \
    apt install -y gcc g++ make && \
    cd /tmp/pcre-$PCRE_VERSION && \
      ./configure && \
      make && \
      make install && \
    cd /tmp/zlib-$ZLIB_VERSION && \
      ./configure && \
      make && \
      make install && \
    cd /tmp/lighttpd && \
      ./configure --without-bzip2 && \
      make \
        CFLAGS="-fstack-protector-all" \
        LDFLAGS="-z relro -z now" && \
    echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd && \
    mkdir -p /tmp/tmp


FROM scratch

COPY --from=build --chown=100:100 /tmp/lighttpd/src/lighttpd /
COPY --from=build --chown=100:100 /tmp/tmp /tmp
COPY --from=build --chown=100:100 /tmp/lighttpd/src/.libs/mod_indexfile.so \
                                  /tmp/lighttpd/src/.libs/mod_dirlisting.so \
                                  /tmp/lighttpd/src/.libs/mod_staticfile.so \
                                  /usr/local/lib/
COPY --from=build --chown=100:100 /lib/x86_64-linux-gnu/libc.so.6 \
                                  /lib/x86_64-linux-gnu/libdl.so.2 \
                                  /lib/x86_64-linux-gnu/libnss_files.so.2 \
                                  /usr/local/lib/libpcre.so.1 \
                                  /lib/x86_64-linux-gnu/
COPY --from=build --chown=100:100 /lib64/ld-linux-x86-64.so.2 /lib64/
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
ENTRYPOINT ["/lighttpd"]
CMD ["-D", "-f", "/lighttpd.conf"]
