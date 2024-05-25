#!/bin/bash

# SSH into the EC2 instance
ssh -i "ssh-private-key-id" ubuntu@ec2-54-236-40-11.compute-1.amazonaws.com << 'EOF'
  # Pull the Docker image
  sudo docker pull taukirattar/taukirapp

  # Run the Docker container
  docker run -d -p 80:80 taukirattar/taukirapp
EOF
