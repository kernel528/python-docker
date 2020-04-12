[![Build Status](http://drone.kernelsanders.biz/api/badges/kernel528/python-docker/status.svg)](http://drone.kernelsanders.biz/kernel528/python-docker)

# This repo is used to build the orpheus-base-python suite of docker images.

### Comments
* The Dockerfile is unique to each python version, and is stored based on python version.
* This image uses the orpheus-base-alpine3 as its base image.
* The official docker hub repo is used as a template to install python:  
  * 3.8: https://github.com/docker-library/python/blob/master/3.8-rc/alpine3.9/Dockerfile
  * 3.8: https://github.com/docker-library/python/blob/master/3.8

#### How To build Manually:
``docker image build -t kernel528/python:3.8.2 -f 3.7/Dockerfile .``

#### How to use:
* By default the image has a CMD set to run python2 or python3 depending on the image.  You can pass python logic as command input to the container, or simply run the container and it will present the python prompt.
```
docker run -it --rm --name python3 --hostname python3 kernel528/python:3.8.2
Python 3.8.2 (default, Aug 27 2017, 06:14:56)
[GCC 6.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### Authors
* **kernel528** - (kernel528@gmail.com)
