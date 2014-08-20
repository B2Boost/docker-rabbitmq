#!/bin/sh
rabbitmqctl add_vhost prod
rabbitmqctl add_user hermes "n9fEPcJ^C^Sz"
rabbitmqctl set_permissions -p prod hermes ".*" ".*" ".*"
