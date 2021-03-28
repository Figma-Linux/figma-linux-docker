#!/bin/bash

# docker build -t 4tqrgqe5yrgfd/figma-linux-docker-image -f ./Dockerfile_amd64 .
# docker build -t 4tqrgqe5yrgfd/figma-linux-docker-image-arm .
# docker buildx build --platform linux/arm64 -t 4tqrgqe5yrgfd/figma-linux-docker-image --push .

docker buildx build --platform linux/arm64 -t 4tqrgqe5yrgfd/figma-linux-docker-image-arm --load -f ./Dockerfile_arm64v8 .