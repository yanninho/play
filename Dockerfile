FROM ubuntu:14.04 

MAINTAINER	Yannick Saint Martino 

ENV PLAY_VERSION 2.1.0
ENV PATH $PATH:/opt/play-$PLAY_VERSION

RUN apt-get -y update

#install tools
RUN apt-get install -y unzip

#install jdk
RUN apt-get install --no-install-recommends -y openjdk-7-jdk

#install play framework
ADD http://downloads.typesafe.com/play/$PLAY_VERSION/play-$PLAY_VERSION.zip /tmp/play-$PLAY_VERSION.zip
RUN (cd /opt && unzip /tmp/play-$PLAY_VERSION.zip && rm -f /tmp/play-$PLAY_VERSION.zip && chmod 777 -R /opt/play-$PLAY_VERSION)
RUN ln -s /opt/play-$PLAY_VERSION/play /usr/local/bin/play 

VOLUME ["/opt/workspace"]
WORKDIR /opt/workspace
EXPOSE 9000

