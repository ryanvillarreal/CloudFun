#!/bin/bash

sudo docker swarm init
manager_token=$(sudo docker swarm join-token manager -q)
worker_token=$(sudo docker swarm join-token worker -q)
sudo curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o /tmp/portainer-agent-stack.yml
sudo docker stack deploy --compose-file=/tmp/portainer-agent-stack.yml portainer
sudo echo $worker_token