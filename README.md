[![Build Status](http://drone.kernelsanders.biz/api/badges/kernel528/python-docker/status.svg)](http://drone.kernelsanders.biz/kernel528/python-docker)

# This repo is used to build the orpheus-base-python suite of docker images.

### Comments
* The Dockerfile is unique to each python version, and is stored based on python version.
* This image uses the orpheus-base-alpine3 as its base image.
* The official docker hub repo is used as a template to install python:  
  * 2.7: https://github.com/docker-library/python/blob/master/2.7/alpine3.8/Dockerfile
  * 3.6: https://github.com/docker-library/python/blob/master/3.6/alpine3.8/Dockerfile

#### How To build Manually:
``docker image build -t kernel528/python:3.6.5 -f 3.6/Dockerfile .``

#### How to use:
* By default the image has a CMD set to run python2 or python3 depending on the image.  You can pass python logic as command input to the container, or simply run the container and it will present the python prompt.

```
docker run -it --rm --name python2 --hostname python2 kernel528/python:2.7.15
Python 2.7.13 (default, Aug 27 2017, 06:11:34)
[GCC 6.3.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

```
docker run -it --rm --name python3 --hostname python3 kernel528/python:3.6.5
Python 3.6.2 (default, Aug 27 2017, 06:14:56)
[GCC 6.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### Authors
* **kernel528** - (kernel528@gmail.com)
