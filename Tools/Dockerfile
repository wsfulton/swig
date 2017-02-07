FROM ubuntu:zesty
# For building SWIG
RUN apt-get update && apt-get -y install build-essential libpcre3-dev autoconf automake libtool bison git libboost-dev
# For python
RUN apt-get -y install python-dev
# For add-apt-repository
RUN apt-get -y install software-properties-common
# For gcc-7
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get -y install g++-7
#RUN echo "#!/bin/bash" > git-clone-swig
#RUN echo "git clone -q --branch=master https://github.com/wsfulton/swig.git" >> git-clone-swig
#RUN chmod ugo+x git-clone-swig
CMD "-c"
