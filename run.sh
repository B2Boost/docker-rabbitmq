#!/bin/bash


if [ -f /.configured ]; then
	echo "RabbitMQ already configured!"
    echo "Starting rabbitmq server ..."
    service rabbitmq-server restart
	exit 0
fi


chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

echo "Enabling rabbitmq_management ..."
/usr/sbin/rabbitmq-plugins enable rabbitmq_management >/dev/null

# Start rabbitmq server
echo "Starting rabbitmq server ..."
service rabbitmq-server restart >/dev/null

RABBITMQ_USER=${RABBITMQ_USER:-"admin"}
RABBITMQ_PASSWORD=${RABBITMQ_PASSWORD:-"d1ff1cult@123"}
RABBITMQ_VHOST=${RABBITMQ_VHOST:-"/"}

echo "Removing 'guest' user and adding '$RABBITMQ_USER' user to rabbitmq with password '$RABBITMQ_PASSWORD'"
/usr/sbin/rabbitmqctl add_vhost $RABBITMQ_VHOST  >/dev/null
/usr/sbin/rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD >/dev/null
/usr/sbin/rabbitmqctl set_user_tags $RABBITMQ_USER administrator >/dev/null
/usr/sbin/rabbitmqctl set_permissions -p $RABBITMQ_VHOST $RABBITMQ_USER ".*" ".*" ".*" >/dev/null
/usr/sbin/rabbitmqctl delete_user guest >/dev/null

# Stop rabbitmq server , starting will be done by supervisord
echo "Stopping rabbitmq server ..."
service rabbitmq-server stop >/dev/null

touch /.configured

echo "Starting rabbitmq server ..."

#service rabbitmq-server restart

/usr/sbin/rabbitmq-server

