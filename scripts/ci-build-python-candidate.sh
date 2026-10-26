#!/usr/bin/env sh
set -eu

: "${DRONE_BUILD_NUMBER:?Drone build number is required}"
: "${DRONE_BUILD_EVENT:?Drone build event is required}"
: "${DRONE_BRANCH:?Drone branch is required}"
: "${DRONE_COMMIT_SHA:?Drone commit SHA is required}"

if [ "$DRONE_BUILD_EVENT" != push ] || [ "$DRONE_BRANCH" != 3.14 ]; then
  printf '%s\n' 'Python candidates are allowed only on pushes to the 3.14 maintenance branch.' >&2
  exit 1
fi

base_ref=$(awk '$1 == "FROM" && $2 ~ /^kernel528\/alpine:/ { print $2; exit }' Dockerfile)
base_tag=${base_ref##*:}
expected_alpine=${base_tag%_*}
python_version=$(awk '$1 == "ENV" && $2 == "PYTHON_VERSION" { print $3; exit }' Dockerfile)
image="localhost/python-candidate:${DRONE_BUILD_NUMBER}-${DRONE_COMMIT_SHA}"
candidate_tag="${python_version}-${base_tag}-drone-build-${DRONE_BUILD_NUMBER}-amd64"

if [ -z "$base_tag" ] || [ -z "$expected_alpine" ] || [ -z "$python_version" ]; then
  printf '%s\n' 'Could not determine the pinned Alpine base or Python version.' >&2
  exit 1
fi

attempt=0
until docker info >/dev/null 2>&1; do
  attempt=$((attempt + 1))
  if [ "$attempt" -ge 60 ]; then
    printf '%s\n' 'Docker-in-Docker service did not become ready.' >&2
    exit 1
  fi
  sleep 1
done

docker build --pull --no-cache --tag "$image" .
image_id=$(docker image inspect --format '{{.Id}}' "$image")
printf 'Python candidate image ID: %s\n' "$image_id"
printf 'Python candidate tag after publish: %s\n' "$candidate_tag"
scripts/ci-smoke-python-image.sh "$image_id" "$expected_alpine" "$python_version"

umask 077
printf '%s\n' "$image_id" > .drone-python-image-id
printf '%s\n' "$candidate_tag" > .drone-python-image-tag
printf '%s\n' "$DRONE_COMMIT_SHA" > .drone-python-commit
