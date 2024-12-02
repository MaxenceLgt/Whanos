#! /bin/bash

LANGUAGE=()

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