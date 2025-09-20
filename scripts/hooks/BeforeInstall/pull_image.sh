#!/bin/bash
set -xe
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
cd /opt/myapp || mkdir -p /opt/myapp && cd /opt/myapp

if [ -f imagedefinitions.json ]; then
  IMAGE_URI=$(jq -r '.[0].imageUri' imagedefinitions.json)
else
  echo "imagedefinitions.json not found" && exit 1
fi

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $(echo $IMAGE_URI | cut -d'/' -f1)
docker pull $IMAGE_URI
