#!/bin/bash
set -xe
REGION="${REGION}"
PROJECT="${PROJECT}"

# Update packages
yum update -y

# Install required tools
yum install -y docker ruby wget jq git unzip

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Start & enable Docker
systemctl enable docker
systemctl start docker

# Install CodeDeploy agent (Amazon Linux 2)
cd /tmp
wget https://aws-codedeploy-${REGION}.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
systemctl enable codedeploy-agent || true
systemctl start codedeploy-agent || true

# Create project directory
mkdir -p /opt/${PROJECT}
chown -R ec2-user:ec2-user /opt/${PROJECT}

# Authenticate Docker to ECR
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --region ${REGION})
aws ecr get-login-password --region ${REGION} \
  | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
