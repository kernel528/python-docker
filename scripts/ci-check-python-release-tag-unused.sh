#!/usr/bin/env sh
set -eu

: "${DRONE_BUILD_EVENT:?Drone build event is required}"
: "${DRONE_TAG:?Release tag is required}"
: "${DRONE_COMMIT_REF:?Git ref is required}"

if [ "$DRONE_BUILD_EVENT" != tag ] || [ "$DRONE_COMMIT_REF" != "refs/tags/$DRONE_TAG" ]; then
  printf '%s\n' 'Python release preflight requires its matching Git tag event.' >&2
  exit 1
fi

image_ref="kernel528/python:${DRONE_TAG}"
if manifest_output=$(docker manifest inspect "$image_ref" 2>&1); then
  printf 'Immutable Python release %s already exists; refusing to overwrite it.\n' "$image_ref" >&2
  exit 1
else
  case "$manifest_output" in
    *MANIFEST_UNKNOWN*|*"manifest unknown"*|*"no such manifest"*)
      printf 'Immutable Python release tag is unused: %s\n' "$image_ref"
      ;;
    *)
      printf 'Could not verify Python release tag availability: %s\n' "$manifest_output" >&2
      exit 1
      ;;
  esac
fi
