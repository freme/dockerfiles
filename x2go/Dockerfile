FROM ubuntu:16.04
MAINTAINER Thomas William "freme@web.de"

RUN apt-get update -y && apt-get upgrade -y && apt-get -y install python-software-properties software-properties-common
ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:x2go/stable && apt-get update
RUN apt-get -y install openssh-server lxde
RUN apt-get -y install x2goserver x2goserver-xsession x2golxdebindings pwgen pulseaudio libcurl3 libappindicator1 fonts-liberation
RUN apt-get -y install virt-manager sudo ssh-askpass libpango1.0-0

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i google-chrome*.deb && apt-get install -f && rm -f google-chrome*.deb
#RUN ln -s /chrome.sh /usr/bin/chrome

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
#ADD chrome.sh /chrome.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
