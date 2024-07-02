set -e
IMAGE_TAG=ethcomsec/hybridift:hybridift-main
echo building $IMAGE_TAG
# docker login registry-1.docker.io
docker build -f Dockerfile -t $IMAGE_TAG .
echo "To push image, do:"
echo "docker push $IMAGE_TAG"
