FROM debian:stretch AS build

ARG LIGHTTPD_VERSION="1.4.50"
ARG LIGHTTPD_CHECKSUM="c9a9f175aca6db22ebebbc47de52c54a99bbd1dce8d61bb75103609a3d798235"

WORKDIR /tmp

ADD https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$LIGHTTPD_VERSION.tar.gz /tmp/lighttpd.tar.gz
RUN if [ "$LIGHTTPD_CHECKSUM" != "$(sha256sum /tmp/lighttpd.tar.gz | awk '{print $1}')" ]; then exit 1; fi && \
    tar xf /tmp/lighttpd.tar.gz

WORKDIR /tmp/lighttpd-$LIGHTTPD_VERSION
RUN apt update && \
    apt install -y gcc make && \
    sed -i -E 's/(pwd|grp)->(pw_uid|gr_gid) == 0/0/' src/server.c && \
    ./configure --without-pcre --without-zlib --without-bzip2 && \
    make && \
    make install


FROM gcr.io/distroless/base

COPY --from=build /usr/local/sbin/lighttpd /lighttpd
COPY --from=build /usr/local/lib/mod_indexfile.so /usr/local/lib/mod_dirlisting.so /usr/local/lib/mod_staticfile.so /usr/local/lib/

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

CMD ["/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
