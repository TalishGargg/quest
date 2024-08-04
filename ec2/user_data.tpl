#!/bin/bash
# Update the package repository
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Git
sudo yum install -y git

# Clone the application repository
git clone https://github.com/rearc/quest.git /home/ec2-user/quest
cd /home/ec2-user/quest

# Create Dockerfile
cat <<EOT > Dockerfile
FROM node:10
ENV SECRET_WORD="SOCK_PUPPET"
COPY ./quest/ /
RUN chmod +x /bin/*
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]
EOT

# Build Docker image
sudo docker build -t quest-app .

# Authenticate Docker to the ECR registry
aws ecr get-login-password --region ${aws_region} | sudo docker login --username AWS --password-stdin ${ecr_repo_url}

# Tag and push the Docker image to ECR
sudo docker tag quest-app:latest ${ecr_repo_url}:latest
sudo docker push ${ecr_repo_url}:latest
