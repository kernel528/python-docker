#!/usr/bin/env sh
set -eu

image_id=${1:?Usage: ci-smoke-python-image.sh <image-id> <alpine-release> <python-version>}
expected_alpine=${2:?Usage: ci-smoke-python-image.sh <image-id> <alpine-release> <python-version>}
expected_python=${3:?Usage: ci-smoke-python-image.sh <image-id> <alpine-release> <python-version>}

actual_alpine=$(docker container run --rm "$image_id" cat /etc/alpine-release)
if [ "$actual_alpine" != "$expected_alpine" ]; then
  printf 'Alpine release mismatch: expected %s, got %s\n' "$expected_alpine" "$actual_alpine" >&2
  exit 1
fi

actual_python=$(docker container run --rm "$image_id" python --version 2>&1)
if [ "$actual_python" != "Python $expected_python" ]; then
  printf 'Python version mismatch: expected Python %s, got %s\n' "$expected_python" "$actual_python" >&2
  exit 1
fi

docker container run --rm "$image_id" python -c 'import sqlite3, ssl; print("sqlite3", sqlite3.sqlite_version); print("ssl", ssl.OPENSSL_VERSION)'
docker container run --rm "$image_id" python3 -c 'import sys; assert sys.version_info[:3] == tuple(map(int, sys.argv[1].split(".")))' "$expected_python"
docker container run --rm "$image_id" pip --version
printf 'Python smoke checks passed: Alpine %s, Python %s, ssl/sqlite3 imports, and pip.\n' \
  "$actual_alpine" "$expected_python"
