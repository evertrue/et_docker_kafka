FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openjdk-7-jdk wget

ENV KAFKA_VERSION="0.8.2.1" SCALA_VERSION="2.11" LOG_DIR=/kafka JMX_PORT=19092

ENV KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

RUN wget http://psg.mtu.edu/pub/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O "/tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"

RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

VOLUME ["${LOG_DIR}"]

ADD kafka-graphite.jar ${KAFKA_HOME}/libs/kafka-graphite.jar

ADD log4j.properties $KAFKA_HOME/config/log4j.properties

ADD server.properties $KAFKA_HOME/config/server.properties

ADD configure_and_start_kafka /usr/local/bin/configure_and_start_kafka

RUN chmod +x /usr/local/bin/configure_and_start_kafka

EXPOSE 9092 $JMX_PORT

CMD configure_and_start_kafka