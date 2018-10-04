#!/usr/bin/env bash

repo="${DOCKER_REPOSITORY}"

# Extract version number from release branch
if [[ ${1} = *"release-"* ]]; then
    version="${1#*release-}"
else
    version="${1:-}"
fi

# Check if we need to push images
if [ -z ${DOCKER_USERNAME+x} ]; then
    echo "No docker hub username  specified. Exiting without pushing images to registry"
    exit 1
fi
if [ -z ${DOCKER_PASSWORD+x} ]; then
    echo "No docker hub password specified. Exiting without pushing images to registry"
    exit 1
fi

# Push runtime images
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
for ARCH in amd64 armhf i386 aarch64; do
    old_tag="${ARCH}"
    new_tag="${version}-${ARCH}"
    docker tag "${repo}:${old_tag}" "${repo}:${new_tag}"
    docker push "${repo}:${TAG}"
done

latest_branch=$(git branch --remote | grep release | sort -r | head -n 1)

if [[ "${TRAVIS_BRANCH}" = "${latest_branch#*origin/}" ]]; then
    echo We are on latest release branch, push latest tag
    docker tag "${repo}:amd64" "${repo}:latest"
    docker push "${repo}:latest"
fi
