# The MIT License (MIT)
#
# Copyright (c) 2016-2017 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM ubuntu:14.04
WORKDIR /tmp

RUN apt-get update && apt-get install -y software-properties-common \
  && apt-add-repository ppa:brightbox/ruby-ng

RUN apt-get update && apt-get install -y \
  openjdk-7-jdk \
  git \
  openssh-server \
  curl \
  indent \
  doxygen \
  s3cmd \
  build-essential \
  patch \
  libxml2-utils \
  libmagic-dev=1:5.14-2ubuntu3.3 \
  zlib1g-dev=1:1.2.8.dfsg-1ubuntu1 \
  ruby2.2=2.2.4-1bbox1~trusty1 \
  ruby2.2-dev=2.2.4-1bbox1~trusty1 \
  && rm -rf /var/lib/apt/lists/*

RUN gem update && gem install \
  nokogiri:1.6.7.2 \
  bundler:1.11.2 \
  pdd:0.15.4 \
  est:0.3.1

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

