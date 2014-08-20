FROM ubuntu:trusty
MAINTAINER Luis Muniz <lmu@b2boost.net>

# Install RabbitMQ
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server


# ENABLE MANAGEMENT INTERFACE
RUN rabbitmq-plugins enable rabbitmq_management

#COPY CONFIG FILE
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

ADD configure.sh /configure.sh
RUN chmod 755 ./*.sh

CMD ["/configure.sh"]

# EXPOSE RABBITMQ PORT AND MANAGEMENT UI PORT
EXPOSE 5672 15672

# SET THE CONTAINER ENTRYPOINT TO THE RABBITMQ EXECUTABLE
ENTRYPOINT /usr/sbin/rabbitmq-server


