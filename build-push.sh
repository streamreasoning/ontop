#! /bin/bash

DOCKER_USERNAME=streamreasoning
DOCKER_IMAGE_NAME=ontop
DOCKER_IMAGE_TAG=latest

echo "Building Dockerimage..."
docker build -t ${DOCKER_IMAGE_NAME} . 
echo "Build succeded!"

read -p "Enter tag [latest]: " DOCKER_IMAGE_TAG
DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG:-latest}

echo "Tagging image as: " ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

read -p "Enter dockerhub username: " DOCKER_HUB_USERNAME
read -p "Enter dockerhub password: " DOCKER_HUB_PASSWORD
echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin

echo "Pushing image to dockerhub..."
docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}