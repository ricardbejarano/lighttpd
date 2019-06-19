<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/satellite_1f6f0.png width=120px></p>
<h1 align=center>lighttpd (container image)</h1>
<p align=center>Built-from-source container image of the <a href=https://www.lighttpd.net/>Lighttpd HTTP server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd):

- [`1.4.54-glibc`, `1.4.54`, `glibc`, `master`, `latest` *(glibc/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/glibc/Dockerfile)
- [`1.4.54-musl`, `musl` *(musl/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/musl/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/lighttpd-glibc`](https://quay.io/repository/ricardbejarano/lighttpd-glibc), tags: [`1.4.54`, `master`, `latest` *(glibc/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/glibc/Dockerfile)
- [`quay.io/ricardbejarano/lighttpd-musl`](https://quay.io/repository/ricardbejarano/lighttpd-musl), tags: [`1.4.54`, `master`, `latest` *(musl/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/musl/Dockerfile)


## Features

* Super tiny (`glibc`-based is `~2.94MB` and `musl`-based is `~3.57MB`)
* Compiled from source during build time
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Included `lighttpd.conf` optimized for secure and performant static file server
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Built with binary exploit mitigations enabled


## Configuration

### Volumes

- Bind your **configuration** at `/etc/lighttpd/lighttpd.conf`.


## Building

- To build the `glibc`-based image: `$ docker build -t lighttpd:glibc -f glibc/Dockerfile .`
- To build the `musl`-based image: `$ docker build -t lighttpd:musl -f musl/Dockerfile .`


## Filesystem

The images' contents are:

### `glibc`

Based on the [glibc](https://www.gnu.org/software/libc/) implementation of `libc`. Dynamically linked.

```
/
├── etc/
│   ├── group
│   ├── lighttpd/
│   │   ├── html/
│   │   │   └── index.html
│   │   └── lighttpd.conf
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
│   └── .keep
└── usr/
    └── local/
        └── lib/
            ├── mod_dirlisting.so
            ├── mod_indexfile.so
            └── mod_staticfile.so
```

### `musl`

Based on the [musl](https://www.musl-libc.org/) implementation of `libc`. Dynamically linked.

```
/
├── etc/
│   ├── group
│   ├── lighttpd/
│   │   ├── html/
│   │   │   └── index.html
│   │   └── lighttpd.conf
│   └── passwd
├── lib/
│   ├── ld-musl-x86_64.so.1
│   ├── libc.musl-x86_64.so.1
│   ├── libpcre.so.1
│   └── libz.so.1.2.11
├── lighttpd
├── tmp/
│   └── .keep
└── usr/
    └── local/
        └── lib/
            ├── mod_dirlisting.so
            ├── mod_indexfile.so
            └── mod_staticfile.so
```


## License

See [LICENSE](https://github.com/ricardbejarano/lighttpd/blob/master/LICENSE).
