<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/satellite_1f6f0.png" width="120px"></p>
<h1 align="center">lighttpd (container image)</h1>
<p align="center">Built-from-source container image of the <a href="https://www.lighttpd.net/">Lighttpd</a> HTTP server</p>


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd):

- [`1.4.58`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/lighttpd`](https://quay.io/repository/ricardbejarano/lighttpd):

- [`1.4.58`, `latest` *(Dockerfile)*](Dockerfile)


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Statically linked to the [`musl`](https://musl.libc.org/) implementation of the C standard library
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build --tag ricardbejarano/lighttpd --file Dockerfile .
```


## Configuration

### Volumes

- Mount your **configuration** at `/lighttpd.conf`.


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
