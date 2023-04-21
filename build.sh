#!/bin/bash

DOCKER_IMAGE_NAME="daniel156161/apache-php"
DOCKER_CONTAINER_NAME="apache"
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

run_docker_container() {
  echo "Running..."
  docker run -dp 80:80 \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -v "$PWD"/moodle:/var/www/html/ \
    moodlehq/moodle-php-apache:7.1
}

build_docker_image() {
  TAG="$1"

  echo "Building..."
  docker buildx build --push \
    --platform linux/amd64 \
    --tag "$DOCKER_IMAGE_NAME:$TAG" .
}

if [ "$GIT_BRANCH" == "master" ]; then
  GIT_BRANCH="latest"
fi

case "$1" in
  run)
    run_docker_container
    ;;
  build)
    build_docker_image "$GIT_BRANCH"
    ;;
  upload)
    build_docker_image "$GIT_BRANCH"
    docker push "$DOCKER_IMAGE_NAME:$GIT_BRANCH"
    ;;
  test)
    build_docker_image "$GIT_BRANCH"
    run_docker_container
    ;;
  *)
    echo "Usage: $0 {run|build|test|upload}"
    exit 1
    ;;
esac
