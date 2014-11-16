docker-rabbitmq
=====================

Base docker image to run a RabbitMQ server




Usage
-----

To create the image `b2boost/rabbitmq`, execute the following command on the tutum-rabbitmq folder:

	sudo docker build -t b2boost/rabbitmq .




Running the RabbitMQ server
---------------------------

Run the following command to start rabbitmq:

    docker run -e RABBITMQ_PASSWORD="pass" -e RABBITMQ_USER=user -e RABBITMQ_VHOST=vhost  -d -p 15672:15672 -p 5672:5672  b2boost/rabbitmq

At this point you need to configure the secure users and passwords via the management console.

Then commit with this command:

    docker commit -m "Configured rabbitmq" <containerID of running container> b2boost/rabbitmq:<tag>


Get the logs of the container by running:

	docker logs <CONTAINER_ID>


