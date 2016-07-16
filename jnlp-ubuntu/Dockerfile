FROM ubuntu:16.04

# https://github.com/cloudbees/java-build-tools-dockerfile/raw/master/Dockerfile

RUN dpkg --add-architecture i386 && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install software-properties-common

#VOLUME ["/var/run/docker.sock"]

RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    iproute \
    openssh-client ssh-askpass\
    ca-certificates \
    openjdk-8-jdk \
    maven ant \
    nodejs npm \
    tar zip unzip \
    wget curl \
    git \
    build-essential \
    less nano tree \
    python python-pip groff \
    rlwrap \
    mysql-client \
    sudo \
    docker.io \
    ruby \
    rpm rpm-common \
    libc6:i386 uuid-dev zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#==========
# Selenium
#==========
RUN  mkdir -p /opt/selenium \
  && wget --no-verbose http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar -O /opt/selenium/selenium-server-standalone.jar

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd jenkins --shell /bin/bash --create-home \
  && usermod -a -G sudo jenkins \
  && usermod -a -G docker jenkins \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'jenkins:secret' | chpasswd


# https://raw.githubusercontent.com/SeleniumHQ/docker-selenium/master/NodeFirefox/Dockerfile

#===============
# XVFB & FIREFOX
#===============
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    xvfb firefox \
  && rm -rf /var/lib/apt/lists/*

#========================
# Selenium Configuration
#========================
COPY config.json /opt/selenium/config.json

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

# https://github.com/SeleniumHQ/docker-selenium/blob/master/StandaloneFirefox/Dockerfile

#====================================
# Scripts to run Selenium Standalone
#====================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

#====================================
# AWS CLI
#====================================
RUN pip install --upgrade pip; pip install setuptools; pip install awscli

# compatibility with CloudBees AWS CLI Plugin which expects pip to be installed as user
RUN mkdir -p /home/jenkins/.local/bin/ \
  && ln -s /usr/bin/pip /home/jenkins/.local/bin/pip \
  && chown -R jenkins:jenkins /home/jenkins/.local

#====================================
# BOWER, GRUNT, GULP
#====================================

RUN npm install --global grunt-cli@0.1.2 bower@1.7.9 gulp@3.9.1

#====================================
# JMETER
#====================================
RUN mkdir /opt/jmeter \
      && wget -O - "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-3.0.tgz" \
      | tar -xz --strip=1 -C /opt/jmeter

# https://raw.githubusercontent.com/cloudbees/jnlp-slave-with-java-build-tools-dockerfile/master/jenkins-slave

#====================================
# JENKINS SLAVE
#====================================

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.60/remoting-2.60.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN rm -rf /var/run/docker.sock; chmod a+rwx /home/jenkins; chmod +x /usr/local/bin/jenkins-slave; chmod +x /opt/bin/entry_point.sh

WORKDIR /home/jenkins
USER jenkins

# for dev purpose
# USER root

ENV REMOTING_OPTS -Dhudson.remoting.Launcher.pingIntervalSec=-1
ENTRYPOINT ["/opt/bin/entry_point.sh", "/usr/local/bin/jenkins-slave"]

EXPOSE 4444
