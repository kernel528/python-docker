[![Build Status](https://drone.kernelsanders.biz:8443/api/badges/kernel528/python-docker/status.svg)](https://drone.kernelsanders.biz:8443/kernel528/python-docker)
[![Latest Version](https://img.shields.io/github/v/tag/kernel528/python-docker)](https://github.com/kernel528/python-docker/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/kernel528/python)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/kernel528/python?sort=semver)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kernel528/python)](https://hub.docker.com/r/kernel528/python)

## Overview
- Base image: `kernel528/alpine:3.24.3_3`
- This repo tracks Python 3.14 on Alpine.
- Upstream reference: https://github.com/docker-library/python/blob/master/3.14/alpine3.24/Dockerfile

## Repository Relationships and Refresh Policy

This independent image repository is coordinated by [`docker-workspace`](https://github.com/kernel528/docker-workspace) and uses [`kernel528/alpine`](https://github.com/kernel528/alpine-docker) as its custom base. Publish and verify the Alpine tag first, then rebuild, smoke-test, and release Python through this repository's own branch and tag workflow. Update [`docker-swarm`](https://github.com/kernel528/docker-swarm) only if a stack explicitly consumes the new Python image.

## CI validation and release policy

- Pull requests targeting `3.14` run the rootless exact-image Python smoke check; the job receives no registry credentials and publishes nothing.
- Pushes to `3.14` run rootless validation and build/smoke a fresh DIND candidate before a separate credentialed step publishes a unique build-number candidate tag.
- Tags are created manually from reviewed `main`. The tag pipeline freshly builds and smoke-tests the exact image, publishes the immutable tag first, then updates the Python version alias, minor-series alias, and `latest` to that same image.
- Candidate images are not deployment inputs. Python release tags are distinct from Alpine base tags.
- This repository is public. The rootless validation job runs without credentials inside the isolated guest; PR code therefore executes there with the guest's rootless Podman boundary.
- Add `kernel528/python-docker` to the isolated runner's exact repository allowlist only after reviewing this pipeline. Do not add wildcard repository patterns.

## Build
```
docker image build -t kernel528/python:3.14.9-3.24.3_3 -f Dockerfile .
```

## Run
- By default the image runs `python3`. You can pass python logic as command input to the container, or run it interactively.
```
docker run -it --rm --name python3 --hostname python3 kernel528/python:3.14.9-3.24.3_3
Python 3.14.9 (main, ... ) [GCC ...] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello World")
Hello World
>>> exit()
```

## Smoke test
```
docker run --rm kernel528/python:3.14.9-3.24.3_3 python --version
docker run --rm kernel528/python:3.14.9-3.24.3_3 python - <<'PY'
print("ok")
PY
```

## Authors
- **kernel528** - (kernel528@gmail.com)
