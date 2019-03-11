FROM debian:stretch AS build

ARG LIGHTTPD_VERSION="1.4.53"
ARG LIGHTTPD_CHECKSUM="423b3951f212e3a30511eb86f4662a1848c6e857074289ff23fc310eef520266"
ARG LIGHTTPD_CONFIG="\
    --without-pcre \
    --without-zlib \
    --without-bzip2"

ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$LIGHTTPD_VERSION.tar.gz /tmp/lighttpd.tar.gz

RUN cd /tmp && \
    if [ "$LIGHTTPD_CHECKSUM" != "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" ]; then exit 1; fi && \
    tar xf /tmp/lighttpd.tar.gz && \
    mv /tmp/lighttpd-$LIGHTTPD_VERSION /tmp/lighttpd

RUN cd /tmp/lighttpd && \
    apt update && \
    apt install -y gcc make && \
    sed -i -E 's/(pwd|grp)->(pw_uid|gr_gid) == 0/0/' src/server.c && \
    ./configure $LIGHTTPD_CONFIG && \
    make


FROM scratch

COPY rootfs /

COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 \
                  /lib/x86_64-linux-gnu/libdl.so.2 \
                  /lib/x86_64-linux-gnu/libnss_files.so.2 \
                  /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 \
                  /lib64/
COPY --from=build /tmp/lighttpd/src/.libs/mod_indexfile.so \
                  /tmp/lighttpd/src/.libs/mod_dirlisting.so \
                  /tmp/lighttpd/src/.libs/mod_staticfile.so \
                  /usr/local/lib/
COPY --from=build /tmp/lighttpd/src/lighttpd /lighttpd

STOPSIGNAL SIGTERM

CMD ["/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
