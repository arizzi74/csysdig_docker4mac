# sysdig_docker4mac
Minimal container with sysdig and csysdig binaries and kernel module

## Build
docker build -t arizzi74/csysdig-0.23.1_docker4mac:$(docker version --format '{{.Server.Version}}') .

## Run
docker run -it --rm --name csysdig --privileged -v /var/run/docker.sock:/host/var/run/docker.sock -v /dev:/host/dev -v /proc:/host/proc:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro arizzi74/csysdig-0.23.1_docker4mac:$(docker version --format '{{.Server.Version}}')

## Credits
  - [Ethan Sutin](https://github.com/etown/install-sysdig-module)