<div align="center">
	<p><img src="https://em-content.zobj.net/thumbs/160/apple/325/feather_1fab6.png" width="100px"></p>
	<h1>lighttpd</h1>
	<p>Built-from-source container image of <a href="https://www.lighttpd.net/">lighttpd</a></p>
	<code>docker pull quay.io/ricardbejarano/lighttpd</code>
</div>


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/lighttpd`](https://hub.docker.com/r/ricardbejarano/lighttpd):

- [`1.4.76`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/lighttpd`](https://quay.io/repository/ricardbejarano/lighttpd):

- [`1.4.76`, `latest` *(Dockerfile)*](Dockerfile)


## Configuration

### Volumes

- Mount your **configuration** at `/lighttpd.conf`.
