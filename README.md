# Webpack Template

Basic webpack boilerplate with react. This branch also includes a dockerfile for building.

### Usage

To build a docker image run:

```
./build.bash
```

To run the image use the following:

```
docker run -it --rm -p 8888:80 webpack-docker-template:latest
```

Running:

```
./build_and_run.bash
```

Combines the docker build and docker run.



