#!/bin/bash

# change the password of the GoPhish server to something random and output to the screen.
sudo apt -qq install -y sqlite apache2-utils

# create a random string password and salt value.
password=`sudo head /dev/urandom | tr -dc A-Za-z | head -c 13; echo ''`

hash=`htpasswd -bnBC 10 "" "$password" | tr -d ':\n' | sed 's/$2y/$2a/'`
echo "$password"

# place it in the SQLite Database
sudo sqlite3 /opt/gophish/gophish.db "update users set hash='$hash' where username='admin';"

