[![Build Status](http://drone.kernelsanders.biz:8080/api/badges/kernel528/python-docker/status.svg)](http://drone.kernelsanders.biz:8080/kernel528/python-docker)
[![Latest Version](https://img.shields.io/github/v/tag/kernel528/python-docker)](https://github.com/kernel528/python-docker/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/kernel528/python)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/kernel528/python?sort=semver)](https://hub.docker.com/r/kernel528/python)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kernel528/python)](https://hub.docker.com/r/kernel528/python)

### Comments
- The Dockerfile is unique to each python version, and is stored based on python version.
- This image uses the `kernel528/alpine` as its base image.
- The official docker hub repo is used as a template to install python:  
  - 3.13: https://github.com/docker-library/python/blob/master/3.13/alpine3.21/Dockerfile

#### How To build Manually:
``docker image build -t kernel528/python:3.13.0 -f 3.13/Dockerfile .``

#### How to use:
-By default the image has a CMD set to run python2 or python3 depending on the image.  You can pass python logic as command input to the container, or simply run the container and it will present the python prompt.
```
docker run -it --rm --name python3 --hostname python3 kernel528/python:3.13.0
Python 3.13.0 (main, Dec  8 2024, 17:27:43) [GCC 13.2.1 20240309] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello World")
Hello World
>>> exit()
```

### Authors
-**kernel528** - (kernel528@gmail.com)
