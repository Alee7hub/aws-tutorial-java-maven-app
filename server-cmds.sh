#!/usr/bin/env bash
set -e

source /etc/profile
source ~/.bash_profile || true

export IMAGE=$1
cd /home/ec2-user
docker-compose -f docker-compose.yaml down
docker-compose -f docker-compose.yaml up --detach
echo "success"