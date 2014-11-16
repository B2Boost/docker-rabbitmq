FROM ubuntu:trusty
MAINTAINER Luis Muniz <lmu@b2boost.net>

# Make sure rabbitmq always uses one host name, not the docker assigned host name
ENV HOSTNAME localhost

# Install RabbitMQ
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server

# ENABLE MANAGEMENT INTERFACE
RUN rabbitmq-plugins enable rabbitmq_management

# Add scripts
ADD run.sh /run.sh
RUN chmod 755 ./*.sh

# EXPOSE RABBITMQ PORT AND MANAGEMENT UI PORT
EXPOSE 5672 15672

# SET THE CONTAINER ENTRYPOINT TO THE RABBITMQ EXECUTABLE
ENTRYPOINT /run.sh