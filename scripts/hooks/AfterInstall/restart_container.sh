#!/bin/bash
set -xe
IMAGE_URI=$(jq -r '.[0].imageUri' /opt/myapp/imagedefinitions.json)
CONTAINER_NAME="myapp_container"

if docker ps -q --filter "name=$CONTAINER_NAME" | grep -q .; then
  docker stop $CONTAINER_NAME || true
  docker rm $CONTAINER_NAME || true
fi

docker run -d --name $CONTAINER_NAME -p 80:8080 --restart unless-stopped $IMAGE_URI
