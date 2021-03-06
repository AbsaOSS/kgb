#!/bin/sh

# Small script to continously poll demo podinfo fqdn to show k8gb in action
# $1 - nameserver to use usually k8gb-coredns service ip
# $2 - test fqdn to resolve in demo loops

if [ "$1" != '--local' ]
then
    echo "nameserver $1" > /etc/resolv.conf
fi

fqdn="$2"

while true
do
  curl -k -s -w "%{stderr}\n%{http_code}\n" --location --request GET "${fqdn}" |grep message
  sleep 5
  echo "[`date`] ..."
done
