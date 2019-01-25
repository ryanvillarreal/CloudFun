#!/bin/bash

# Let's update and install necessary packages
sudo apt update && sudo apt install git golang-go

# we need to change SSH ports for the actual connection. # you can customize port as you see fit.  
sudo sed -i "s/#Port 22/Port 49155/" /etc/ssh/sshd_config
sudo /etc/init.d/sshd restart

# This is sshsryup that allows for connections to be recorded and uploaded to asciicinema
cd /opt
sudo wget https://github.com/mkishere/sshsyrup/releases/download/v0.6.1/sshsyrup-v0.6.1-linux-amd64.tar.gz
sudo gunzip x sshsyrup-v0.6.1-linux-amd64.tar.gz
sudo tar xvf sshsyrup-v0.6.1-linux-amd64.tar

# Setup SSHsryup
sudo ./createfs -p / -o filesystem.zip
sudo ssh-keygen -f id_rsa -t rsa -N ''
