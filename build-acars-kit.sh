#!/bin/bash

BUILDER_TAG_NAME=acars-appimage-builder-deb

[ -d "$(pwd)/export" ] && rm -rf $(pwd)/export && \
  docker build -f deb-builder/Dockerfile . -t  ${BUILDER_TAG_NAME} && \
  mkdir $(pwd)/export && \
  docker run -it --rm -v $(pwd)/export:/export:Z ${BUILDER_TAG_NAME} bash /entrypoint.sh
  # docker rmi ${BUILDER_TAG_NAME}
