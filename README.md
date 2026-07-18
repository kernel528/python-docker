[![Build Status](http://drone.kernelsanders.biz:8080/api/badges/kernel528/python-docker/status.svg)](http://drone.kernelsanders.biz:8080/kernel528/python-docker)
[![Latest Version](https://img.shields.io/github/v/tag/kernel528/python-docker)](https://github.com/kernel528/python-docker/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/kernel528/python)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/kernel528/python?sort=semver)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kernel528/python)](https://hub.docker.com/r/kernel528/python)

## Overview
- Base image: `kernel528/alpine:3.24.1_1`
- This repo tracks Python 3.14 on Alpine.
- Upstream reference: https://github.com/docker-library/python/blob/master/3.14/alpine3.24/Dockerfile

## Build
```
docker image build -t kernel528/python:3.14.6-3.24.1_1 -f Dockerfile .
```

## Run
- By default the image runs `python3`. You can pass python logic as command input to the container, or run it interactively.
```
docker run -it --rm --name python3 --hostname python3 kernel528/python:3.14.6-3.24.1_1
Python 3.14.2 (main, ... ) [GCC ...] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello World")
Hello World
>>> exit()
```

## Smoke test
```
docker run --rm kernel528/python:3.14.6-3.24.1_1 python --version
docker run --rm kernel528/python:3.14.6-3.24.1_1 python - <<'PY'
print("ok")
PY
```

## Authors
- **kernel528** - (kernel528@gmail.com)
