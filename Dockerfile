FROM debian:stretch AS build

ARG LIGHTTPD_VERSION="1.4.53"
ARG LIGHTTPD_CHECKSUM="423b3951f212e3a30511eb86f4662a1848c6e857074289ff23fc310eef520266"

WORKDIR /tmp
ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$LIGHTTPD_VERSION.tar.gz /tmp/lighttpd.tar.gz
RUN if [ "$LIGHTTPD_CHECKSUM" != "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" ]; then exit 1; fi && \
    tar xf /tmp/lighttpd.tar.gz && \
    mv /tmp/lighttpd-$LIGHTTPD_VERSION /tmp/lighttpd

WORKDIR /tmp/lighttpd
RUN apt update && \
    apt install -y gcc make && \
    sed -i -E 's/(pwd|grp)->(pw_uid|gr_gid) == 0/0/' src/server.c && \
    ./configure --without-pcre --without-zlib --without-bzip2 && \
    make


FROM gcr.io/distroless/base

COPY --from=build /tmp/lighttpd/src/lighttpd /lighttpd
COPY --from=build \
     /tmp/lighttpd/src/.libs/mod_indexfile.so \
     /tmp/lighttpd/src/.libs/mod_dirlisting.so \
     /tmp/lighttpd/src/.libs/mod_staticfile.so \
     /usr/local/lib/

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

CMD ["/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
