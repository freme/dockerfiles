FROM ubuntu:16.04
MAINTAINER Thomas William <freme@web.de>

# archive.ubuntu.com was broken when i last tried to use it
RUN sed -i 's#http://archive.ubuntu.com/ubuntu/#http://ubuntu.mirror.tudos.de/ubuntu/#g' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y && apt-get upgrade -y && apt-get install -y apt-utils && \
apt-get install -y sudo \
nodejs \
git \
imagemagick \
ruby \
rake \
bundler \
libsqlite3-dev \
zlib1g-dev \
libmysqlclient-dev \
build-essential \
libssl-dev \
curl \
libcurl4-openssl-dev \
libreadline-gplv2-dev \
vim sed

RUN gem install passenger --no-rdoc --no-ri && \
yes '' | passenger-install-nginx-module

COPY nginx.conf /opt/nginx/conf/nginx.conf
RUN PASSENGER=$(passenger-config --root) && \
sed -i "s#PASSENGER#${PASSENGER}#g" /opt/nginx/conf/nginx.conf

RUN useradd --no-create-home --shell /bin/bash frab \
&& echo "frab ALL=(ALL:ALL) NOPASSWD: ALL" >/etc/sudoers.d/frab \
&& sed -i -e 's/^Defaults.*requiretty.*/#disabled/' /etc/sudoers \
&& mkdir /home/frab && chown -R frab:frab /home/frab

USER frab
WORKDIR /home/frab
RUN git clone https://github.com/frab/frab.git . && \
bundle install --without="postgresql" && \
cp -a public public_saved

EXPOSE 80
COPY init.sh /home/frab/init.sh
ENTRYPOINT ["/bin/bash", "/home/frab/init.sh"]
