#!/bin/bash

# let's double check the ssh keys
chmod 600 ../ssh_keys/*


# get Swarm Worker Token
read -p "Enter Worker Token: " worker_token

for filename in ../ssh_keys/*; do
	if [[ $filename == *portainer_server_* ]]; then
		if ! [ ${filename: -4} == ".pub" ]; then
			server_ip="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$filename")"
			echo $server_ip
		fi
	fi
done

for filename in ../ssh_keys/*; do
	if [[ $filename == *portainer_server_* ]]; then
		echo "do nothing to the server."
	elif ! [ ${filename: -4} == ".pub" ]; then
		ip="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$filename")"
     	ssh -i $filename -oStrictHostKeyChecking=no admin@$ip -t "sudo $worker_token"
     fi
 done
