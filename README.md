<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/satellite_1f6f0.png" width="120px"></p>
<h1 align="center">lighttpd (container image)</h1>
<p align="center">Built-from-source container image of the <a href="https://www.lighttpd.net/">Lighttpd HTTP server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd):

- [`1.4.54-glibc`, `1.4.54`, `glibc`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/lighttpd/blob/master/Dockerfile.glibc) (about `3.21MB`)
- [`1.4.54-musl`, `musl` *(Dockerfile.musl)*](https://github.com/ricardbejarano/lighttpd/blob/master/Dockerfile.musl) (about `3.53MB`)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/lighttpd-glibc`](https://quay.io/repository/ricardbejarano/lighttpd-glibc), tags: [`1.4.54`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/lighttpd/blob/master/Dockerfile.glibc) (about `3.21MB`)
- [`quay.io/ricardbejarano/lighttpd-musl`](https://quay.io/repository/ricardbejarano/lighttpd-musl), tags: [`1.4.54`, `master`, `latest` *(Dockerfile.musl)*](https://github.com/ricardbejarano/lighttpd/blob/master/Dockerfile.musl) (about `3.53MB`)


## Features

* Super tiny (see [Tags](#tags))
* Compiled from source (with binary exploit mitigations) during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Configuration

### Volumes

- Mount your **configuration** at `/lighttpd.conf`.


## Building

- To build the `glibc`-based image: `$ docker build -t lighttpd:glibc -f Dockerfile.glibc .`
- To build the `musl`-based image: `$ docker build -t lighttpd:musl -f Dockerfile.musl .`


## Filesystem

### `glibc`

Based on the [glibc](https://www.gnu.org/software/libc/) implementation of `libc`. Dynamically linked.

```
/
├── etc/
│   ├── group
│   └── passwd
├── lib/
│   └── x86_64-linux-gnu/
│       ├── libc.so.6
│       ├── libdl.so.2
│       ├── libnss_files.so.2
│       └── libpcre.so.1
├── lib64/
│   └── ld-linux-x86-64.so.2
├── lighttpd
├── tmp/
└── usr/
    └── local/
        └── lib/
            ├── mod_dirlisting.so
            ├── mod_indexfile.so
            └── mod_staticfile.so
```

### `musl`

Based on the [musl](https://www.musl-libc.org/) implementation of `libc`. Statically linked.

```
/
├── etc/
│   ├── group
│   └── passwd
├── lib/
│   ├── ld-musl-x86_64.so.1
│   ├── libc.musl-x86_64.so.1
│   ├── libpcre.so.1
│   └── libz.so.1.2.11
├── lighttpd
├── tmp/
└── usr/
    └── local/
        └── lib/
            ├── mod_dirlisting.so
            ├── mod_indexfile.so
            └── mod_staticfile.so
```


## License

See [LICENSE](https://github.com/ricardbejarano/lighttpd/blob/master/LICENSE).
