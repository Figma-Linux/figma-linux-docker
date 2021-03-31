#!/bin/bash

docker buildx build --platform linux/arm64 -t 4tqrgqe5yrgfd/figma-linux-docker-image-arm --load -f ./Dockerfile_arm64v8 .
