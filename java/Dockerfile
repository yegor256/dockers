# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Java+Maven projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ENV MAVEN_OPTS=-Xmx1g
ENV JAVA_OPTS=-Xmx1g
ENV JAVA_VERSION=17
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}
RUN apt-get --yes --fix-missing update \
  && apt-get --yes --no-install-recommends install ca-certificates-java=* ca-certificates=* "openjdk-${JAVA_VERSION}-jdk=*" \
  && update-ca-certificates \
  && ln -s "/usr/lib/jvm/$(find /usr/lib/jvm -name "java-1.${JAVA_VERSION}*" -exec basename {} \;)" "/usr/lib/jvm/java-${JAVA_VERSION}" \
  && echo "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}" >> "${HOME}/.profile" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV MAVEN_VERSION=3.9.9
ENV M2_HOME=/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}
RUN echo "export M2_HOME=/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}" >> "${HOME}/.profile" \
  && wget --quiet "https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
  && mkdir -p /usr/local/apache-maven \
  && mv "apache-maven-${MAVEN_VERSION}-bin.tar.gz" /usr/local/apache-maven \
  && tar xzvf "/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -C /usr/local/apache-maven/ \
  && update-alternatives --install /usr/bin/mvn mvn "${M2_HOME}/bin/mvn" 1 \
  && update-alternatives --config mvn \
  && mvn dependency:get -Dartifact=junit:junit:4.11

ENV GRADLE_VERSION=9.0.0
RUN wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -P /tmp \
  && unzip -d /opt "/tmp/gradle-${GRADLE_VERSION}-bin.zip" \
  && chmod a+x "/opt/gradle-${GRADLE_VERSION}/bin/gradle" \
  && ln -s "/opt/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
  && echo "export PATH=${PATH}:/opt/gradle-${GRADLE_VERSION}/bin" >> "${HOME}/.profile"
