FROM ubuntu:14.04 

MAINTAINER	Yannick Saint Martino 

ENV PLAY_VERSION 2.1.0

RUN apt-get -y update

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

#install tools
RUN apt-get install -y curl wget unzip vim git sudo zip bzip2 fontconfig

#install jdk
RUN apt-get install --no-install-recommends -y openjdk-7-jdk

#install play framework
ADD http://downloads.typesafe.com/play/$PLAY_VERSION/play-$PLAY_VERSION.zip /tmp/play-$PLAY_VERSION.zip
RUN (cd /opt && unzip /tmp/play-$PLAY_VERSION.zip && rm -f /tmp/play-$PLAY_VERSION.zip && chmod 777 /opt/play-$PLAY_VERSION)

# install SSH server so we can connect multiple times to the container
RUN apt-get -y install openssh-server \
&& rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN echo 'root:toor' |chpasswd
RUN groupadd playuser && useradd playuser -s /bin/bash -m -g playuser -G playuser && adduser playuser sudo
RUN echo 'playuser:playuser' |chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir -p /home/playuser/workspace

RUN echo "PATH=/opt/play-$PLAY_VERSION:$PATH" >> /home/playuser/.bashrc
RUN chmod 777 -R /opt/play-$PLAY_VERSION

VOLUME ["/opt/workspace"]
WORKDIR /opt/workspace

EXPOSE 22
EXPOSE 9000

CMD /usr/sbin/sshd -D

