<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/satellite_1f6f0.png width=120px></p>
<h1 align=center>lighttpd (Docker image)</h1>
<p align=center>Built-from-source container image of the <a href=https://www.lighttpd.net/>Lighttpd HTTP server</a></p>

Available at [`ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd).


## Tags

[`1.4.53-glibc`, `1.4.53`, `glibc`, `latest` *(glibc/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/glibc/Dockerfile)

[`1.4.53-musl`, `musl` *(musl/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/musl/Dockerfile)


## Features

* Super tiny (`glibc`-based is `~3.41MB` and `musl`-based is `~2.98MB`)
* Built from source
* Built from `scratch`, see the [Filesystem](#Filesystem) section below for an exhaustive list of the image's contents
* Included `lighttpd.conf` optimized for secure and performant static file serving
* Reduced attack surface (no `bash`, no UNIX tools, no package manager...)

## Volumes

Mount your **content** in `/etc/lighttpd/html`.


## Filesystem

The images' contents are:

### `glibc`

Based on the [glibc](https://www.gnu.org/software/libc/) implementation of `libc`.

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
│       └── libnss_files.so.2
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

Based on the [musl](https://www.musl-libc.org/) implementation of `libc`.

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
