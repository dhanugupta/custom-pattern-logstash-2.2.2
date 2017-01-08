FROM java:8

MAINTAINER Dhanu Gupta <dhanu.gupta@gmail.com>

RUN apt-get update -y 
RUN apt-get install -y vim

# Download version 2.2.2 of logstash
RUN cd /tmp && \
	wget https://download.elasticsearch.org/logstash/logstash/logstash-2.2.2.tar.gz && \
    tar -xzvf ./logstash-2.2.2.tar.gz && \
    mv ./logstash-2.2.2 /opt/logstash && \
    rm ./logstash-2.2.2.tar.gz
ENV ENV dev

ADD logstash.* /app/

ADD patterns /opt/logstash/patterns

# Start logstash
CMD /opt/logstash/bin/logstash -f /app/logstash.$ENV.conf