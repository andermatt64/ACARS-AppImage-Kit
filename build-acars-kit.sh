#!/bin/bash

BUILDER_TAG_NAME=acars-appimage-builder

docker build -f builder/Dockerfile . -t  ${BUILDER_TAG_NAME}
[ ! -d "$(pwd)/export" ] && mkdir $(pwd)/export
docker run -it --rm -v $(pwd)/export:/export:Z ${BUILDER_TAG_NAME} bash /entrypoint.sh
docker rmi ${BUILDER_TAG_NAME}
