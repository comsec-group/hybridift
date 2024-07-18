# Copyright 2024 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

set -e
IMAGE_TAG=ethcomsec/hybridift:hybridift-artifacts
echo building $IMAGE_TAG
docker login registry-1.docker.io
docker build -f Dockerfile -t $IMAGE_TAG .
echo "To push image, do:"
echo "docker push $IMAGE_TAG"
