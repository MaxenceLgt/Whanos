#! /bin/bash

LANGUAGE=()
DOCKER_USERNAME=
DOCKER_PASSWORD=

if [[ -f "Makefile" ]]; then
    LANGUAGE+=("c")
fi
if [[ $(find app -type f) == "app/main.bf" ]]; then
    LANGUAGE+=("befunge")
fi
if [[ -f "app/pom.xml" ]]; then
    LANGUAGE+=("java")
fi
if [[ -f "package.json" ]]; then
    LANGUAGE+=("javascript")
fi
if [[ -f "requirements.txt" ]]; then
    LANGUAGE+=("python")
fi

if [[ ${#LANGUAGE[@]} != 1 ]]; then
    echo "Repository not compatible with Whanos architecture."
    echo "Language detected : ${#LANGUAGE[@]}."
    exit 1
fi

if [[ -f "Dockerfile" ]]; then
    docker build . -t whanos-${LANGUAGE[0]}
else
    docker build . -f /images/${LANGUAGE[0]}/Dockerfile.standalone \
    -t whanos-${LANGUAGE[0]}
fi

docker login --username="$DOCKER_USERNAME" --password="$DOCKER_PASSWORD"
docker image tag whanos-${LANGUAGE[0]}:latest "$DOCKER_USERNAME"/whanos-${LANGUAGE[0]}:latest
docker push "$DOCKER_USERNAME"/whanos-${LANGUAGE[0]}
docker logout
