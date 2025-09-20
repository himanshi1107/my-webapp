#!/bin/bash
set -xe
REGION="${region}"
PROJECT="${project}"

yum update -y
yum install -y docker ruby wget jq git

systemctl enable docker
systemctl start docker

# Install CodeDeploy agent
cd /tmp
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install -O ./install_codedeploy
chmod +x ./install_codedeploy
./install_codedeploy auto
systemctl enable codedeploy-agent || true
systemctl start codedeploy-agent || true

mkdir -p /opt/${PROJECT}
chown -R ec2-user:ec2-user /opt/${PROJECT}
