<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/satellite_1f6f0.png width=120px></p>
<h1 align=center>lighttpd (Docker image)</h1>
<p align=center>Built-from-source container image of the <a href=https://www.lighttpd.net/>Lighttpd HTTP server</a></p>

Available at [`ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd).


## Tags

[`1.4.53-glibc`, `1.4.53`, `glibc`, `latest` *(glibc/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/glibc/Dockerfile)

[`1.4.53-musl`, `musl` *(musl/Dockerfile)*](https://github.com/ricardbejarano/lighttpd/blob/master/musl/Dockerfile)


## Features

* Super tiny (`glibc`-based is `~2.94MB` and `musl`-based is `~3.58MB`)
* Built from source, including libraries
* Built from `scratch`, see the [Filesystem](#Filesystem) section below for an exhaustive list of the image's contents
* Included `lighttpd.conf` optimized for secure and performant static file serving
* Reduced attack surface (no `bash`, no UNIX tools, no package manager...)
* Built with exploit mitigations enabled (see [Security](#Security))


## Building

To build the `glibc`-based image:

```bash
docker build -t lighttpd:glibc -f glibc/Dockerfile .
```

To build the `musl`-based image:

```bash
docker build -t lighttpd:musl -f musl/Dockerfile .
```


## Security

This image attempts to build a secure Lighttpd Docker image.

It does so by the following ways:

- downloading and verifying the source code of Lighttpd and every library it is built with,
- packaging the image with only those files required during runtime (see [Filesystem](#Filesystem)),
- by enforcing a series of exploit mitigations (PIE, full RELRO, full SSP, NX and Fortify)

### Verifying the presence of exploit mitigations

To check whether a binary in a Docker image has those mitigations enabled, use [tests/checksec.sh](https://github.com/ricardbejarano/lighttpd/blob/master/tests/checksec.sh).

#### Usage

```
usage: checksec.sh docker_image executable_path

Docker-based wrapper for checksec.sh.
Requires a running Docker daemon.

Example:

  $ checksec.sh ricardbejarano/lighttpd:glibc /lighttpd

  Extracts the '/lighttpd' binary from the 'ricardbejarano/lighttpd:glibc' image,
  downloads checksec (github.com/slimm609/checksec.sh) and runs it on the
  binary.
  Everything runs inside Docker containers.
```

#### Example:

Testing the `/lighttpd` binary in `ricardbejarano/lighttpd:glibc`:

```
$ bash tests/checksec.sh ricardbejarano/lighttpd:glibc /lighttpd
Downloading ricardbejarano/lighttpd:glibc...Done!
Extracting ricardbejarano/lighttpd:glibc:/lighttpd...Done!
Downloading checksec.sh...Done!
Running checksec.sh:
RELRO        STACK CANARY   NX           PIE           RPATH      RUNPATH      Symbols         FORTIFY   Fortified   Fortifiable   FILE
Full RELRO   Canary found   NX enabled   PIE enabled   No RPATH   No RUNPATH   1133 Symbols    Yes       0           20            /tmp/.checksec-fRo4rDWP
Cleaning up...Done!
```

This wrapper script works with any binary in a Docker image. Feel free to use it with any other image.

Other examples:

- `bash tests/checksec.sh debian /bin/bash`
- `bash tests/checksec.sh alpine /bin/sh`


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
