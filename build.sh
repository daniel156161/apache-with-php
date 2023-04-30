#!/bin/bash
source "../build-functions.sh"
source "../build-config.sh"

DOCKER_IMAGE_NAME="daniel156161/apache-php"

function run_docker_container {
  echo "Running..."
  docker run -dp 80:80 \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -v "$PWD":/var/www/html/ \
    "$DOCKER_IMAGE_NAME:$GIT_BRANCH"
}

case "$1" in
  run)
    run_docker_container
    ;;
  build)
    build_docker_image "$DOCKER_IMAGE_NAME:$GIT_BRANCH"
    ;;
  *)
    echo "Usage: $0 {run|build}"
    exit 1
    ;;
esac
