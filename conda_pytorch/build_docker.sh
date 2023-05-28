#!/bin/sh
export BASE_IMAGE=ubuntu:20.04
export CONDA_VERSION=2023.03-1
export CUDA_VERSION=11.7
export IMAGE_TAG=1.0

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg CONDA_VERSION=${CONDA_VERSION} \
    --build-arg CUDA_VERSION=${CUDA_VERSION} \
    -t shixiaozhou/pytorch:${IMAGE_TAG} \
    -f Dockerfile \
    .
