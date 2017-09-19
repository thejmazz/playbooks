#!/usr/bin/env bash

set -e
set -o pipefail

INTERFACE="$1"
test -z "$1" && INTERFACE="eth0"
USER="$2"
test -z "$2" && USER="root"
PLAYBOOK="$3"
test -z "$3" && PLAYBOOK="bootstrap"

IP=`ip addr show dev ${INTERFACE} | awk -F'[ /]*' '/inet /{print $3}'`

docker-compose pull
docker-compose run --rm ansible -b -u ${USER} -i "${IP}," ./plays/${PLAYBOOK}.yml
